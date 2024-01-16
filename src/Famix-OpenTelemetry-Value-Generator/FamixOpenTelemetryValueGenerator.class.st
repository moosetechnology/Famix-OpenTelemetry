"
I add a relation between `Span`s and `Value`s to represent runtime data.
"
Class {
	#name : #FamixOpenTelemetryValueGenerator,
	#superclass : #FamixMetamodelGenerator,
	#instVars : [
		'span',
		'value'
	],
	#category : #'Famix-OpenTelemetry-Value-Generator'
}

{ #category : #accessing }
FamixOpenTelemetryValueGenerator class >> packageName [

	<ignoreForCoverage>
	^ #'Famix-OpenTelemetry-Value-Entities'
]

{ #category : #accessing }
FamixOpenTelemetryValueGenerator class >> prefix [

	<ignoreForCoverage>
	^ #FamixOTelValue
]

{ #category : #accessing }
FamixOpenTelemetryValueGenerator class >> submetamodels [

	^ { FamixOpenTelemetryGenerator. FamixValueGenerator }
]

{ #category : #definition }
FamixOpenTelemetryValueGenerator >> defineClasses [

	span := self remoteEntity: #Span withPrefix: #FamixOTel.
	value := self remoteEntity: #OfType withPrefix: #FamixValue
]

{ #category : #definition }
FamixOpenTelemetryValueGenerator >> defineRelations [

	(span property: #receiver) - (value property: #receiverInSpan).
	(span property: #arguments) -* (value property: #argumentInSpan).
	(span property: #result) - (value property: #resultInSpan)
]
