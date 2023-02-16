"
I am a post-transformer that links `Span`s to their source in a `FamixJava` model.
The source information must be in the tags with keys ending with 'class' and 'method', and starting with a given prefix.

For example, with the prefix 'foo.', the tags 'foo.class' and 'foo.method' must exist.
"
Class {
	#name : #OTelFamixJavaLinker,
	#superclass : #OTelAbstractTransformer,
	#instVars : [
		'javaModel',
		'tagPrefix'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #accessing }
OTelFamixJavaLinker >> javaModel: model [

	javaModel := model
]

{ #category : #links }
OTelFamixJavaLinker >> link: aSpan valueAt: aName [

	"Link the serialized Java value accessed with the given name to the Java model."

	| value |
	value := (NeoJSONReader on: (aSpan tags at: aName) readStream)
		         parseValue.
	value halt "WIP"
]

{ #category : #links }
OTelFamixJavaLinker >> linkOrigin: aSpan [

	"Link to the span origin in the Java model"

	| tags name origin |
	tags := aSpan tags.
	name := tags at: tagPrefix , 'class'.
	origin := javaModel allClasses detect: [ :class | class name = name ].

	name := tags at: tagPrefix , 'method'.
	origin := origin methods detect: [ :method | method name = name ].
	aSpan origin: origin
]

{ #category : #accessing }
OTelFamixJavaLinker >> tagPrefix: aString [

	tagPrefix := aString
]

{ #category : #transforming }
OTelFamixJavaLinker >> value: model [

	"Link trace model with a Java model using class, method, args and result tags."

	tagPrefix := tagPrefix ifNil: ''.
	(model allWithType: FamixOTelSpan) do: [ :span | 
		self linkOrigin: span.
		self link: span valueAt: tagPrefix , 'args'.
		self link: span valueAt: tagPrefix , 'result' ].
	^ model
]
