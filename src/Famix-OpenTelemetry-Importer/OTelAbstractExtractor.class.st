"
I am part of the `OpenTelemetryImporter` pipeline.
My subclasses extract OpenTelemetry traces from external sources.
"
Class {
	#name : #OTelAbstractExtractor,
	#superclass : #Object,
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #extraction }
OTelAbstractExtractor >> extract [

	self subclassResponsibility
]
