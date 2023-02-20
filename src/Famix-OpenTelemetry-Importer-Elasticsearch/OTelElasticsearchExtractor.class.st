Class {
	#name : #OTelElasticsearchExtractor,
	#superclass : #OTelAbstractExtractor,
	#instVars : [
		'api'
	],
	#category : #'Famix-OpenTelemetry-Importer-Elasticsearch'
}

{ #category : #accessing }
OTelElasticsearchExtractor >> api [

	^ api
]

{ #category : #accessing }
OTelElasticsearchExtractor >> api: anObject [

	api := anObject
]

{ #category : #accessing }
OTelElasticsearchExtractor >> apiKey: anAPIKey [

	api apiKey: anAPIKey
]

{ #category : #accessing }
OTelElasticsearchExtractor >> endpoint: anEndpoint [
	api endpoint: anEndpoint
]

{ #category : #extraction }
OTelElasticsearchExtractor >> extract [

	^ api performRequest hits hits
]

{ #category : #accessing }
OTelElasticsearchExtractor >> index: anIndex [

	api index: anIndex
]

{ #category : #accessing }
OTelElasticsearchExtractor >> initialize [

	super initialize.
	api := ELKSearchApi new
]

{ #category : #accessing }
OTelElasticsearchExtractor >> port: aPort [

	api port: aPort
]

{ #category : #accessing }
OTelElasticsearchExtractor >> size: aSize [

	api size: aSize
]
