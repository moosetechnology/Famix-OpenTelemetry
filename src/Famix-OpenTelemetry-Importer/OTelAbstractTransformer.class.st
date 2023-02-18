"
I am part of the `OpenTelemetryImporter` pipeline.
My subclasses apply transformations to an OpenTelemetry trace model.
I use the `value:` method to be polymorphic with blocks.
"
Class {
	#name : #OTelAbstractTransformer,
	#superclass : #Object,
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #transforming }
OTelAbstractTransformer >> value: data [

	"Apply a transformation to trace data."

	self subclassResponsibility
]
