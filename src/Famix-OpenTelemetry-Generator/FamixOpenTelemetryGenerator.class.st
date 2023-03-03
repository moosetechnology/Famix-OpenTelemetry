Class {
	#name : #FamixOpenTelemetryGenerator,
	#superclass : #FamixMetamodelGenerator,
	#instVars : [
		'trace',
		'span',
		'context',
		'valueEntity'
	],
	#category : #'Famix-OpenTelemetry-Generator'
}

{ #category : #accessing }
FamixOpenTelemetryGenerator class >> packageName [

	<ignoreForCoverage>
	^ #'Famix-OpenTelemetry-Entities'
]

{ #category : #accessing }
FamixOpenTelemetryGenerator class >> prefix [

	<ignoreForCoverage>
	^ #FamixOTel
]

{ #category : #accessing }
FamixOpenTelemetryGenerator class >> submetamodels [

	^ { FamixGenerator. FamixValueGenerator }
]

{ #category : #definition }
FamixOpenTelemetryGenerator >> defineClasses [

	trace := builder
		         newClassNamed: #Trace
		         comment:
		         'I give the big picture of what happens when a request is made by user or an application. Traces are composed of `Span`s.'.
	context := builder
		           newClassNamed: #Context
		           comment:
		           'I hold informations about the context of a set of `Span`s. Several contexts can exist per `Trace` in a distributed system.'.
	span := builder
		        newClassNamed: #Span
		        comment:
		        'I represent a unit of work or operation. Spans are the building blocks of `Trace`s.'.

	valueEntity := self remoteEntity: #OfType withPrefix: #FamixValue
]

{ #category : #definition }
FamixOpenTelemetryGenerator >> defineProperties [

	trace property: #id type: #String.
	context property: #name type: #String.
	context property: #data type: #Object.
	span property: #id type: #String.
	span property: #name type: #String.
	span property: #timestamp type: #Number.
	span property: #duration type: #Number.
	span property: #tags type: #Object
]

{ #category : #definition }
FamixOpenTelemetryGenerator >> defineRelations [

	(trace property: #spans) -* (span property: #trace).
	(trace property: #contexts) *-* (context property: #traces).
	(context property: #spans) -* (span property: #context).
	(span property: #children) -* (span property: #parent).
	(span property: #origin)
	*-
	((self remoteTrait: #TMethod withPrefix: #Famix) property: #otelSpans).
	(span property: #arguments) -* (valueEntity property: #argumentInSpan).
	(span property: #result) - (valueEntity property: #resultInSpan)
]
