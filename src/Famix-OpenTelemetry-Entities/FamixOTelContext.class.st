"
I hold informations about the context of a set of `Span`s. Several contexts can exist per `Trace` in a distributed system.
"
Class {
	#name : #FamixOTelContext,
	#superclass : #FamixOTelEntity,
	#instVars : [
		'#name => FMProperty',
		'#data => FMProperty',
		'#traces => FMMany type: #FamixOTelTrace opposite: #contexts',
		'#spans => FMMany type: #FamixOTelSpan opposite: #context'
	],
	#category : #'Famix-OpenTelemetry-Entities-Entities'
}

{ #category : #meta }
FamixOTelContext class >> annotation [

	<FMClass: #Context super: #FamixOTelEntity>
	<package: #'Famix-OpenTelemetry-Entities'>
	<generated>
	^self
]

{ #category : #adding }
FamixOTelContext >> addSpan: anObject [
	<generated>
	^ self spans add: anObject
]

{ #category : #adding }
FamixOTelContext >> addTrace: anObject [
	<generated>
	^ self traces add: anObject
]

{ #category : #accessing }
FamixOTelContext >> data [

	<FMProperty: #data type: #Object>
	<generated>
	^ data
]

{ #category : #accessing }
FamixOTelContext >> data: anObject [
	<generated>
	data := anObject
]

{ #category : #accessing }
FamixOTelContext >> name [

	<FMProperty: #name type: #String>
	<generated>
	^ name
]

{ #category : #accessing }
FamixOTelContext >> name: anObject [
	<generated>
	name := anObject
]

{ #category : #accessing }
FamixOTelContext >> spans [
	"Relation named: #spans type: #FamixOTelSpan opposite: #context"

	<generated>
	<derived>
	^ spans
]

{ #category : #accessing }
FamixOTelContext >> spans: anObject [

	<generated>
	spans value: anObject
]

{ #category : #accessing }
FamixOTelContext >> traces [
	"Relation named: #traces type: #FamixOTelTrace opposite: #contexts"

	<generated>
	^ traces
]

{ #category : #accessing }
FamixOTelContext >> traces: anObject [

	<generated>
	traces value: anObject
]
