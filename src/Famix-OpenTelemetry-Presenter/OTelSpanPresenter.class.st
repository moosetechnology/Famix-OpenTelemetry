Class {
	#name : #OTelSpanPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'tree',
		'label',
		'activationBlock',
		'table'
	],
	#category : #'Famix-OpenTelemetry-Presenter'
}

{ #category : #initialization }
OTelSpanPresenter >> initializePresenters [

	table := SpTablePresenter new.
	table
		beResizable;
		addColumn: (SpStringTableColumn title: 'Key' evaluated: #key);
		addColumn: (SpStringTableColumn title: 'Value' evaluated: #value);
		items: self model tags associations.
	self layout: (SpBoxLayout newTopToBottom
			 add: table expand: true fill: true;
			 yourself)
]

{ #category : #initialization }
OTelSpanPresenter >> initializeWindow: aWindowPresenter [

	aWindowPresenter
		title: 'Span viewer';
		initialExtent: 450 @ 200
]
