"
An OTelSelectQueryTest is a test class for testing the behavior of OTelSelectQuery
"
Class {
	#name : #OTelSelectQueryTest,
	#superclass : #OTelQueryTest,
	#category : #'Famix-OpenTelemetry-Importer-Tests'
}

{ #category : #tests }
OTelSelectQueryTest >> testValue [

	| originalSize |
	originalSize := model size.

	(OTelSelectQuery selector: [ :span | span name = 'foo' ]) value:
		model.

	self deny: model size equals: originalSize.
	self assert: model size equals: 2
]
