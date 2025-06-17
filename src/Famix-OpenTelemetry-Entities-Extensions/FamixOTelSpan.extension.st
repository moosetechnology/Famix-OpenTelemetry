Extension { #name : 'FamixOTelSpan' }

{ #category : '*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelSpan >> mooseNameOn: stream [

	stream nextPutAll: name.
	self origin ifNotNil: [ :origin |
		stream
			nextPutAll: ' (';
			nextPutAll: origin parentType name;
			nextPut: $.;
			nextPutAll: origin signature;
			nextPut: $) ]
]

{ #category : '*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelSpan >> skip [

	self cacheAt: #skip put: true
]

{ #category : '*Famix-OpenTelemetry-Entities-Extensions' }
FamixOTelSpan >> skipped [

	^ self cacheAt: #skip ifAbsent: false
]
