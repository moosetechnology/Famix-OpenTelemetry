"
I am a transformer that links `Span`s to their origin in a Famix model.
The origin information is recovered from the tags using the configured keys.
"
Class {
	#name : 'OTelFamixOriginLinker',
	#superclass : 'OTelFamixLinker',
	#category : 'Famix-OpenTelemetry-Importer-Value',
	#package : 'Famix-OpenTelemetry-Importer-Value'
}

{ #category : 'transforming' }
OTelFamixOriginLinker >> linkOrigin: span [
	"Link the span origin to the method in the Famix model."

	span origin: (importer entityFinder
			 findMethodWithSignature: (span tags at: methodKey)
			 in: (importer loadTypeNamed: (span tags at: classKey)))
]

{ #category : 'transforming' }
OTelFamixOriginLinker >> linkSpan: span [

	self linkOrigin: span
]
