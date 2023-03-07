Class {
	#name : #BaselineOfFamixOpenTelemetry,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamixOpenTelemetry
}

{ #category : #baselines }
BaselineOfFamixOpenTelemetry >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		self defineDependencies: spec.
		self definePackages: spec.
		self defineGroups: spec ]
]

{ #category : #baselines }
BaselineOfFamixOpenTelemetry >> defineDependencies: spec [

	spec
		baseline: 'ElasticsearchAPI' with: [ 
			spec repository:
					'github://Evref-BL/Elasticsearch-Pharo-API:main/src' ];
		baseline: 'FamixValue'
		with: [ 
			spec repository: 'github://moosetechnology/Famix-Value:main/src' ]
]

{ #category : #baselines }
BaselineOfFamixOpenTelemetry >> defineGroups: spec [

	spec
		group: 'default' with: #( 'Model' 'Importer' );
		group: 'Model'
		with:
			#( 'Famix-OpenTelemetry-Entities' 'Famix-OpenTelemetry-Entities-Extensions'
			   'Famix-OpenTelemetry-Generator' 'Famix-OpenTelemetry-Presenter' );
		group: 'Importer' with: #( 'Famix-OpenTelemetry-Importer' );
		group: 'Elasticsearch'
		with: #( 'Famix-OpenTelemetry-Importer-Elasticsearch'
			   'ElasticsearchAPI' );
		group: 'Value' with: #( 'Famix-OpenTelemetry-Value-Generator'
			   'Famix-OpenTelemetry-Value-Entities'
			   'Famix-OpenTelemetry-Importer-Value'
			   'FamixValue' )
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
		package: 'Famix-OpenTelemetry-Importer-Elasticsearch'
		with: [ spec requires: #( 'Famix-OpenTelemetry-Importer' ) ];
		package: 'Famix-OpenTelemetry-Value-Generator';
		package: 'Famix-OpenTelemetry-Value-Entities';
		package: 'Famix-OpenTelemetry-Importer-Value'
		with: [ spec requires: #( 'Famix-OpenTelemetry-Importer' ) ]
]
