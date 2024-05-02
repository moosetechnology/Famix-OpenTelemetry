"
I keep only distinct traces and remove duplicates from the model.
How two traces are considered the same depends on the `selector` attribute.
It must be a one-arg block that is used to group traces, and only one of each group is kept in the model.
"
Class {
	#name : #OTelDistinctQuery,
	#superclass : #OTelQuery,
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #transforming }
OTelDistinctQuery >> value: model [
	"Only keep distinct spans in the model."

	(model allSpans groupedBy: selector) valuesDo: [ :spans |
		2 to: spans size do: [ :i | self removeSpan: (spans at: i) ] ].
	^ model
]
