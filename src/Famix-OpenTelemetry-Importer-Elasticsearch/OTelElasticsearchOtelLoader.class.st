"
This loader is dedicated to data collected using a OtelCollector and sent to Elasticsearch
"
Class {
	#name : #OTelElasticsearchOtelLoader,
	#superclass : #OTelAbstractLoader,
	#category : #'Famix-OpenTelemetry-Importer-Elasticsearch'
}

{ #category : #loading }
OTelElasticsearchOtelLoader >> buildParent: rawSpans [

	rawSpans do: [ :rawSpan | 
		rawSpan at: #ParentSpanId ifPresent: [ :parent | 
			| childSpan |
			childSpan := self model allSpans detect: [ :span | 
				             span id = (self idOfSpan: rawSpan) ].
			self model allSpans
				detect: [ :span | span id = parent ]
				ifOne: [ :parentSpan | parentSpan addChildren: childSpan ] ] ]
]

{ #category : #loading }
OTelElasticsearchOtelLoader >> buildSpan: aSpan [

	| span |
	span := self model newSpan.
	span id: (self idOfSpan: aSpan).
	span name: (self nameOfSpan: aSpan).
	span
		timestamp: (DateAndTime fromString: (aSpan at: '@timestamp'));
		duration: (aSpan at: 'Duration');
		tags: (aSpan at: 'Attributes').
	^ span
]

{ #category : #'private-accessing' }
OTelElasticsearchOtelLoader >> idOfSpan: aSpan [
	^ aSpan at: #SpanId
]

{ #category : #loading }
OTelElasticsearchOtelLoader >> load: rawTraces [

	"Instantiate trace model from raw data."

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

	| serviceName |
	serviceName := (aTrace at: 'Resource' at: 'service') at: 'name'.
	^ self model entityStorage
		  detect: [ :c | c isContext and: [ c name = serviceName ] ]
		  ifNone: [ self model newContext name: serviceName ]
]

{ #category : #loading }
OTelElasticsearchOtelLoader >> retrieveTrace: aTrace [

	^ self model entityStorage
		  detect: [ :t | t isTrace and: [ t id = (aTrace at: #TraceId) ] ]
		  ifNone: [ self model newTrace id: (aTrace at: #TraceId) ]
]
