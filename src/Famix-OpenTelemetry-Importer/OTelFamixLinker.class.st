"
I am a post-transformer that links `Span`s to their origin in a Famix model.
The origin information is recovered from the tags using the configured keys.
"
Class {
	#name : #OTelFamixLinker,
	#superclass : #OTelAbstractTransformer,
	#instVars : [
		'classKey',
		'methodKey',
		'importer'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #accessing }
OTelFamixLinker >> classKey: aString [

	classKey := aString
]

{ #category : #accessing }
OTelFamixLinker >> importer: aFamixValueImporter [

	importer := aFamixValueImporter
]

{ #category : #links }
OTelFamixLinker >> linkOrigin: span [

	"Link the span origin to the Famix model."

	| name |
	name := span tags at: methodKey.
	span origin:
		((importer findTypeNamed: (span tags at: classKey)) methods detect: [ 
			 :method | method name = name ])
]

{ #category : #accessing }
OTelFamixLinker >> methodKey: aString [

	methodKey := aString
]

{ #category : #transforming }
OTelFamixLinker >> value: model [

	"Link trace model with a Java model using class and method tags."

	(model allWithType: FamixOTelSpan) do: [ :span | 
		self linkOrigin: span ].
	^ model
]
