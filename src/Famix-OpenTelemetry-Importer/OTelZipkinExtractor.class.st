"
I extract traces from a Zipkin server.
See [Zipkin API](https://zipkin.io/zipkin-api).
"
Class {
	#name : 'OTelZipkinExtractor',
	#superclass : 'OTelAbstractExtractor',
	#instVars : [
		'endpoint',
		'parameters'
	],
	#category : 'Famix-OpenTelemetry-Importer',
	#package : 'Famix-OpenTelemetry-Importer'
}

{ #category : 'parameters' }
OTelZipkinExtractor >> endTs [

	^ self parameters at: 'endTs' ifAbsent: [ nil ]
]

{ #category : 'parameters' }
OTelZipkinExtractor >> endTs: anInteger [
	"Only return traces where all timestamp are at or before this time in epoch milliseconds."

	self parameters at: 'endTs' put: anInteger
]

{ #category : 'accessing' }
OTelZipkinExtractor >> endpoint [

	^ endpoint
]

{ #category : 'accessing' }
OTelZipkinExtractor >> endpoint: host [

	endpoint := host
]

{ #category : 'extraction' }
OTelZipkinExtractor >> extract [
	"Ask Zipkin server for traces and parse result."

	| url data |
	url := self request.
	data := ZnClient new get: url.
	self output: data.
	^ (NeoJSONReader on: data readStream) parseList
]

{ #category : 'parameters' }
OTelZipkinExtractor >> limit [

	^ self parameters at: 'limit' ifAbsent: [ nil ]
]

{ #category : 'parameters' }
OTelZipkinExtractor >> limit: anInteger [

	self parameters at: 'limit' put: anInteger
]

{ #category : 'parameters' }
OTelZipkinExtractor >> lookback [

	^ self parameters at: 'lookback' ifAbsent: [ nil ]
]

{ #category : 'parameters' }
OTelZipkinExtractor >> lookback: anInteger [
	"Only return traces where all timestamp are at or after `endTs - lookback`, in  milliseconds."

	self parameters at: 'lookback' put: anInteger
]

{ #category : 'accessing' }
OTelZipkinExtractor >> parameters [

	^ parameters ifNil: [ parameters := Dictionary new ]
]

{ #category : 'extraction' }
OTelZipkinExtractor >> request [

	^ String streamContents: [ :stream |
		  stream << endpoint << '/api/v2/traces?'.
		  self parameters associationsDo: [ :param |
			  stream << $& << param key << $= << param value asString ].
		  "if not explicitly set, use endTs as current time"
		  parameters at: 'endTs' ifAbsent: [
			  stream << '&endTs='.
			  (DateAndTime now - DateAndTime unixEpoch) asMilliSeconds
				  printOn: stream ] ]
]

{ #category : 'parameters' }
OTelZipkinExtractor >> serviceName [

	^ self parameters at: 'serviceName' ifAbsent: [ nil ]
]

{ #category : 'parameters' }
OTelZipkinExtractor >> serviceName: aString [

	self parameters at: 'serviceName' put: aString
]

{ #category : 'parameters' }
OTelZipkinExtractor >> spanName [

	^ self parameters at: 'spanName' ifAbsent: [ nil ]
]

{ #category : 'parameters' }
OTelZipkinExtractor >> spanName: aString [

	self parameters at: 'spanName' put: aString
]
