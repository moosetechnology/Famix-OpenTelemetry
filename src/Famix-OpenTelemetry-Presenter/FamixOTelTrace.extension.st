Extension { #name : #FamixOTelTrace }

{ #category : #'*Famix-OpenTelemetry-Presenter' }
FamixOTelTrace >> inspectionTrace: aBuilder [

	<inspectorPresentationOrder: -1 title: 'OTel Trace'>
	^ OTelTracePresenter on: self
]
