"
An association between a `Span` and a `Value` argument.

## Relations
======================

### Other
| Relation | Origin | Opposite | Type | Comment |
|---|
| `span` | `FamixOTelValueSpanArgument` | `arguments` | `FamixOTelSpan` | |
| `value` | `FamixOTelValueSpanArgument` | `argumentInSpans` | `FamixValueOfType` | |



"
Class {
	#name : #FamixOTelValueSpanArgument,
	#superclass : #FamixOTelValueEntity,
	#category : #'Famix-OpenTelemetry-Value-Entities-Entities'
}

{ #category : #meta }
FamixOTelValueSpanArgument class >> annotation [

	<FMClass: #SpanArgument super: #FamixOTelValueEntity>
	<package: #'Famix-OpenTelemetry-Value-Entities'>
	<generated>
	^ self
]

{ #category : #accessing }
FamixOTelValueSpanArgument >> span [
	"Relation named: #span type: #FamixOTelSpan opposite: #arguments"

	<generated>
	<FMProperty: #span type: #FamixOTelSpan opposite: #arguments>
	^ self attributeAt: #span ifAbsent: [ nil ]
]

{ #category : #accessing }
FamixOTelValueSpanArgument >> span: anObject [

	<generated>
	self attributeAt: #span put: (FMMultivalueLink on: self update: #arguments from: self span to: anObject).
]

{ #category : #accessing }
FamixOTelValueSpanArgument >> value [
	"Relation named: #value type: #FamixValueOfType opposite: #argumentInSpans"

	<generated>
	<FMProperty: #value type: #FamixValueOfType opposite: #argumentInSpans>
	^ self attributeAt: #value ifAbsent: [ nil ]
]

{ #category : #accessing }
FamixOTelValueSpanArgument >> value: anObject [

	<generated>
	self attributeAt: #value put: (FMMultivalueLink on: self update: #argumentInSpans from: self value to: anObject).
]
