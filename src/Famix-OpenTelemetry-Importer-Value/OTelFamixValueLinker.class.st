"
I am a post-transformer that links `Span`s to their origin in a Famix model, and generates a FamixValue model from serialized arguments and result.
The arguments and result information is recovered from the tags using the configured keys.
"
Class {
	#name : 'OTelFamixValueLinker',
	#superclass : 'OTelFamixLinker',
	#instVars : [
		'argsKey',
		'resultKey',
		'shouldLinkResultFirst',
		'shouldResetImporter',
		'receiverKey'
	],
	#category : 'Famix-OpenTelemetry-Importer-Value',
	#package : 'Famix-OpenTelemetry-Importer-Value'
}

{ #category : 'accessing' }
OTelFamixValueLinker >> argsKey: aString [

	argsKey := aString
]

{ #category : 'links' }
OTelFamixValueLinker >> linkArguments: span [
	"Link the serialized arguments to the Famix model."

	span origin parameters isEmpty ifTrue: [ ^ self ].
	(importer parseList: (span tags at: argsKey))
		with: span origin sortedParameters
		do: [ :rawArg :parameter |
			importer withTypeInference: parameter declaredType do: [
				| argument |
				argument := importer importValue: rawArg.
				argument typedEntity ifNil: [ argument typedEntity: parameter ].
				span mooseModel newSpanArgument
					value: argument;
					span: span ] ]
]

{ #category : 'links' }
OTelFamixValueLinker >> linkReceiver: span [

	receiverKey ifNil: [ ^ self ].
	importer withTypeInference: span origin parentType do: [
		(importer parseValue: (span tags at: receiverKey)) receiverInSpan:
			span ]
]

{ #category : 'links' }
OTelFamixValueLinker >> linkResult: span [
	"Link the serialized result to the Famix model."

	span origin isProcedure ifTrue: [ ^ self ].
	importer withTypeInference: span origin declaredType do: [
		(importer parseValue: (span tags at: resultKey))
			typedEntity: span origin;
			resultInSpan: span ]
]

{ #category : 'links' }
OTelFamixValueLinker >> linkSpan: span [

	importer reset.
	self linkOrigin: span.
	self linkReceiver: span.
	self shouldResetImporter ifTrue: [ importer reset ].
	self shouldLinkResultFirst
		ifTrue: [ self linkResult: span ]
		ifFalse: [ self linkArguments: span ].
	self shouldResetImporter ifTrue: [ importer reset ].
	self shouldLinkResultFirst
		ifTrue: [ self linkArguments: span ]
		ifFalse: [ self linkResult: span ]
]

{ #category : 'accessing' }
OTelFamixValueLinker >> receiverKey: aString [

	receiverKey := aString
]

{ #category : 'accessing' }
OTelFamixValueLinker >> resultKey: aString [

	resultKey := aString
]

{ #category : 'accessing' }
OTelFamixValueLinker >> shouldLinkResultFirst [

	^ shouldLinkResultFirst ifNil: [ shouldLinkResultFirst := true ]
]

{ #category : 'accessing' }
OTelFamixValueLinker >> shouldLinkResultFirst: aBoolean [
	"Whether to link the result before the arguments."

	shouldLinkResultFirst := aBoolean
]

{ #category : 'accessing' }
OTelFamixValueLinker >> shouldResetImporter [

	^ shouldResetImporter ifNil: [ shouldResetImporter := true ]
]

{ #category : 'accessing' }
OTelFamixValueLinker >> shouldResetImporter: aBoolean [
	"Whether the importer should be reset between linking the result and arguments."

	shouldResetImporter := aBoolean
]
