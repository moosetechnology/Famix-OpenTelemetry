Class {
	#name : #BaselineOfFamixOpenTelemetry,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamixOpenTelemetry
}

{ #category : #baselines }
BaselineOfFamixOpenTelemetry >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 
			self defineDependencies: spec.
			self definePackages: spec.
			self defineGroups: spec ]
]

{ #category : #baselines }
BaselineOfFamixOpenTelemetry >> defineDependencies: spec [
]

{ #category : #baselines }
BaselineOfFamixOpenTelemetry >> defineGroups: spec [
	spec
		baseline: 'ElasticsearchAPI'
		with: [ spec repository: 'github://Evref-BL/Elasticsearch-Pharo-API:main/src' ].
]

{ #category : #baselines }
BaselineOfFamixOpenTelemetry >> definePackages: spec [

	spec
		package: 'Famix-OpenTelemetry-Entities';
		package: 'Famix-OpenTelemetry-Entities-Extensions'
		with: [ spec requires: #( 'Famix-OpenTelemetry-Entities' ) ];
		package: 'Famix-OpenTelemetry-Generator';
		package: 'Famix-OpenTelemetry-Presenter'
		with: [ spec requires: #( 'Famix-OpenTelemetry-Entities' ) ];
		package: 'Famix-OpenTelemetry-Importer';
		package: 'Famix-OpenTelemetry-Importer-Elasticsearch' with: [ 
			spec requires:
					#( 'Famix-OpenTelemetry-Importer' 'ElasticsearchAPI' ) ]
]
