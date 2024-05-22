"
I add a relation between `Span`s and `Value`s to represent runtime data.
"
Class {
	#name : #FamixOpenTelemetryValueGenerator,
	#superclass : #FamixMetamodelGenerator,
	#instVars : [
		'span',
		'value',
		'argument'
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

	argument := builder
		            newClassNamed: #SpanArgument
		            comment:
		            'An association between a `Span` and a `Value` argument.'.

	span := self remoteEntity: #Span withPrefix: #FamixOTel.
	value := self remoteEntity: #OfType withPrefix: #FamixValue
]

{ #category : #definition }
FamixOpenTelemetryValueGenerator >> defineRelations [

	(span property: #arguments) -* (argument property: #span).
	(argument property: #value) *- (value property: #argumentInSpans).

	(span property: #receiver) - (value property: #receiverInSpan).
	(span property: #result) - (value property: #resultInSpan)
]
