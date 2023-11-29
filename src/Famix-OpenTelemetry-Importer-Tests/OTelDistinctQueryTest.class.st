"
An OTelDistinctQueryTest is a test class for testing the behavior of OTelDistinctQuery
"
Class {
	#name : #OTelDistinctQueryTest,
	#superclass : #OTelQueryTest,
	#category : #'Famix-OpenTelemetry-Importer-Tests'
}

{ #category : #tests }
OTelDistinctQueryTest >> testValue [

	| originalSize |
	originalSize := model size.

	(OTelDistinctQuery selector: [ :span | span name ]) value: model.

	self assert: model size equals: originalSize - 1
]
