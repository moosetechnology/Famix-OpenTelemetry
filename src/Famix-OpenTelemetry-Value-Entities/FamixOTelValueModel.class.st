Class {
	#name : #FamixOTelValueModel,
	#superclass : #MooseModel,
	#traits : 'FamixOTelTEntityCreator + FamixOTelValueTEntityCreator + FamixValueTEntityCreator',
	#classTraits : 'FamixOTelTEntityCreator classTrait + FamixOTelValueTEntityCreator classTrait + FamixValueTEntityCreator classTrait',
	#category : #'Famix-OpenTelemetry-Value-Entities-Model'
}

{ #category : #accessing }
FamixOTelValueModel class >> allSubmetamodelsPackagesNames [
	<generated>
	^ #(#'Moose-Query' #'Famix-Value-Entities' #'Famix-Traits' #'Famix-OpenTelemetry-Entities')
]

{ #category : #meta }
FamixOTelValueModel class >> annotation [
	<FMClass: #FamixOTelValueModel super: #MooseModel>
	<package: #'Famix-OpenTelemetry-Value-Entities'>
	<generated>
]
