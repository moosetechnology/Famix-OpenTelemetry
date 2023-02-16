Class {
	#name : #OpenTelemetryMetamodelGenerator,
	#superclass : #FamixMetamodelGenerator,
	#instVars : [
		'trace',
		'span'
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

{ #category : #definition }
OpenTelemetryMetamodelGenerator >> defineClasses [

	trace := builder
		         newClassNamed: #Trace
		         comment:
		         'I give the big picture of what happens when a request is made by user or an application. Traces are composed of `Span`s.'.
	span := builder
		        newClassNamed: #Span
		        comment:
		        'I represent a unit of work or operation. Spans are the building blocks of `Trace`s.'
]

{ #category : #definition }
OpenTelemetryMetamodelGenerator >> defineProperties [

	trace property: #id type: #String.
	trace property: #name type: #String.
	span property: #id type: #String.
	span property: #name type: #String.
	span property: #timestamp type: #Number.
	span property: #duration type: #Number.
	span property: #tags type: #Object
]

{ #category : #definition }
OpenTelemetryMetamodelGenerator >> defineRelations [

	(trace property: #spans) <>-* (span property: #trace).
	(span property: #children) <>-* (span property: #parent)
]
