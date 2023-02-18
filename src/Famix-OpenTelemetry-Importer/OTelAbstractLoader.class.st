"
I am part of the `OpenTelemetryImporter` pipeline.
My subclasses instantiate a `FamixOTelModel` from raw trace data.
"
Class {
	#name : #OTelAbstractLoader,
	#superclass : #Object,
	#instVars : [
		'model'
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

{ #category : #'entity creation' }
OTelAbstractLoader >> newContext [

	^ model add: FamixOTelContext new
]

{ #category : #'entity creation' }
OTelAbstractLoader >> newSpan [

	^ model add: FamixOTelSpan new
]

{ #category : #'entity creation' }
OTelAbstractLoader >> newTrace [

	^ model add: FamixOTelTrace new
]
