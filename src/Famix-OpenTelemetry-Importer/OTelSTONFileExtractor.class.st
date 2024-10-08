Class {
	#name : 'OTelSTONFileExtractor',
	#superclass : 'OTelAbstractExtractor',
	#instVars : [
		'filename'
	],
	#category : 'Famix-OpenTelemetry-Importer',
	#package : 'Famix-OpenTelemetry-Importer'
}

{ #category : 'extraction' }
OTelSTONFileExtractor >> extract [

	| file |
	^ (file := filename asFileReference) isDirectory
		  ifTrue: [
			  (file children select: [ :f | f extension = 'ston' ])
				  flatCollect: [ :f | self extract: f ] ]
		  ifFalse: [ self extract: file ]
]

{ #category : 'accessing' }
OTelSTONFileExtractor >> extract: file [

	^ (STONReader on: file readStream) next
]

{ #category : 'accessing' }
OTelSTONFileExtractor >> filename [

	^ filename
]

{ #category : 'accessing' }
OTelSTONFileExtractor >> filename: anObject [

	filename := anObject
]
