Extension { #name : #FamixOTelModel }

{ #category : #'*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelModel >> allContexts [

	^ self allWithType: FamixOTelContext
]

{ #category : #'*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelModel >> allSpans [

	^ self allWithType: FamixOTelSpan
]

{ #category : #'*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelModel >> allTraces [

	^ self allWithType: FamixOTelTrace
]
