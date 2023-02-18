"
I give the big picture of what happens when a request is made by user or an application. Traces are composed of `Span`s.
"
Class {
	#name : #FamixOTelTrace,
	#superclass : #FamixOTelEntity,
	#instVars : [
		'#contexts => FMMany type: #FamixOTelTraceContext opposite: #trace',
		'#id => FMProperty',
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
FamixOTelTrace >> addContext: anObject [
	<generated>
	^ self contexts add: anObject
]

{ #category : #adding }
FamixOTelTrace >> addSpan: anObject [
	<generated>
	^ self spans add: anObject
]

{ #category : #accessing }
FamixOTelTrace >> contexts [
	"Relation named: #contexts type: #FamixOTelTraceContext opposite: #trace"

	<generated>
	<derived>
	^ contexts
]

{ #category : #accessing }
FamixOTelTrace >> contexts: anObject [

	<generated>
	contexts value: anObject
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
