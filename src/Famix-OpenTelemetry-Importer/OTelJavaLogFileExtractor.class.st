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

	^ self parsingLogsOn: filename
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
	namePP2 := ('name=' asPParser , any starLazy flatten , sep) sea ==> #second
			 ==> #second.
]

{ #category : #accessing }
OTelJavaLogFileExtractor >> methodPP2 [

	^ methodPP2
]

{ #category : #accessing }
OTelJavaLogFileExtractor >> namePP2 [

	^ namePP2
]

{ #category : #accessing }
OTelJavaLogFileExtractor >> orderPP2 [

	^ orderPP2
]

{ #category : #parsing }
OTelJavaLogFileExtractor >> parseLog: line [

	| dic |
	dic := Dictionary new.

	dic at: #duration ifAbsentPut: nil.
	dic at: #localEndPoint ifAbsentPut: Dictionary new.
	dic at: #timestamp ifAbsentPut: nil.
	dic at: #traceId ifAbsentPut: nil.
	dic at: #name ifAbsentPut: nil.
	dic at: #id ifAbsentPut: nil.
	dic at: #tags ifAbsentPut: Dictionary new.


	dic at: #traceId put: (self traceIdPP2 parse: line).

	dic at: #id put: (idPP2 parse: line).

	dic at: #timestamp put: (timestampPP2 parse: line).

	dic at: #name put: (namePP2 parse: line).

	(dic at: #tags) at: 'drit.order' ifAbsentPut: (orderPP2 parse: line).

	(dic at: #tags)
		at: 'drit.method'
		ifAbsentPut: (methodPP2 parse: line).


	^ dic
]

{ #category : #'as yet unclassified' }
OTelJavaLogFileExtractor >> parsingLogsOn: aFileReference [

	| array stream line |

	array := OrderedCollection new.
	stream := aFileReference readStream.
	line := stream nextLine.
	[ line isNotNil ] whileTrue: [ 
		array add: (self parseLog: line).
		line := stream nextLine ].
	^ array
]

{ #category : #accessing }
OTelJavaLogFileExtractor >> sep [

	^ sep
]

{ #category : #accessing }
OTelJavaLogFileExtractor >> timestampPP2 [

	^ timestampPP2
]

{ #category : #accessing }
OTelJavaLogFileExtractor >> traceIdPP2 [

	^ traceIdPP2
]
