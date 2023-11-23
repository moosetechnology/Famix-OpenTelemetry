Extension { #name : #FamixTWithParameters }

{ #category : #'*Famix-OpenTelemetry-Importer-Value' }
FamixTWithParameters >> sortedParameters [

	^ parameters sorted: [ :a :b |
		  a sourceAnchor startPos < b sourceAnchor startPos ]
]
