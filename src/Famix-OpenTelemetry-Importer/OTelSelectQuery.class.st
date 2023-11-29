"
I keep the traces that match my `selector` block.
"
Class {
	#name : #OTelSelectQuery,
	#superclass : #OTelQuery,
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #transforming }
OTelSelectQuery >> value: model [
	"Only keep selected spans in the model."

	model allSpans do: [ :span |
		(selector value: span) ifFalse: [ self removeSpan: span ] ].
	^ model
]
