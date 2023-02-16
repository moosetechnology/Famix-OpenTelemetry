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
]

{ #category : #baselines }
BaselineOfFamixOpenTelemetry >> definePackages: spec [

	spec
		package: 'Famix-OpenTelemetry-Entities';
		package: 'Famix-OpenTelemetry-Generator';
		package: 'Famix-OpenTelemetry-Importer'
]
