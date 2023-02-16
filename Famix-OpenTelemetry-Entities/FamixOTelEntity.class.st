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
	^self
]

{ #category : #meta }
FamixOTelEntity class >> metamodel [

	<generated>
	^ FamixOTelModel metamodel
]
