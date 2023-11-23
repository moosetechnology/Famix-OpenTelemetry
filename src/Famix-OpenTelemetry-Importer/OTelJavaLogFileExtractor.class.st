Class {
	#name : #OTelJavaLogFileExtractor,
	#superclass : #OTelAbstractExtractor,
	#instVars : [
		'filename',
		'traceIdPP2',
		'idPP2',
		'timestampPP2',
		'namePP2',
		'methodPP2',
		'orderPP2',
		'any',
		'sep',
		'lastIndex'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #accessing }
OTelJavaLogFileExtractor >> any [

	^ any
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> debuggingParsingFirstLines: maxLines ofStream: stream [
	"parse the frist lines of a stream. Use it to test the extract on large file"

	| array line res limit |
	array := OrderedCollection new.
	line := stream nextLine.
	limit := 1.
	[ limit <= maxLines and: [ line isNotNil ] ] whileTrue: [ "array add: (self parseLog: line)."
		array add: line.
		line := stream nextLine.
		limit := limit + 1 ].

	res := OrderedCollection new.
	res add: array.
	^ res
]

{ #category : #extraction }
OTelJavaLogFileExtractor >> extract [

	^ self parsingLogsOnV2: filename
]

{ #category : #accessing }
OTelJavaLogFileExtractor >> filename [

	^ filename
]

{ #category : #accessing }
OTelJavaLogFileExtractor >> filename: anObject [

	filename := anObject asFileReference
]

{ #category : #initialization }
OTelJavaLogFileExtractor >> initialize [

	lastIndex := 0
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseId: aString [

	^ self parsing: aString FromString: ' ' to: ' '
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseLog: line [

	| dic subLine |
	dic := Dictionary new.

	dic at: #duration ifAbsentPut: nil.
	dic
		at: #localEndpoint
		ifAbsentPut: { (#serviceName -> 'java-log-service') } asDictionary.

	dic at: #timestamp ifAbsentPut: nil.
	dic at: #traceId ifAbsentPut: nil.
	dic at: #name ifAbsentPut: nil.
	dic at: #id ifAbsentPut: nil.
	dic at: #tags ifAbsentPut: Dictionary new.
	dic at: #parentId ifAbsentPut: nil.

	"info in span metadata "
	dic at: #name put: (self parseName: line).

	subLine := line copyFrom: lastIndex to: line size.
	dic at: #traceId put: (self parseTraceID: subLine).
	subLine := subLine copyFrom: lastIndex to: subLine size.
	dic at: #id put: (self parseId: subLine).

	"info thing in span attribut"
	dic at: #parentId put: (self parseParentId: line).
	dic at: #timestamp put: (self parseTimestamp: line).
	(dic at: #tags) at: 'drit.order' ifAbsentPut: (self parseOrder: line).
	(dic at: #tags)
		at: 'drit.stackcall'
		ifAbsentPut: (self parseStackcall: line).
	(dic at: #tags)
		at: 'drit.method'
		ifAbsentPut: (self parseMethod: line).
	(dic at: #tags)
		at: 'thread.id'
		ifAbsentPut: (self parseThreadID: line).


	^ dic
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseMethod: aString [

	^ self parsing: aString FromString: 'drit.method="' to: '"'
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseName: aString [

	^ self parsing: aString FromString: '''' to: ''' : '
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseOrder: aString [

	^ self parsing: aString FromString: 'drit.order=' to: ','
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseParentId: aString [

	^ self parsing: aString FromString: 'drit.parentId="' to: '"'
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseStackcall: aString [

	^ self parsing: aString FromString: 'drit.stackcall=||>|' to: '|<||'
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseThreadID: aString [

	^ self parsing: aString FromString: 'thread.id=' to: ','
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseTimestamp: aString [

	^ self parsing: aString FromString: 'drit.timestamp=' to: '}'
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseTraceID: aString [

	^ self parsing: aString FromString: ' ' to: ' '
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parsing: aString FromString: begins to: ends [

	| start end |
	start := aString findString: begins.

	"if the string begins is not found, return nil"
	start = 0 ifTrue: [ ^ nil ].

	start := start + begins size.

	end := (aString indexOfSubCollection: ends startingAt: start) - 1.
	lastIndex := end + ends size.
	^ aString copyFrom: start to: end
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parsingAllLogLines: stream [

	| array line res |
	array := OrderedCollection new.
	line := stream nextLine.
	[ line isNotNil ] whileTrue: [
		array add: (self parseLog: line).
		line := stream nextLine ].

	res := OrderedCollection new.
	res add: array.
	^ res
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parsingFirstLines: maxLines ofStream: stream [
	"parse the frist lines of a stream. Use it to test the extract on large file"

	| array line res limit |
	array := OrderedCollection new.
	line := stream nextLine.
	limit := 1.
	[ limit <= maxLines and: [ line isNotNil ] ] whileTrue: [
		array add: (self parseLog: line).
		line := stream nextLine.
		limit := limit + 1 ].

	res := OrderedCollection new.
	res add: array.
	^ res
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parsingLogsOn: aFileReference [

	| array stream line res |
	self
		deprecated: 'Use #parsingLogsOnV2: instead'
		on: '13 October 2023'
		in:
		'Pharo-10.0.0+build.538.sha.179ef655ae2b150009a860b127aa3605366659ca (64 Bit)'.
	array := OrderedCollection new.
	stream := aFileReference readStream.
	line := stream nextLine.
	[ line isNotNil ] whileTrue: [
		array add: (self parseLog: line).
		line := stream nextLine ].

	res := OrderedCollection new.
	res add: array.
	^ res
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parsingLogsOnV2: aFileReference [

	^ self parsingAllLogLines: aFileReference readStream
]
