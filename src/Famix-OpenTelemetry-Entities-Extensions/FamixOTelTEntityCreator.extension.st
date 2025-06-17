Extension { #name : 'FamixOTelTEntityCreator' }

{ #category : '*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelTEntityCreator >> allContexts [

	^ self allWithType: FamixOTelContext
]

{ #category : '*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelTEntityCreator >> allSpans [

	^ self allWithType: FamixOTelSpan
]

{ #category : '*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelTEntityCreator >> allTraces [

	^ self allWithType: FamixOTelTrace
]
