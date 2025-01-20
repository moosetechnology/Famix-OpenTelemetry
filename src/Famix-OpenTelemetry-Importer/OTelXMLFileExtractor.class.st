"
I extract traces from an XML file.
"
Class {
	#name : 'OTelXMLFileExtractor',
	#superclass : 'OTelAbstractExtractor',
	#instVars : [
		'filename'
	],
	#category : 'Famix-OpenTelemetry-Importer',
	#package : 'Famix-OpenTelemetry-Importer'
}

{ #category : 'extraction' }
OTelXMLFileExtractor >> extract [

	^ XMLDOMParser parse: filename asFileReference readStream
]

{ #category : 'accessing' }
OTelXMLFileExtractor >> filename [

	^ filename
]

{ #category : 'accessing' }
OTelXMLFileExtractor >> filename: aString [

	filename := aString
]
