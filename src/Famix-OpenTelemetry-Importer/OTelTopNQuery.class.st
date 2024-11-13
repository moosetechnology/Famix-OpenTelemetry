"
I group spans with my `selector` block, sort them with my `comparator` (or do not sort if not provided), and keep only the top `count`.
"
Class {
	#name : 'OTelTopNQuery',
	#superclass : 'OTelQuery',
	#instVars : [
		'comparator',
		'count'
	],
	#category : 'Famix-OpenTelemetry-Importer',
	#package : 'Famix-OpenTelemetry-Importer'
}

{ #category : 'accessing' }
OTelTopNQuery >> comparator [
	"If not specified, do not sort"

	^ comparator
]

{ #category : 'accessing' }
OTelTopNQuery >> comparator: aTwoArgsBlock [

	comparator := aTwoArgsBlock
]

{ #category : 'transforming' }
OTelTopNQuery >> count [

	^ count ifNil: [ count := 1 ]
]

{ #category : 'transforming' }
OTelTopNQuery >> count: anInteger [

	count := anInteger max: 1
]

{ #category : 'transforming' }
OTelTopNQuery >> value: model [
	"Only keep the top n of each group in the model."

	(model allSpans groupedBy: self selector) do: [ :spans |
		| sortedSpans |
		sortedSpans := self comparator
			               ifNil: [ spans ]
			               ifNotNil: [ :comp | spans sorted: comp ].
		self count + 1 to: spans size do: [ :i |
			self removeSpan: (sortedSpans at: i) ] ].
	^ model
]
