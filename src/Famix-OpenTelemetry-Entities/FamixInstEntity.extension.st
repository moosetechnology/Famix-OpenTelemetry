Extension { #name : #FamixInstEntity }

{ #category : #'*Famix-OpenTelemetry-Entities-accessing' }
FamixInstEntity >> otelSpan [
	"Relation named: #otelSpan type: #FamixOTelSpan opposite: #arguments"

	<generated>
	<FMProperty: #otelSpan type: #FamixOTelSpan opposite: #arguments>
	<package: #'Famix-OpenTelemetry-Entities'>
	^ self attributeAt: #otelSpan ifAbsent: [ nil ]
]

{ #category : #'*Famix-OpenTelemetry-Entities-accessing' }
FamixInstEntity >> otelSpan: anObject [

	<generated>
	self attributeAt: #otelSpan put: (FMMultivalueLink on: self update: #arguments from: self otelSpan to: anObject).
]
