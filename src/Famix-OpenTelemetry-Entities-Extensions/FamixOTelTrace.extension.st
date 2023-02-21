Extension { #name : #FamixOTelTrace }

{ #category : #'*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelTrace >> mooseNameOn: aStream [

	self printOn: aStream
]

{ #category : #'*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelTrace >> printOn: aStream [

	aStream << 'Trace: '.
	self id printOn: aStream.
	aStream << ' '.
	self rootsSpan anyOne printOn: aStream
]

{ #category : #'*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelTrace >> rootsSpan [

	^ self spans select: [ :sp | sp parent isNil ]
]
