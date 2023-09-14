Class {
	#name : #BaselineOfFamixOpenTelemetry,
	#superclass : #BaselineOf,
	#category : #BaselineOfFamixOpenTelemetry
}

{ #category : #baselines }
BaselineOfFamixOpenTelemetry >> baseline: spec [

	<baseline>
	spec for: #common do: [ 
		self dependencies: spec.
		self packages: spec.
		self groups: spec ]
]

{ #category : #baselines }
BaselineOfFamixOpenTelemetry >> dependencies: spec [

	spec
		baseline: 'ElasticsearchAPI' with: [ 
			spec repository:
					'github://Evref-BL/Elasticsearch-Pharo-API:main/src' ];
		baseline: 'FamixValue'
		with: [ 
			spec repository: 'github://moosetechnology/Famix-Value:main/src' ]
]

{ #category : #baselines }
BaselineOfFamixOpenTelemetry >> groups: spec [

	spec
		group: 'default' with: #( 'model' 'importer' );
		group: 'all' with: #( 'default' 'elasticsearch' 'value' );
		group: 'model'
		with:
			#( 'Famix-OpenTelemetry-Entities' 'Famix-OpenTelemetry-Entities-Extensions'
			   'Famix-OpenTelemetry-Generator' 'Famix-OpenTelemetry-Presenter' );
		group: 'importer' with: #( 'Famix-OpenTelemetry-Importer' );
		group: 'elasticsearch'
		with: #( 'default' 'Famix-OpenTelemetry-Importer-Elasticsearch'
			   'ElasticsearchAPI' );
		group: 'value'
		with: #( 'default' 'Famix-OpenTelemetry-Value-Generator'
			   'Famix-OpenTelemetry-Value-Entities'
			   'Famix-OpenTelemetry-Importer-Value'
			   'FamixValue' )
]

{ #category : #baselines }
BaselineOfFamixOpenTelemetry >> packages: spec [

	spec
		package: 'Famix-OpenTelemetry-Entities';
		package: 'Famix-OpenTelemetry-Entities-Extensions'
		with: [ spec requires: 'Famix-OpenTelemetry-Entities' ];
		package: 'Famix-OpenTelemetry-Generator';
		package: 'Famix-OpenTelemetry-Presenter'
		with: [ spec requires: 'Famix-OpenTelemetry-Entities' ];
		package: 'Famix-OpenTelemetry-Importer';
		package: 'Famix-OpenTelemetry-Importer-Elasticsearch'
		with: [ spec requires: 'Famix-OpenTelemetry-Importer' ];
		package: 'Famix-OpenTelemetry-Value-Generator';
		package: 'Famix-OpenTelemetry-Value-Entities';
		package: 'Famix-OpenTelemetry-Importer-Value'
		with: [ spec requires: #( 'Famix-OpenTelemetry-Importer' ) ]
]
