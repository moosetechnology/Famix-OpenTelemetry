"
I extract traces from a JSON file.
"
Class {
	#name : #OTelJSONFileExtractor,
	#superclass : #OTelAbstractExtractor,
	#instVars : [
		'filename'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #extraction }
OTelJSONFileExtractor >> extract [

	^ (NeoJSONReader on: filename asFileReference readStream) parseValue
]

{ #category : #accessing }
OTelJSONFileExtractor >> filename [

	^ filename
]

{ #category : #extraction }
OTelJSONFileExtractor >> filename: aString [

	filename := aString
]
