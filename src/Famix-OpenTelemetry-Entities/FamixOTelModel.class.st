Class {
	#name : #FamixOTelModel,
	#superclass : #MooseModel,
	#traits : 'FamixOTelTEntityCreator',
	#classTraits : 'FamixOTelTEntityCreator classTrait',
	#category : #'Famix-OpenTelemetry-Entities-Model'
}

{ #category : #accessing }
FamixOTelModel class >> allSubmetamodelsPackagesNames [
	<generated>
	^ #(#'Moose-Query' #'Famix-Traits')
]

{ #category : #meta }
FamixOTelModel class >> annotation [
	<FMClass: #FamixOTelModel super: #MooseModel>
	<package: #'Famix-OpenTelemetry-Entities'>
	<generated>
]
