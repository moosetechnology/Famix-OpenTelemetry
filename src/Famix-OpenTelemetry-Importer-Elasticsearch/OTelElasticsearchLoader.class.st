"
This loader is dedicated to traces that have been collected using an APM Server
"
Class {
	#name : #OTelElasticsearchLoader,
	#superclass : #OTelAbstractLoader,
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
				ifOne: [ :parentSpan | parentSpan addChildren: childSpan ] ] ]
]

{ #category : #loading }
OTelElasticsearchLoader >> buildSpan: aSpan [

	| span |
	span := self model newSpan.
	aSpan span ifNotNil: [ span duration: aSpan span duration us ].
	span id: (self idOfSpan: aSpan).
	span name: (self nameOfSpan: aSpan).
	span
		timestamp: (DateAndTime fromString: (aSpan at: #'@timestamp'));
		tags: aSpan labels asDictionary.
	^ span
]

{ #category : #'private-accessing' }
OTelElasticsearchLoader >> idOfSpan: aSpan [

	^ ((aSpan at: #transaction) ifNil: [ aSpan at: #span ]) at: #id
]

{ #category : #loading }
OTelElasticsearchLoader >> load: rawTraces [

	"Instantiate trace model from raw data."

	self model.
	rawTraces do: [ :rawTrace | 
		| trace span context |
		context := self retrieveContext: rawTrace.
		trace := self retrieveTrace: rawTrace.
		span := self buildSpan: rawTrace.
		trace addSpan: span.
		context addTrace: trace.
		context addSpan: span ].
	self buildParent: rawTraces.
	^ self model
]

{ #category : #'private-accessing' }
OTelElasticsearchLoader >> nameOfSpan: aSpan [

	^ ((aSpan at: #transaction) ifNil: [ aSpan at: #span ]) at: #name
]

{ #category : #loading }
OTelElasticsearchLoader >> retrieveContext: aTrace [

	^ self model entityStorage
		  detect: [ :c | 
			  (c isKindOf: FamixOTelContext) and: [ 
				  c name = (aTrace at: #service) name ] ]
		  ifNone: [ self model newContext name: (aTrace at: #service) name ]
]

{ #category : #loading }
OTelElasticsearchLoader >> retrieveTrace: aTrace [

	^ self model entityStorage
		  detect: [ :t | 
			  (t isKindOf: FamixOTelTrace) and: [ 
				  t id = (aTrace at: #trace) id ] ]
		  ifNone: [ self model newTrace id: (aTrace at: #trace) id ]
]
