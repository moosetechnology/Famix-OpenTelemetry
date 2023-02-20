Extension { #name : #FamixOTelTrace }

{ #category : #'*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelTrace >> mooseNameOn: aStream [

	aStream << 'Trace: '.
	self id printOn: aStream
]

{ #category : #'*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelTrace >> printOn: aStream [

	aStream << 'Trace: '.
	self id printOn: aStream
]
