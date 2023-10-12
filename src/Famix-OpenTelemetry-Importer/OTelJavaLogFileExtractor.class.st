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
		'sep'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #accessing }
OTelJavaLogFileExtractor >> any [

	^ any
]

{ #category : #extraction }
OTelJavaLogFileExtractor >> extract [
	
	^ (self parsingLogsOnV2: filename)
]

{ #category : #accessing }
OTelJavaLogFileExtractor >> filename [

	^ filename
]

{ #category : #accessing }
OTelJavaLogFileExtractor >> filename: anObject [

	filename := anObject asFileReference 
]

{ #category : #accessing }
OTelJavaLogFileExtractor >> idPP2 [

	^ idPP2
]

{ #category : #initialization }
OTelJavaLogFileExtractor >> initialize [

	any := #any asPParser.
	sep := ',' asPParser.

	traceIdPP2 := ('traceId=' asPParser , any starLazy flatten , sep) sea
	              ==> #second ==> #second.
	
	idPP2 := ('spanId=' asPParser , any starLazy flatten , sep) sea
	         ==> #second ==> #second.
	orderPP2 := ('drit.order=' asPParser , any starLazy flatten , sep)
		            sea ==> #second ==> #second.
	methodPP2 := ('drit.method=' asPParser , $" asPParser
	              , any starLazy flatten , $" asPParser) sea ==> #second
	             ==> #third.
	timestampPP2 := ('drit.timestamp=' asPParser
	                 , #digit asPParser star flatten) sea ==> #second
	                ==> #second.
	namePP2 := ('name=' asPParser , any starLazy flatten , sep) sea
	           ==> #second ==> #second
]

{ #category : #PP2 }
OTelJavaLogFileExtractor >> methodPP2 [

	^ methodPP2
]

{ #category : #PP2 }
OTelJavaLogFileExtractor >> namePP2 [

	^ namePP2
]

{ #category : #PP2 }
OTelJavaLogFileExtractor >> orderPP2 [

	^ orderPP2
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseId: aString [

	^ self parsing: aString FromString: 'spanId=' to: ','
]

{ #category : #PP2 }
OTelJavaLogFileExtractor >> parseIdPP2: aString [

	^ idPP2 parse: aString
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseLog: line [

	| dic |
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

	dic at: #traceId put: (self parseTraceID: line).
	dic at: #id put: (self parseId: line).
	dic at: #parentId put: (self parseParentId: line).
	dic at: #timestamp put: (self parseTimestamp: line).
	dic at: #name put: (self parseName: line).
	(dic at: #tags) at: 'drit.order' ifAbsentPut: (self parseOrder: line).
	(dic at: #tags)
		at: 'drit.method'
		ifAbsentPut: (self parseMethod: line).


	^ dic
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseMethod: aString [

	^ self parsing: aString FromString: 'drit.method="' to: '"'
]

{ #category : #PP2 }
OTelJavaLogFileExtractor >> parseMethodPP2: aString [

	^ methodPP2 parse: aString
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseName: aString [

	^ self parsing: aString FromString: 'name=' to: ','
]

{ #category : #PP2 }
OTelJavaLogFileExtractor >> parseNamePP2: aString [

	^ namePP2  parse: aString
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseOrder: aString [

	^ self parsing: aString FromString: 'drit.order=' to: ','
]

{ #category : #PP2 }
OTelJavaLogFileExtractor >> parseOrderPP2: aString [

	^ orderPP2 parse: aString
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseParentId: aString [

	| from subString |
	
	from := aString
		        indexOfSubCollection: 'spanId='
		        startingAt:
		        (aString indexOfSubCollection: 'parentSpanContext')
		        ifAbsent: 'nil'.
	subString := aString copyFrom: from - 1 to: aString size.
	from ifNil: [ ^ nil ].

	^ self parsing: subString FromString: 'spanId=' to: ','
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseTimestamp: aString [

	^ self parsing: aString FromString: 'drit.timestamp=' to: '}'
]

{ #category : #PP2 }
OTelJavaLogFileExtractor >> parseTimestampPP2: aString [

	^ timestampPP2 parse: aString
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseTraceID: aString [

	^ self parsing: aString FromString: 'traceId='  to: ','.
]

{ #category : #PP2 }
OTelJavaLogFileExtractor >> parseTraceIDPP2: aString [

	^ traceIdPP2 parse: aString
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parsing: aString FromString: begins to: ends [

	| start end |
	start := (aString findString: begins) + begins size.
	end := (aString indexOfAnyOf: ends startingAt: start) - 1.

	^ aString copyFrom: start to: end
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parsingLogsLines: stream [

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
OTelJavaLogFileExtractor >> parsingLogsOn: aFileReference [

	| array stream line res |
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

	^ self parsingLogsLines: aFileReference readStream.
]

{ #category : #accessing }
OTelJavaLogFileExtractor >> sep [

	^ sep
]

{ #category : #PP2 }
OTelJavaLogFileExtractor >> timestampPP2 [

	^ timestampPP2
]

{ #category : #PP2 }
OTelJavaLogFileExtractor >> traceIdPP2 [

	^ traceIdPP2
]
