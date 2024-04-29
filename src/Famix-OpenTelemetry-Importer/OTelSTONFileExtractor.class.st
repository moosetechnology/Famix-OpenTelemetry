Class {
	#name : #OTelSTONFileExtractor,
	#superclass : #OTelAbstractExtractor,
	#instVars : [
		'filename'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #extraction }
OTelSTONFileExtractor >> extract [

	^ (STONReader on: filename asFileReference readStream) next
]

{ #category : #accessing }
OTelSTONFileExtractor >> filename [

	^ filename
]

{ #category : #accessing }
OTelSTONFileExtractor >> filename: anObject [

	filename := anObject
]
