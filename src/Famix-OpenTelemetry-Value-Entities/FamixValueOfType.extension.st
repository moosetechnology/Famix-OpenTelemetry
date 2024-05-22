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
FamixValueOfType >> argumentInSpans [
	"Relation named: #argumentInSpans type: #FamixOTelValueSpanArgument opposite: #value"

	<generated>
	<derived>
	<FMProperty: #argumentInSpans type: #FamixOTelValueSpanArgument opposite: #value>
	<package: #'Famix-OpenTelemetry-Value-Entities'>
	^ self attributeAt: #argumentInSpans ifAbsentPut: [ FMMultivalueLink on: self opposite: #value: ]
]

{ #category : #'*Famix-OpenTelemetry-Value-Entities-accessing' }
FamixValueOfType >> argumentInSpans: anObject [

	<generated>
	self argumentInSpans value: anObject
]

{ #category : #'*Famix-OpenTelemetry-Value-Entities-accessing' }
FamixValueOfType >> receiverInSpan [
	"Relation named: #receiverInSpan type: #FamixOTelSpan opposite: #receiver"

	<generated>
	<derived>
	<FMProperty: #receiverInSpan type: #FamixOTelSpan opposite: #receiver>
	<package: #'Famix-OpenTelemetry-Value-Entities'>
	^ self attributeAt: #receiverInSpan ifAbsent: [ nil ]
]

{ #category : #'*Famix-OpenTelemetry-Value-Entities-accessing' }
FamixValueOfType >> receiverInSpan: anObject [

	<generated>
	(self attributeAt: #receiverInSpan ifAbsentPut: [nil]) == anObject ifTrue: [ ^ anObject ].
	anObject ifNil: [ | otherSide |
		otherSide :=  self receiverInSpan.
		self attributeAt: #receiverInSpan put: anObject.
		otherSide receiver: nil ]
	ifNotNil: [ 
		self attributeAt: #receiverInSpan put: anObject.
		anObject receiver: self ]
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
