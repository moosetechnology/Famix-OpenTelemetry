Extension { #name : #FamixValueOfType }

{ #category : #'*Famix-OpenTelemetry-Value-Entities-accessing' }
FamixValueOfType >> argumentInSpan [
	"Relation named: #argumentInSpan type: #FamixOTelSpan opposite: #arguments"

	<generated>
	<FMProperty: #argumentInSpan type: #FamixOTelSpan opposite: #arguments>
	<package: #'Famix-OpenTelemetry-Value-Entities'>
	^ self attributeAt: #argumentInSpan ifAbsent: [ nil ]
]

{ #category : #'*Famix-OpenTelemetry-Value-Entities-accessing' }
FamixValueOfType >> argumentInSpan: anObject [

	<generated>
	self attributeAt: #argumentInSpan put: (FMMultivalueLink on: self update: #arguments from: self argumentInSpan to: anObject).
]

{ #category : #'*Famix-OpenTelemetry-Value-Entities-accessing' }
FamixValueOfType >> resultInSpan [
	"Relation named: #resultInSpan type: #FamixOTelSpan opposite: #result"

	<generated>
	<derived>
	<FMProperty: #resultInSpan type: #FamixOTelSpan opposite: #result>
	<package: #'Famix-OpenTelemetry-Value-Entities'>
	^ self attributeAt: #resultInSpan ifAbsent: [ nil ]
]

{ #category : #'*Famix-OpenTelemetry-Value-Entities-accessing' }
FamixValueOfType >> resultInSpan: anObject [

	<generated>
	(self attributeAt: #resultInSpan ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self resultInSpan.
		self attributeAt: #resultInSpan put: anObject.
		otherSide result: nil ]
	ifNotNil: [ 
		self attributeAt: #resultInSpan put: anObject.
		anObject result: self ]
]
