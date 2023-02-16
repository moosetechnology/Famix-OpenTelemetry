"
I give the big picture of what happens when a request is made by user or an application. Traces are composed of `Span`s.
"
Class {
	#name : #FamixOTelTrace,
	#superclass : #FamixOTelEntity,
	#instVars : [
		'#id => FMProperty',
		'#name => FMProperty',
		'#spans => FMMany type: #FamixOTelSpan opposite: #trace'
	],
	#category : #'Famix-OpenTelemetry-Entities-Entities'
}

{ #category : #meta }
FamixOTelTrace class >> annotation [

	<FMClass: #Trace super: #FamixOTelEntity>
	<package: #'Famix-OpenTelemetry-Entities'>
	<generated>
	^self
]

{ #category : #adding }
FamixOTelTrace >> addSpan: anObject [
	<generated>
	^ self spans add: anObject
]

{ #category : #accessing }
FamixOTelTrace >> id [

	<FMProperty: #id type: #String>
	<generated>
	^ id
]

{ #category : #accessing }
FamixOTelTrace >> id: anObject [
	<generated>
	id := anObject
]

{ #category : #accessing }
FamixOTelTrace >> name [

	<FMProperty: #name type: #String>
	<generated>
	^ name
]

{ #category : #accessing }
FamixOTelTrace >> name: anObject [
	<generated>
	name := anObject
]

{ #category : #accessing }
FamixOTelTrace >> spans [
	"Relation named: #spans type: #FamixOTelSpan opposite: #trace"

	<generated>
	<derived>
	^ spans
]

{ #category : #accessing }
FamixOTelTrace >> spans: anObject [

	<generated>
	spans value: anObject
]

{ #category : #navigation }
FamixOTelTrace >> spansGroup [
	<generated>
	<navigation: 'Spans'>
	^ MooseSpecializedGroup withAll: self spans asSet
]
