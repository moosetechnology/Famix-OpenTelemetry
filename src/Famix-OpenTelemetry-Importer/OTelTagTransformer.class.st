"
I am a transformer that modifies `Span` tags that match a predicate with a pluggable block.
"
Class {
	#name : #OTelTagTransformer,
	#superclass : #OTelAbstractTransformer,
	#instVars : [
		'predicate',
		'block'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #accessing }
OTelTagTransformer >> block [

	^ block
]

{ #category : #accessing }
OTelTagTransformer >> block: aBlock [

	block := aBlock
]

{ #category : #accessing }
OTelTagTransformer >> predicate [

	^ predicate
]

{ #category : #accessing }
OTelTagTransformer >> predicate: aBlock [

	predicate := aBlock
]

{ #category : #transforming }
OTelTagTransformer >> value: model [

	"Apply the block to span tags that fit the predicate."

	model allSpans do: [ :span | 
		span tags associationsDo: [ :tag | 
			(self predicate value: tag key) ifTrue: [ 
				span tags at: tag key put: (self block value: tag value) ] ] ].
	^ model
]
