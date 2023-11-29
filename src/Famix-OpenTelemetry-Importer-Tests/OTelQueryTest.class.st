Class {
	#name : #OTelQueryTest,
	#superclass : #TestCase,
	#instVars : [
		'model',
		'childSpan'
	],
	#category : #'Famix-OpenTelemetry-Importer-Tests'
}

{ #category : #testing }
OTelQueryTest class >> isAbstract [

	^ self == OTelQueryTest
]

{ #category : #running }
OTelQueryTest >> setUp [

	super setUp.
	model := FamixOTelModel new.
	model newSpan name: 'foo'.
	(childSpan := model newSpan name: 'child') parent:
		(model newSpan name: 'foo')
]
