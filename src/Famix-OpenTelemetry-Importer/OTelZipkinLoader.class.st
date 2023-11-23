"
I load a model from Zipkin data.
"
Class {
	#name : #OTelZipkinLoader,
	#superclass : #OTelAbstractLoader,
	#instVars : [
		'entityDict'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #loading }
OTelZipkinLoader >> load: rawTraces [
	"Instantiate trace model from Zipkin data."

	| span trace context |
	entityDict := entityDict ifNil: [ Dictionary new: rawTraces size ].
	rawTraces do: [ :rawTrace | "load parent before children"
		rawTrace reverseDo: [ :rawSpan |
			span := self loadSpan: rawSpan.
			trace := self loadTrace: rawSpan.
			context := self loadContext: rawSpan.
			span context: context.
			span trace: trace.
			trace contexts
				detect: [ :ctx | ctx name = context name ]
				ifNone: [ trace addContext: context ] ] ].
	^ self model
]

{ #category : #'private - loading' }
OTelZipkinLoader >> loadContext: rawSpan [

	| ctxData serviceName |
	ctxData := rawSpan at: 'localEndpoint'.
	serviceName := ctxData at: 'serviceName'.
	^ entityDict at: serviceName ifAbsentPut: [
		  self model newContext
			  name: serviceName;
			  data: ctxData ]
]

{ #category : #'private - loading' }
OTelZipkinLoader >> loadSpan: rawSpan [

	| span |
	span := self model newSpan
		        id: (rawSpan at: 'id');
		        name: (rawSpan at: 'name');
		        tags: (rawSpan at: 'tags');
		        timestamp: (rawSpan at: 'timestamp');
		        duration: (rawSpan at: 'duration').
	rawSpan
		at: 'parentId'
		ifPresent: [ :pid | span parent: (entityDict at: pid) ].
	^ entityDict at: span id put: span
]

{ #category : #'private - loading' }
OTelZipkinLoader >> loadTrace: rawSpan [

	^ rawSpan at: 'traceId' ifPresent: [ :tid |
		  entityDict at: tid ifAbsentPut: [ self model newTrace id: tid ] ]
]
