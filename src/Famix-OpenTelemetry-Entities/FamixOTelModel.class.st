Class {
	#name : #FamixOTelModel,
	#superclass : #MooseModel,
	#category : #'Famix-OpenTelemetry-Entities-Model'
}

{ #category : #accessing }
FamixOTelModel class >> allSubmetamodelsPackagesNames [
	<generated>
	^ #(#'Moose-Query' #'Famix-Traits' #'Famix-Instance-Entities')
]

{ #category : #meta }
FamixOTelModel class >> annotation [
	<FMClass: #FamixOTelModel super: #MooseModel>
	<package: #'Famix-OpenTelemetry-Entities'>
	<generated>
]

{ #category : #testing }
FamixOTelModel class >> canBeImportedFromFile [
	<generated>
	^true
]
