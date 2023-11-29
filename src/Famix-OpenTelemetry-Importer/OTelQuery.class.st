"
My subclasses apply SQL-like queries on a model to select specific traces.
"
Class {
	#name : #OTelQuery,
	#superclass : #OTelAbstractTransformer,
	#instVars : [
		'selector'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #testing }
OTelQuery class >> isAbstract [

	^ self == OTelQuery
]

{ #category : #accessing }
OTelQuery class >> selector: aBlock [

	^ self new selector: aBlock
]

{ #category : #removing }
OTelQuery >> removeSpan: span [
	"Remove a Span from the trace model."

	| parent |
	span trace: nil.
	span context: nil.
	parent := span parent.
	span children do: [ :child | child parent: parent ].
	span parent: nil.
	span mooseModel remove: span
]

{ #category : #accessing }
OTelQuery >> selector [

	^ selector
]

{ #category : #accessing }
OTelQuery >> selector: aBlock [

	selector := aBlock
]
