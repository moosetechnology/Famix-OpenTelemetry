"
I am an OpenTelemetry trace importer working on the Extract-Transform-Load (ETL) principle, essentially making me a configurable pipeline.
Extract: retrieve traces that are usually stored in files or in an aggregator's database.
Transform: some intermediate actions can be executed, such as cleaning or filtering.
Load: instantiate trace model.
I run an additional transformation step after loading to modify the model.
"
Class {
	#name : #OpenTelemetryImporter,
	#superclass : #Object,
	#instVars : [
		'extractor',
		'preTransformers',
		'postTransformers'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #accessing }
OpenTelemetryImporter >> extractor [

	^ extractor
]

{ #category : #accessing }
OpenTelemetryImporter >> extractor: anExtractor [

	extractor := anExtractor
]

{ #category : #importing }
OpenTelemetryImporter >> import [

	"Import traces into a model using the configured extractor and transformers."

	| data transformation |
	data := extractor extract. "obtain raw data"
	transformation := [ :transformer | data := transformer value: data ].

	self preTransformers do: transformation.
	data := self load: data. "data becomes model"
	self postTransformers do: transformation.
	^ data
]

{ #category : #'private - loading' }
OpenTelemetryImporter >> load: traces [

	"Instantiate trace model from raw data."

	| model entityDict spanEntity |
	model := FamixOTelModel new.
	entityDict := Dictionary new: traces size.
	traces do: [ :trace | "load parent before children"
		trace reverseDo: [ :span | 
			spanEntity := FamixOTelSpan new
				              id: (span at: 'id');
				              name: (span at: 'name');
				              tags: (span at: 'tags');
				              timestamp: (span at: 'timestamp');
				              duration: (span at: 'duration').
			span
				at: 'parentId'
				ifPresent: [ :pid | spanEntity parent: (entityDict at: pid) ].
			span at: 'traceId' ifPresent: [ :tid | 
				(entityDict at: tid ifAbsentPut: [ 
					 model add: (FamixOTelTrace new
							  id: tid;
							  name: (span at: 'localEndpoint' at: 'serviceName')) ]) 
					addSpan: spanEntity ].
			entityDict at: spanEntity id put: spanEntity.
			model add: spanEntity ] ].
	^ model
]

{ #category : #accessing }
OpenTelemetryImporter >> postTransformers [

	^ postTransformers ifNil: [ postTransformers := {  } ]
]

{ #category : #accessing }
OpenTelemetryImporter >> postTransformers: anObject [

	postTransformers := anObject
]

{ #category : #accessing }
OpenTelemetryImporter >> preTransformers [

	^ preTransformers ifNil: [ preTransformers := {  } ]
]

{ #category : #accessing }
OpenTelemetryImporter >> preTransformers: aCollection [

	preTransformers := aCollection
]
