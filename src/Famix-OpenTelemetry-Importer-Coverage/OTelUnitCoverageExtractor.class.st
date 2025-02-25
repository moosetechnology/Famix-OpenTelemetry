"
Extracts the raw coverage data embedded in a trace and links it to a Famix model using a FamixCoverage importer.
Specific to ""unit"" coverage: a single method is the root of the whole coverage data.
"
Class {
	#name : 'OTelUnitCoverageExtractor',
	#superclass : 'OTelFamixLinker',
	#instVars : [
		'coverageKey'
	],
	#category : 'Famix-OpenTelemetry-Importer-Coverage',
	#package : 'Famix-OpenTelemetry-Importer-Coverage'
}

{ #category : 'accessing' }
OTelUnitCoverageExtractor >> coverageKey [

	^ coverageKey
]

{ #category : 'accessing' }
OTelUnitCoverageExtractor >> coverageKey: aString [

	coverageKey := aString
]

{ #category : 'transforming' }
OTelUnitCoverageExtractor >> linkSpan: span [

	importer
		parseCoverage: (span tags at: coverageKey) base64Decoded
		ofMethod: (importer entityFinder
				 findMethodWithSignature: (span tags at: methodKey)
				 in:
				 (importer entityFinder findTypeNamed: (span tags at: classKey)))
]
