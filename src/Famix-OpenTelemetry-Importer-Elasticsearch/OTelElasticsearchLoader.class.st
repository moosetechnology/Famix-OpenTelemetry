Class {
	#name : #OTelElasticsearchLoader,
	#superclass : #OTelAbstractLoader,
	#instVars : [
		'api'
	],
	#category : #'Famix-OpenTelemetry-Importer-Elasticsearch'
}

{ #category : #loading }
OTelElasticsearchLoader >> buildSpan: aSpan [

	^ self newSpan
		  name: aSpan name;
		  id: aSpan id;
		  duration: aSpan duration us
]

{ #category : #loading }
OTelElasticsearchLoader >> load: rawTraces [

	"Instantiate trace model from raw data."

	self model.
	rawTraces do: [ :rawTrace | 
		| trace |
		trace := self retrieveTrace: rawTrace.
		rawTrace span ifNotNil: [ :aSpan | 
			trace addSpan: (self buildSpan: rawTrace span) ] ].
	^ self model
]

{ #category : #loading }
OTelElasticsearchLoader >> retrieveTrace: aTrace [

	^ self model entityStorage
		  detect: [ :t | 
			  (t isKindOf: FamixOTelTrace) and: [ 
				  t id = (aTrace at: #trace) id ] ]
		  ifNone: [ self newTrace id: (aTrace at: #trace) id ]
]
