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
OTelZipkinLoader >> load: traces [

	"Instantiate trace model from Zipkin data."

	| spanEntity traceEntity context |
	self model.
	entityDict := entityDict ifNil: [ Dictionary new: traces size ].
	traces do: [ :trace | "load parent before children"
		trace reverseDo: [ :span | 
			spanEntity := self loadSpan: span.
			traceEntity := self loadTrace: span.
			context := self loadContext: span.
			spanEntity trace: traceEntity.
			spanEntity context: context.
			traceEntity addContext: context ] ].
	^ model
]

{ #category : #'private - loading' }
OTelZipkinLoader >> loadContext: span [

	| ctxData serviceName |
	ctxData := span at: 'localEndpoint'.
	serviceName := ctxData at: 'serviceName'.
	^ entityDict at: serviceName ifAbsentPut: [ 
		  self newContext
			  name: serviceName;
			  data: ctxData ]
]

{ #category : #'private - loading' }
OTelZipkinLoader >> loadSpan: span [

	| spanEntity |
	spanEntity := self newSpan
		              id: (span at: 'id');
		              name: (span at: 'name');
		              tags: (span at: 'tags');
		              timestamp: (span at: 'timestamp');
		              duration: (span at: 'duration').
	span
		at: 'parentId'
		ifPresent: [ :pid | spanEntity parent: (entityDict at: pid) ].
	^ entityDict at: spanEntity id put: spanEntity
]

{ #category : #'private - loading' }
OTelZipkinLoader >> loadTrace: span [

	^ span
		  at: 'traceId'
		  ifPresent: [ :tid | 
		  entityDict at: tid ifAbsentPut: [ self newTrace id: tid ] ]
]
