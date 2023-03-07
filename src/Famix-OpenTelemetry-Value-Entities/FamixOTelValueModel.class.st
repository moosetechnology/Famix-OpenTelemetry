Class {
	#name : #FamixOTelValueModel,
	#superclass : #MooseModel,
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

{ #category : #testing }
FamixOTelValueModel class >> canBeImportedFromFile [
	<generated>
	^true
]
