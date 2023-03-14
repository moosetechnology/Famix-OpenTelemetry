"
I am part of the `OpenTelemetryImporter` pipeline.
My subclasses extract OpenTelemetry traces from external sources.
"
Class {
	#name : #OTelAbstractExtractor,
	#superclass : #Object,
	#instVars : [
		'outputFilename'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #extraction }
OTelAbstractExtractor >> extract [

	self subclassResponsibility
]

{ #category : #fileout }
OTelAbstractExtractor >> output: data [

	outputFilename ifNotNil: [ 
		(outputFilename asFileReference ensureDelete ensureCreateFile
			 writeStream nextPutAll: data) close ].
	^ data
]

{ #category : #accessing }
OTelAbstractExtractor >> outputFilename: filename [

	"Set an optional file to save the extracted data."

	outputFilename := filename
]
