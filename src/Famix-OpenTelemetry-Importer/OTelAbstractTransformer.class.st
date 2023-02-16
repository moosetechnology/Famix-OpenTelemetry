"
I am part of the `OpenTelemetryImporter` pipeline.
My subclasses apply transformation to OpenTelemetry traces.
I use the `value:` method to be polymorphic with blocks.
Pre-transformers handle raw trace data after extracting.
Post-transformers handle the instantiated model after loading.
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
