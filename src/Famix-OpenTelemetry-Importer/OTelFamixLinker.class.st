"
I am a transformer that allows linking `Span`s to a Famix model.
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

{ #category : 'testing' }
OTelFamixLinker class >> isAbstract [

	^ self == OTelFamixLinker
]

{ #category : 'accessing' }
OTelFamixLinker >> classKey: aString [

	classKey := aString
]

{ #category : 'accessing' }
OTelFamixLinker >> importer: anImporter [

	importer := anImporter
]

{ #category : 'transforming' }
OTelFamixLinker >> linkSpan: span [

	self subclassResponsibility
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
