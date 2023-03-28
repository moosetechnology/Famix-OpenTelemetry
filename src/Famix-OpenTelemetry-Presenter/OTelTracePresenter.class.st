Class {
	#name : #OTelTracePresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'tree',
		'label',
		'activationBlock'
	],
	#category : #'Famix-OpenTelemetry-Presenter'
}

{ #category : #'inspector extensions' }
OTelTracePresenter >> activateOnSingleClick [
	tree activateOnSingleClick
]

{ #category : #initialization }
OTelTracePresenter >> initialize [
	super initialize.
	activationBlock := [ :val | ]
]

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
			 yourself).
	tree whenActivatedDo: [ :selection | activationBlock value: selection ]
]

{ #category : #initialization }
OTelTracePresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Trace viewer';
		initialExtent: 450 @ 200
]

{ #category : #'inspector extensions' }
OTelTracePresenter >> outputActivationPort [
	^ (SpActivationPort newPresenter: self)
		yourself
]

{ #category : #'inspector extensions' }
OTelTracePresenter >> whenActivatedDo: aBlock [
	activationBlock := aBlock
]
