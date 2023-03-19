"
I am a post-transformer that links `Span`s to their origin in a Famix model, and generates a FamixValue model from serialized arguments and result.
The arguments and result information is recovered from the tags using the configured keys.
"
Class {
	#name : #OTelFamixValueLinker,
	#superclass : #OTelFamixLinker,
	#instVars : [
		'argsKey',
		'resultKey'
	],
	#category : #'Famix-OpenTelemetry-Importer-Value'
}

{ #category : #accessing }
OTelFamixValueLinker >> argsKey: aString [

	argsKey := aString
]

{ #category : #links }
OTelFamixValueLinker >> linkArguments: span [

	"Link the serialized arguments to the Famix model."

	| index parameter |
	span origin parameters isEmpty ifTrue: [ ^ self ].
	index := 0.
	importer rawValues: (span tags at: argsKey) do: [ :rawArg | 
		parameter := span origin parameters at: (index := index + 1).
		importer reset
			withTypeInference: (parameter ifNotNil: [ parameter declaredType ])
			do: [ 
				(importer importValue: rawArg)
					typedEntity: parameter;
					argumentInSpan: span ] ]
]

{ #category : #links }
OTelFamixValueLinker >> linkResult: span [

	"Link the serialized result to the Famix model."

	(importer isProcedure: span origin) ifTrue: [ ^ self ].
	importer withTypeInference: span origin declaredType do: [ 
		(importer reset parseValue: (span tags at: resultKey))
			typedEntity: span origin;
			resultInSpan: span ]
]

{ #category : #accessing }
OTelFamixValueLinker >> resultKey: aString [

	resultKey := aString
]

{ #category : #transforming }
OTelFamixValueLinker >> value: model [

	"Link trace model with a Java model using class, method, args and result tags."

	(model allWithType: FamixOTelSpan) do: [ :span | 
		self linkOrigin: span.
		self linkArguments: span.
		self linkResult: span ].
	^ model
]
