Class {
	#name : #OTelSTONFileLoader,
	#superclass : #OTelAbstractLoader,
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #loading }
OTelSTONFileLoader >> load: rawTraces [

	rawTraces do: [ :rawSpan |
		| span |
		span := self loadSpan: rawSpan ].
	^ self model
]

{ #category : #'private - loading' }
OTelSTONFileLoader >> loadSpan: anOTSpan [

	^ self model newSpan
		  id: anOTSpan spanId;
		  name: anOTSpan name;
		  tags: anOTSpan attributes;
		  timestamp: anOTSpan startTime;
		  duration: anOTSpan endTime - anOTSpan startTime
]
