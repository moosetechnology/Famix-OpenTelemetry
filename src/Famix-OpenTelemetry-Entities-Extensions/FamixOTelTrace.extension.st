Extension { #name : 'FamixOTelTrace' }

{ #category : '*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelTrace >> mooseNameOn: aStream [

	self printOn: aStream
]

{ #category : '*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelTrace >> printOn: aStream [

	self spans ifEmpty: [ aStream << 'Empty ' ].
	aStream << 'Trace '.
	self id printOn: aStream.
	self spans ifNotEmpty: [
		aStream << ': '.
		self rootSpan printOn: aStream ]
]

{ #category : '*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelTrace >> rootSpan [

	^ spans detect: [ :span | span parent isNil ]
]
