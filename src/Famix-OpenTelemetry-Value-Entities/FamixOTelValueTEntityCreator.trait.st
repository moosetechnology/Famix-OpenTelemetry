"
This trait is used by Famix models.
It provides an API for creating entities and adding them to the model.


"
Trait {
	#name : #FamixOTelValueTEntityCreator,
	#category : #'Famix-OpenTelemetry-Value-Entities-Model'
}

{ #category : #meta }
FamixOTelValueTEntityCreator classSide >> annotation [

	<FMClass: #TEntityCreator super: #Object>
	<package: #'Famix-OpenTelemetry-Value-Entities'>
	<generated>
	^ self
]

{ #category : #'entity creation' }
FamixOTelValueTEntityCreator >> newSpanArgument [

	<generated>
	^ self add: FamixOTelValueSpanArgument new
]
