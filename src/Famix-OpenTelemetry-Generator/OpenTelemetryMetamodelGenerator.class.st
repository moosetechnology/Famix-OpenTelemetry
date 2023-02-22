Class {
	#name : #OpenTelemetryMetamodelGenerator,
	#superclass : #FamixMetamodelGenerator,
	#instVars : [
		'trace',
		'span',
		'context',
		'instEntity'
	],
	#category : #'Famix-OpenTelemetry-Generator'
}

{ #category : #accessing }
OpenTelemetryMetamodelGenerator class >> packageName [

	<ignoreForCoverage>
	^ #'Famix-OpenTelemetry-Entities'
]

{ #category : #accessing }
OpenTelemetryMetamodelGenerator class >> prefix [

	<ignoreForCoverage>
	^ #FamixOTel
]

{ #category : #accessing }
OpenTelemetryMetamodelGenerator class >> submetamodels [

	^ { FamixGenerator. FamixInstanceMetamodelGenerator }
]

{ #category : #definition }
OpenTelemetryMetamodelGenerator >> defineClasses [

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

	instEntity := self remoteEntity: #Entity withPrefix: #FamixInst
]

{ #category : #definition }
OpenTelemetryMetamodelGenerator >> defineProperties [

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
OpenTelemetryMetamodelGenerator >> defineRelations [

	(trace property: #spans) -* (span property: #trace).
	(trace property: #contexts) *-* (context property: #traces).
	(context property: #spans) -* (span property: #context).
	(span property: #children) -* (span property: #parent).
	(span property: #origin)
	*-
	((self remoteTrait: #TMethod withPrefix: #Famix) property: #otelSpans).
	(span property: #arguments) -* (instEntity property: #otelSpan).
	(span property: #result) - (instEntity property: #otelSpan)
]
