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

	| spanEntity traceEntity |
	"lazy initialize"
	self model.
	entityDict := entityDict ifNil: [ Dictionary new: traces size ].

	traces do: [ :trace | "load parent before children"
		trace reverseDo: [ :span | 
			spanEntity := self loadSpan: span.
			traceEntity := self loadTrace: span of: spanEntity.
			self loadTraceContext: span of: traceEntity ] ].
	^ model
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
	entityDict at: spanEntity id put: spanEntity.
	^ spanEntity
]

{ #category : #'private - loading' }
OTelZipkinLoader >> loadTrace: span of: spanEntity [

	^ span at: 'traceId' ifPresent: [ :tid | 
		  (entityDict at: tid ifAbsentPut: [ self newTrace id: tid ])
			  addSpan: spanEntity;
			  yourself ]
]

{ #category : #'private - loading' }
OTelZipkinLoader >> loadTraceContext: span of: traceEntity [

	| serviceName |
	serviceName := span at: 'localEndpoint' at: 'serviceName'.
	^ traceEntity contexts
		  detect: [ :ctx | ctx name = serviceName ]
		  ifNone: [ 
			  traceEntity addContext: (self newTraceContext
					   name: serviceName;
					   data: (span at: 'localEndpoint')) ]
]
