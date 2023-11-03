Class {
	#name : #OTelJavaLogFileLoader,
	#superclass : #OTelAbstractLoader,
	#instVars : [
		'entityDict'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #loading }
OTelJavaLogFileLoader >> load: rawTraces [

	"Instantiate trace model from raw data."

	| span trace context |
	entityDict := entityDict ifNil: [ Dictionary new: rawTraces size ].

	trace := self loadTrace: rawTraces anyOne anyOne.
	context := self loadContext: rawTraces anyOne anyOne.

	rawTraces do: [ :rawTrace | "load parent before children"
		rawTrace do: [ :rawSpan | 
			span := self loadSpan: rawSpan.
 ] ].


	trace spans: (model allWithType: FamixOTelSpan).
	context spans: (model allWithType: FamixOTelSpan).
	trace contexts
		detect: [ :ctx | ctx name = context name ]
		ifNone: [ trace addContext: context ].

	^ self model
]

{ #category : #'private - loading' }
OTelJavaLogFileLoader >> loadContext: rawSpan [

	| ctxData serviceName |

	ctxData := rawSpan at: 'localEndpoint'.
	serviceName := ctxData at: 'serviceName'.
	^ entityDict at: serviceName ifAbsentPut: [ 
		  self model newContext
			  name: serviceName;
			  data: ctxData ]
]

{ #category : #'private - loading' }
OTelJavaLogFileLoader >> loadSpan: rawSpan [

	| span |
	span := self model newSpan
		        id: (rawSpan at: 'id');
		        name: (rawSpan at: 'name');
		        tags: (rawSpan at: 'tags');
		        timestamp: (rawSpan at: 'timestamp');
		        duration: (rawSpan at: 'duration').
	rawSpan
		at: 'parentId'
		ifPresent: [ :pid |  (pid = '0000000000000000') ifTrue: [	span parent: nil ] ifFalse:[ span parent: (entityDict at: pid)] ].
	^ entityDict at: span id put: span
]

{ #category : #'private - loading' }
OTelJavaLogFileLoader >> loadTrace: rawSpan [

	^ rawSpan at: 'traceId' ifPresent: [ :tid | 
		  entityDict at: tid ifAbsentPut: [ self model newTrace id: tid ] ]
]
