"
I am part of the `OpenTelemetryImporter` pipeline.
My subclasses apply transformations to an OpenTelemetry trace model.
I use the `value:` method to be polymorphic with blocks.
"
Class {
	#name : 'OTelAbstractTransformer',
	#superclass : 'Object',
	#category : 'Famix-OpenTelemetry-Importer',
	#package : 'Famix-OpenTelemetry-Importer'
}

{ #category : 'testing' }
OTelAbstractTransformer class >> isAbstract [

	^ self == OTelAbstractTransformer
]

{ #category : 'transforming' }
OTelAbstractTransformer >> value: model [
	"Apply a transformation to trace model."

	self subclassResponsibility
]
