Class {
	#name : #FamixOTelEntity,
	#superclass : #MooseEntity,
	#category : #'Famix-OpenTelemetry-Entities-Entities'
}

{ #category : #meta }
FamixOTelEntity class >> annotation [

	<FMClass: #Entity super: #MooseEntity>
	<package: #'Famix-OpenTelemetry-Entities'>
	<generated>
	<abstract>
	^ self
]

{ #category : #testing }
FamixOTelEntity class >> isAbstract [

	<generated>
	^ self == FamixOTelEntity
]

{ #category : #meta }
FamixOTelEntity class >> metamodel [

	<generated>
	^ FamixOTelModel metamodel
]

{ #category : #testing }
FamixOTelEntity >> isContext [

	<generated>
	^ false
]

{ #category : #testing }
FamixOTelEntity >> isSpan [

	<generated>
	^ false
]

{ #category : #testing }
FamixOTelEntity >> isTrace [

	<generated>
	^ false
]
