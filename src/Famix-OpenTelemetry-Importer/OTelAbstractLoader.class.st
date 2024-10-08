"
I am part of the `OpenTelemetryImporter` pipeline.
My subclasses instantiate a `FamixOTelModel` from raw trace data.
"
Class {
	#name : 'OTelAbstractLoader',
	#superclass : 'Object',
	#instVars : [
		'model'
	],
	#category : 'Famix-OpenTelemetry-Importer',
	#package : 'Famix-OpenTelemetry-Importer'
}

{ #category : 'testing' }
OTelAbstractLoader class >> isAbstract [

	^ self == OTelAbstractLoader
]

{ #category : 'loading' }
OTelAbstractLoader >> load: traces [
	"Instantiate trace model from raw data."

	self subclassResponsibility
]

{ #category : 'accessing' }
OTelAbstractLoader >> model [

	^ model ifNil: [ model := FamixOTelModel new ]
]

{ #category : 'accessing' }
OTelAbstractLoader >> model: aModel [

	model := aModel
]
