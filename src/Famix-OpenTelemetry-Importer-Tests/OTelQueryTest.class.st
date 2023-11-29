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
