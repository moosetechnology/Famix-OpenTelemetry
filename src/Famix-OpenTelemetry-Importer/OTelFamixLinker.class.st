"
I am a transformer that links `Span`s to their origin in a Famix model.
The origin information is recovered from the tags using the configured keys.
"
Class {
	#name : 'OTelFamixLinker',
	#superclass : 'OTelAbstractTransformer',
	#instVars : [
		'classKey',
		'methodKey',
		'importer'
	],
	#category : 'Famix-OpenTelemetry-Importer',
	#package : 'Famix-OpenTelemetry-Importer'
}

{ #category : 'accessing' }
OTelFamixLinker >> classKey: aString [

	classKey := aString
]

{ #category : 'accessing' }
OTelFamixLinker >> importer: aFamixValueImporter [

	importer := aFamixValueImporter
]

{ #category : 'links' }
OTelFamixLinker >> linkOrigin: span [
	"Link the span origin to the method in the Famix model."

	span origin: (importer entityFinder
			 findMethodWithSignature: (span tags at: methodKey)
			 in: (importer loadTypeNamed: (span tags at: classKey)))
]

{ #category : 'links' }
OTelFamixLinker >> linkSpan: span [

	self linkOrigin: span
]

{ #category : 'accessing' }
OTelFamixLinker >> methodKey: aString [

	methodKey := aString
]

{ #category : 'transforming' }
OTelFamixLinker >> value: model [
	"Link trace model with a Java model using class and method tags."

	model allSpans do: [ :span | self linkSpan: span ].
	^ model
]
