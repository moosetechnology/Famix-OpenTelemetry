"
I am an OpenTelemetry trace importer working on the Extract-Load-Transform (ELT) principle, essentially making me a configurable pipeline.
Extract: retrieve traces that are usually stored in files or in an aggregator's database.
Load: instantiate trace model.
Transform: process the model with actions such as filtering or linking to another model.
"
Class {
	#name : #OpenTelemetryImporter,
	#superclass : #Object,
	#instVars : [
		'extractor',
		'loader',
		'transformers'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #'as yet unclassified' }
OpenTelemetryImporter class >> importFromJavaLogFile: aFilePath [

	^ OpenTelemetryImporter new
		  extractor: (OTelJavaLogFileExtractor new filename: aFilePath);
		  loader: OTelJavaLogFileLoader new;
		  import
]

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

	"Import traces into a model using the configured extractor, loader and transformers."

	| data |
	data := extractor extract. "obtain raw data"
	data := loader load: data. "data becomes model"
	self transformers do: [ :transformer | 
		data := transformer value: data ].
	^ data
]

{ #category : #accessing }
OpenTelemetryImporter >> loader [

	^ loader
]

{ #category : #accessing }
OpenTelemetryImporter >> loader: anObject [

	loader := anObject
]

{ #category : #accessing }
OpenTelemetryImporter >> transformers [

	^ transformers ifNil: [ transformers := {  } ]
]

{ #category : #accessing }
OpenTelemetryImporter >> transformers: aCollection [

	transformers := aCollection
]
