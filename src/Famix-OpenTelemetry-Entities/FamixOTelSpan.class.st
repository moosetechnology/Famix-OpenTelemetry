"
I represent a unit of work or operation. Spans are the building blocks of `Trace`s.
"
Class {
	#name : #FamixOTelSpan,
	#superclass : #FamixOTelEntity,
	#instVars : [
		'#id => FMProperty',
		'#name => FMProperty',
		'#timestamp => FMProperty',
		'#duration => FMProperty',
		'#tags => FMProperty',
		'#trace => FMOne type: #FamixOTelTrace opposite: #spans',
		'#context => FMOne type: #FamixOTelContext opposite: #spans',
		'#children => FMMany type: #FamixOTelSpan opposite: #parent',
		'#parent => FMOne type: #FamixOTelSpan opposite: #children'
	],
	#category : #'Famix-OpenTelemetry-Entities-Entities'
}

{ #category : #meta }
FamixOTelSpan class >> annotation [

	<FMClass: #Span super: #FamixOTelEntity>
	<package: #'Famix-OpenTelemetry-Entities'>
	<generated>
	^self
]

{ #category : #adding }
FamixOTelSpan >> addChildren: anObject [
	<generated>
	^ self children add: anObject
]

{ #category : #accessing }
FamixOTelSpan >> children [
	"Relation named: #children type: #FamixOTelSpan opposite: #parent"

	<generated>
	<derived>
	^ children
]

{ #category : #accessing }
FamixOTelSpan >> children: anObject [

	<generated>
	children value: anObject
]

{ #category : #accessing }
FamixOTelSpan >> context [
	"Relation named: #context type: #FamixOTelContext opposite: #spans"

	<generated>
	^ context
]

{ #category : #accessing }
FamixOTelSpan >> context: anObject [

	<generated>
	context := anObject
]

{ #category : #accessing }
FamixOTelSpan >> duration [

	<FMProperty: #duration type: #Number>
	<generated>
	^ duration
]

{ #category : #accessing }
FamixOTelSpan >> duration: anObject [
	<generated>
	duration := anObject
]

{ #category : #accessing }
FamixOTelSpan >> id [

	<FMProperty: #id type: #String>
	<generated>
	^ id
]

{ #category : #accessing }
FamixOTelSpan >> id: anObject [
	<generated>
	id := anObject
]

{ #category : #accessing }
FamixOTelSpan >> name [

	<FMProperty: #name type: #String>
	<generated>
	^ name
]

{ #category : #accessing }
FamixOTelSpan >> name: anObject [
	<generated>
	name := anObject
]

{ #category : #accessing }
FamixOTelSpan >> origin [
	"Relation named: #origin type: #FamixTMethod opposite: #otelSpans"

	<generated>
	<FMProperty: #origin type: #FamixTMethod opposite: #otelSpans>
	^ self attributeAt: #origin ifAbsent: [ nil ]
]

{ #category : #accessing }
FamixOTelSpan >> origin: anObject [

	<generated>
	self attributeAt: #origin put: (FMMultivalueLink on: self update: #otelSpans from: self origin to: anObject).
]

{ #category : #accessing }
FamixOTelSpan >> parent [
	"Relation named: #parent type: #FamixOTelSpan opposite: #children"

	<generated>
	^ parent
]

{ #category : #accessing }
FamixOTelSpan >> parent: anObject [

	<generated>
	parent := anObject
]

{ #category : #accessing }
FamixOTelSpan >> tags [

	<FMProperty: #tags type: #Object>
	<generated>
	^ tags
]

{ #category : #accessing }
FamixOTelSpan >> tags: anObject [
	<generated>
	tags := anObject
]

{ #category : #accessing }
FamixOTelSpan >> timestamp [

	<FMProperty: #timestamp type: #Number>
	<generated>
	^ timestamp
]

{ #category : #accessing }
FamixOTelSpan >> timestamp: anObject [
	<generated>
	timestamp := anObject
]

{ #category : #accessing }
FamixOTelSpan >> trace [
	"Relation named: #trace type: #FamixOTelTrace opposite: #spans"

	<generated>
	^ trace
]

{ #category : #accessing }
FamixOTelSpan >> trace: anObject [

	<generated>
	trace := anObject
]
