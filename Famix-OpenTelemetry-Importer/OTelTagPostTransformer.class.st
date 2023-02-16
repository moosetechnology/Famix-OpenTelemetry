"
I am a post-transformer that modifies `Span` tags that fit a predicate with a pluggable block.
"
Class {
	#name : #OTelTagPostTransformer,
	#superclass : #OTelAbstractTransformer,
	#instVars : [
		'predicate',
		'block'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #accessing }
OTelTagPostTransformer >> block [

	^ block
]

{ #category : #accessing }
OTelTagPostTransformer >> block: anObject [

	block := anObject
]

{ #category : #accessing }
OTelTagPostTransformer >> predicate [

	^ predicate
]

{ #category : #accessing }
OTelTagPostTransformer >> predicate: anObject [

	predicate := anObject
]

{ #category : #transforming }
OTelTagPostTransformer >> value: model [

	"Apply the block to span tags that fit the predicate."

	(model allWithType: FamixOTelSpan) do: [ :span | 
		span tags associationsDo: [ :tag | 
			(self predicate value: tag key) ifTrue: [ 
				span tags at: tag key put: (self block value: tag value) ] ] ].
	^ model
]
