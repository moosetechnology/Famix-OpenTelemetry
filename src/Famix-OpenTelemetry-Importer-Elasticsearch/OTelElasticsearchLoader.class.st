Class {
	#name : #OTelElasticsearchLoader,
	#superclass : #OTelAbstractLoader,
	#instVars : [
		'api'
	],
	#category : #'Famix-OpenTelemetry-Importer-Elasticsearch'
}

{ #category : #loading }
OTelElasticsearchLoader >> buildParent: rawTraces [

	rawTraces do: [ :rawTrace | 
		rawTrace parent ifNotNil: [ :parent | 
			| childSpan |
			childSpan := (self model allWithType: FamixOTelSpan) detect: [ 
				             :span | span id = (self idOfSpan: rawTrace) ].
			(self model allWithType: FamixOTelSpan)
				detect: [ :span | span id = parent id ]
				ifOne: [ :parentSpan | 
					parentSpan addChildren: childSpan ] ] ]
]

{ #category : #loading }
OTelElasticsearchLoader >> buildSpan: aSpan [

	| span |
	span := self newSpan.
	aSpan span ifNotNil: [ 
		span
			name: aSpan span name;
			duration: aSpan span duration us ].
	span id: (self idOfSpan: aSpan).
	span
		timestamp: (DateAndTime fromString: (aSpan at: #'@timestamp'));
		tags: aSpan labels asDictionary.
	^ span
]

{ #category : #'private-accessing' }
OTelElasticsearchLoader >> idOfSpan: aSpan [
	^ (((aSpan at: #transaction) ifNil: [ aSpan at: #span ]) at: #id)
]

{ #category : #loading }
OTelElasticsearchLoader >> load: rawTraces [

	"Instantiate trace model from raw data."

	self model.
	rawTraces do: [ :rawTrace | 
		| trace |
		trace := self retrieveTrace: rawTrace.
		trace addSpan: (self buildSpan: rawTrace) ].
	self buildParent: rawTraces.
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
