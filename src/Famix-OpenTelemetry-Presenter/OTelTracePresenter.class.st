Class {
	#name : #OTelTracePresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'tree',
		'label'
	],
	#category : #'Famix-OpenTelemetry-Presenter'
}

{ #category : #initialization }
OTelTracePresenter >> initializePresenters [

	tree := SpTreePresenter new.
	tree children: [ :el | el children ].
	tree roots: (self model spans select: [ :sp | sp parent isNil ]).
	label := SpLabelPresenter new.
	label label:
		(String streamContents: [ :stream | self model printOn: stream ]).
	self layout: (SpBoxLayout newTopToBottom
			 add: label expand: false fill: false;
			 add: tree expand: true fill: true;
			 yourself)
]

{ #category : #initialization }
OTelTracePresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Trace viewer';
		initialExtent: 450 @ 200
]
