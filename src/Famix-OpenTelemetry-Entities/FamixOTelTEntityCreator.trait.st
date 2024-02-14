"
This trait is used by Famix models.
It provides an API for creating entities and adding them to the model.


"
Trait {
	#name : #FamixOTelTEntityCreator,
	#category : #'Famix-OpenTelemetry-Entities-Model'
}

{ #category : #meta }
FamixOTelTEntityCreator classSide >> annotation [

	<FMClass: #TEntityCreator super: #Object>
	<package: #'Famix-OpenTelemetry-Entities'>
	<generated>
	^ self
]

{ #category : #'entity creation' }
FamixOTelTEntityCreator >> newContext [

	<generated>
	^ self add: FamixOTelContext new
]

{ #category : #'entity creation' }
FamixOTelTEntityCreator >> newSpan [

	<generated>
	^ self add: FamixOTelSpan new
]

{ #category : #'entity creation' }
FamixOTelTEntityCreator >> newTrace [

	<generated>
	^ self add: FamixOTelTrace new
]
