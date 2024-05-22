Class {
	#name : #FamixOTelValueEntity,
	#superclass : #MooseEntity,
	#category : #'Famix-OpenTelemetry-Value-Entities-Entities'
}

{ #category : #meta }
FamixOTelValueEntity class >> annotation [

	<FMClass: #Entity super: #MooseEntity>
	<package: #'Famix-OpenTelemetry-Value-Entities'>
	<generated>
	<abstract>
	^ self
]

{ #category : #testing }
FamixOTelValueEntity class >> isAbstract [

	<generated>
	^ self == FamixOTelValueEntity
]

{ #category : #meta }
FamixOTelValueEntity class >> metamodel [

	<generated>
	^ FamixOTelValueModel metamodel
]
