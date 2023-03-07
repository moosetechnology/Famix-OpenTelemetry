"
I am part of the `OpenTelemetryImporter` pipeline.
My subclasses instantiate a `FamixOTelModel` from raw trace data.
"
Class {
	#name : #OTelAbstractLoader,
	#superclass : #Object,
	#instVars : [
		'model',
		'typeEntity'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #loading }
OTelAbstractLoader >> load: traces [

	"Instantiate trace model from raw data."

	self subclassResponsibility
]

{ #category : #accessing }
OTelAbstractLoader >> model [

	^ model ifNil: [ model := FamixOTelModel new ]
]

{ #category : #accessing }
OTelAbstractLoader >> model: aModel [

	model := aModel
]

{ #category : #'entity creation' }
OTelAbstractLoader >> newContext [

	^ self model add: FamixOTelContext new
]

{ #category : #'entity creation' }
OTelAbstractLoader >> newSpan [

	^ self model add: FamixOTelSpan new
]

{ #category : #'entity creation' }
OTelAbstractLoader >> newTrace [

	^ self model add: FamixOTelTrace new
]
