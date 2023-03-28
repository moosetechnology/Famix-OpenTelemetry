Extension { #name : #FamixOTelSpan }

{ #category : #'*Famix-OpenTelemetry-Presenter' }
FamixOTelSpan >> inspectionSpan: aBuilder [

	<inspectorPresentationOrder: -1 title: 'OTel Span'>
	^ OTelSpanPresenter on: self
]
