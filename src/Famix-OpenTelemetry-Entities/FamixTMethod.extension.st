Extension { #name : #FamixTMethod }

{ #category : #'*Famix-OpenTelemetry-Entities-accessing' }
FamixTMethod >> otelSpans [
	"Relation named: #otelSpans type: #FamixOTelSpan opposite: #origin"

	<generated>
	<derived>
	<FMProperty: #otelSpans type: #FamixOTelSpan opposite: #origin>
	<package: #'Famix-OpenTelemetry-Entities'>
	^ self attributeAt: #otelSpans ifAbsentPut: [ FMMultivalueLink on: self opposite: #origin: ]
]

{ #category : #'*Famix-OpenTelemetry-Entities-accessing' }
FamixTMethod >> otelSpans: anObject [

	<generated>
	self otelSpans value: anObject
]

{ #category : #'*Famix-OpenTelemetry-Entities-accessing' }
FamixTMethod >> traces [
	"Relation named: #traces type: #FamixOTelSpan opposite: #origin"

	<generated>
	<derived>
	<FMProperty: #traces type: #FamixOTelSpan opposite: #origin>
	<package: #'Famix-OpenTelemetry-Entities'>
	^ self attributeAt: #traces ifAbsentPut: [ FMMultivalueLink on: self opposite: #origin: ]
]

{ #category : #'*Famix-OpenTelemetry-Entities-accessing' }
FamixTMethod >> traces: anObject [

	<generated>
	self traces value: anObject
]
