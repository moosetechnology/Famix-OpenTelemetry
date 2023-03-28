Extension { #name : #FamixOTelSpan }

{ #category : #'*Famix-OpenTelemetry-Value-Entities-accessing' }
FamixOTelSpan >> arguments [
	"Relation named: #arguments type: #FamixValueOfType opposite: #argumentInSpan"

	<generated>
	<derived>
	<FMProperty: #arguments type: #FamixValueOfType opposite: #argumentInSpan>
	<package: #'Famix-OpenTelemetry-Value-Entities'>
	^ self attributeAt: #arguments ifAbsentPut: [ FMMultivalueLink on: self opposite: #argumentInSpan: ]
]

{ #category : #'*Famix-OpenTelemetry-Value-Entities-accessing' }
FamixOTelSpan >> arguments: anObject [

	<generated>
	self arguments value: anObject
]

{ #category : #'*Famix-OpenTelemetry-Value-Entities-accessing' }
FamixOTelSpan >> result [
	"Relation named: #result type: #FamixValueOfType opposite: #resultInSpan"

	<generated>
	<FMProperty: #result type: #FamixValueOfType opposite: #resultInSpan>
	<package: #'Famix-OpenTelemetry-Value-Entities'>
	^ self attributeAt: #result ifAbsent: [ nil ]
]

{ #category : #'*Famix-OpenTelemetry-Value-Entities-accessing' }
FamixOTelSpan >> result: anObject [

	<generated>
	(self attributeAt: #result ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self result.
		self attributeAt: #result put: anObject.
		otherSide resultInSpan: nil ]
	ifNotNil: [ 
		self attributeAt: #result put: anObject.
		anObject resultInSpan: self ]
]