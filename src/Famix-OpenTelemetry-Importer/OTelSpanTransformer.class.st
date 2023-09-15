"
I am a transformer that can manipulate `Spans` with a pluggable block.
"
Class {
	#name : #OTelSpanTransformer,
	#superclass : #OTelAbstractTransformer,
	#instVars : [
		'block'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #accessing }
OTelSpanTransformer >> block [

	^ block
]

{ #category : #accessing }
OTelSpanTransformer >> block: aBlock [

	block := aBlock
]

{ #category : #transforming }
OTelSpanTransformer >> value: model [

	(model allWithType: FamixOTelSpan) do: [ :span | 
		self block value: span ].
	^ model
]
