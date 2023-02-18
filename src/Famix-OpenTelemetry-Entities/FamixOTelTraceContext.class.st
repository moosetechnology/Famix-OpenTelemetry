"
I hold informations about a `Trace` context. Several contexts can exist in a distributed system.
"
Class {
	#name : #FamixOTelTraceContext,
	#superclass : #FamixOTelEntity,
	#instVars : [
		'#data => FMProperty',
		'#name => FMProperty',
		'#trace => FMOne type: #FamixOTelTrace opposite: #contexts'
	],
	#category : #'Famix-OpenTelemetry-Entities-Entities'
}

{ #category : #meta }
FamixOTelTraceContext class >> annotation [

	<FMClass: #TraceContext super: #FamixOTelEntity>
	<package: #'Famix-OpenTelemetry-Entities'>
	<generated>
	^self
]

{ #category : #accessing }
FamixOTelTraceContext >> data [

	<FMProperty: #data type: #Object>
	<generated>
	^ data
]

{ #category : #accessing }
FamixOTelTraceContext >> data: anObject [
	<generated>
	data := anObject
]

{ #category : #accessing }
FamixOTelTraceContext >> name [

	<FMProperty: #name type: #String>
	<generated>
	^ name
]

{ #category : #accessing }
FamixOTelTraceContext >> name: anObject [
	<generated>
	name := anObject
]

{ #category : #accessing }
FamixOTelTraceContext >> trace [
	"Relation named: #trace type: #FamixOTelTrace opposite: #contexts"

	<generated>
	^ trace
]

{ #category : #accessing }
FamixOTelTraceContext >> trace: anObject [

	<generated>
	trace := anObject
]
