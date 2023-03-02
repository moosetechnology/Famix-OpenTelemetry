"
This loader is dedicated to data collected using a OtelCollector and sent to Elasticsearch
"
Class {
	#name : #OTelElasticsearchOtelLoader,
	#superclass : #OTelAbstractLoader,
	#instVars : [
		'api'
	],
	#category : #'Famix-OpenTelemetry-Importer-Elasticsearch'
}

{ #category : #loading }
OTelElasticsearchOtelLoader >> buildParent: rawSpans [

	rawSpans do: [ :rawSpan | 
		(rawSpan at: #ParentSpanId) ifNotNil: [ :parent | 
			| childSpan |
			childSpan := (self model allWithType: FamixOTelSpan) detect: [ 
				             :span | span id = (self idOfSpan: rawSpan) ].
			(self model allWithType: FamixOTelSpan)
				detect: [ :span | span id = parent ]
				ifOne: [ :parentSpan | 
					parentSpan addChildren: childSpan ] ] ]
]

{ #category : #loading }
OTelElasticsearchOtelLoader >> buildSpan: aSpan [

	| span |
	span := self newSpan.
	span id: (self idOfSpan: aSpan).
	span name: (self nameOfSpan: aSpan).
	span
		timestamp: (DateAndTime fromString: (aSpan at: #'@timestamp'));
		tags: (aSpan associations
				 select: [ :assoc | assoc key beginsWith: #Attributes ]
				 thenCollect: [ :assoc | 
					 (assoc key withoutPrefix: #'Attributes.') -> assoc value ])
				asDictionary.
	^ span
]

{ #category : #'private-accessing' }
OTelElasticsearchOtelLoader >> idOfSpan: aSpan [
	^ aSpan at: #SpanId
]

{ #category : #loading }
OTelElasticsearchOtelLoader >> load: rawTraces [

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
OTelElasticsearchOtelLoader >> nameOfSpan: aSpan [
	^ aSpan at: #Name
]

{ #category : #loading }
OTelElasticsearchOtelLoader >> retrieveContext: aTrace [
	^ self model entityStorage
		  detect: [ :c | 
			  (c isKindOf: FamixOTelContext) and: [ 
				  c name = (aTrace at: #'Resource.service.name') ] ]
		  ifNone: [ self newContext name: (aTrace at: #'Resource.service.name') ]
]

{ #category : #loading }
OTelElasticsearchOtelLoader >> retrieveTrace: aTrace [

	^ self model entityStorage
		  detect: [ :t | 
			  (t isKindOf: FamixOTelTrace) and: [ 
				  t id = (aTrace at: #TraceId) ] ]
		  ifNone: [ self newTrace id: (aTrace at: #TraceId) ]
]
