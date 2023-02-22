Class {
	#name : #OTelFamixLinker,
	#superclass : #OTelAbstractTransformer,
	#instVars : [
		'famixModel',
		'instModel'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #accessing }
OTelFamixLinker >> famixModel: model [

	famixModel := model
]

{ #category : #'entity creation' }
OTelFamixLinker >> instModel [

	^ instModel ifNil: [ instModel := FamixInstModel new ]
]

{ #category : #links }
OTelFamixLinker >> linkClass: fullyQualifiedName [

	| mooseName |
	mooseName := '::' join: (fullyQualifiedName splitOn: $.).
	^ (famixModel allUsing: FamixTClass) detect: [ :class | 
		  class mooseName = mooseName ]
]

{ #category : #'entity creation' }
OTelFamixLinker >> newEnumValue [

	^ self instModel add: FamixInstEnumValue new
]

{ #category : #'entity creation' }
OTelFamixLinker >> newObject [

	^ self instModel add: FamixInstObject new
]

{ #category : #'entity creation' }
OTelFamixLinker >> newPrimitive [

	^ self instModel add: FamixInstPrimitive new
]
