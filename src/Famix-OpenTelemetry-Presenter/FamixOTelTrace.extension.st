Extension { #name : #FamixOTelTrace }

{ #category : #'*Famix-OpenTelemetry-Presenter' }
FamixOTelTrace >> inspectionTrace: aBuilder [

	<inspectorPresentationOrder: -1 title: 'Trace'>
	^ OTelTracePresenter on: self
]
