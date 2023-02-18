"
I am a post-transformer that modifies `Span` tags that fit a predicate with a pluggable block.
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
OTelTagTransformer >> block: anObject [

	block := anObject
]

{ #category : #accessing }
OTelTagTransformer >> predicate [

	^ predicate
]

{ #category : #accessing }
OTelTagTransformer >> predicate: anObject [

	predicate := anObject
]

{ #category : #transforming }
OTelTagTransformer >> value: model [

	"Apply the block to span tags that fit the predicate."

	(model allWithType: FamixOTelSpan) do: [ :span | 
		span tags associationsDo: [ :tag | 
			(self predicate value: tag key) ifTrue: [ 
				span tags at: tag key put: (self block value: tag value) ] ] ].
	^ model
]
