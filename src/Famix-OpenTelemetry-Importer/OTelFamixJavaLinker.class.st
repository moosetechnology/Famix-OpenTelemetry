"
I am a post-transformer that links `Span`s to their source in a `FamixJava` model.
The source information must be in the tags with keys ending with 'class' and 'method', and starting with a given prefix.

For example, with the prefix 'foo.', the tags 'foo.class' and 'foo.method' must exist.

I understand the JSON format from the Jackson library and await the fully qualified name as type information.
"
Class {
	#name : #OTelFamixJavaLinker,
	#superclass : #OTelFamixLinker,
	#instVars : [
		'classKey',
		'methodKey',
		'argsKey',
		'resultKey'
	],
	#category : #'Famix-OpenTelemetry-Importer'
}

{ #category : #accessing }
OTelFamixJavaLinker >> argsKey: aString [

	argsKey := aString
]

{ #category : #accessing }
OTelFamixJavaLinker >> classKey: aString [

	classKey := aString
]

{ #category : #'private - utility' }
OTelFamixJavaLinker >> findType: fullyQualifiedName [

	| name |
	^ (famixModel allWithType: FamixJavaClass)
		  detect: ((fullyQualifiedName beginsWith: 'java.util.')
				   ifTrue: [ 
					   name := fullyQualifiedName copyAfterLast: $..
					   [ :class | class name = name ] ]
				   ifFalse: [ 
					   name := self mooseNameOf: fullyQualifiedName.
					   [ :class | class mooseName = name ] ])
		  ifNone: nil
]

{ #category : #'private - utility' }
OTelFamixJavaLinker >> isDictionary: type [

	^ type name = 'HashMap'
]

{ #category : #'private - utility' }
OTelFamixJavaLinker >> isPrimitiveType: type [

	^ type isPrimitiveType or: [ 
		  #( Integer int Float float Double double Long long Short short
		     Byte byte ArrayList ) includes: type name ]
]

{ #category : #links }
OTelFamixJavaLinker >> linkArgs: span [

	"Link the serialized arguments to the Famix model."

	| rawArgs arg |
	span origin parameters isEmpty ifTrue: [ ^ self ].
	rawArgs := (NeoJSONReader on: (span tags at: argsKey) readStream)
		           parseList at: 2. "type is always Object[]"
	Halt if: rawArgs size > 2.
	rawArgs withIndexDo: [ :rawArg :i | 
		arg := self makeInstance: rawArg.
		arg typedEntity: (span origin parameters at: i).
		span addArgument: arg ]
]

{ #category : #links }
OTelFamixJavaLinker >> linkOrigin: span [

	"Link to the span origin in the Java model."

	| name origin |
	origin := self findType: (span tags at: classKey).
	name := span tags at: methodKey.
	origin := origin methods detect: [ :method | method name = name ].
	span origin: origin
]

{ #category : #links }
OTelFamixJavaLinker >> linkResult: span [

	"Link the serialized Java value accessed with the given name to the Java model."

	span origin declaredType name = 'void' ifTrue: [ ^ self ].
	(self makeInstance:
			 (NeoJSONReader on: (span tags at: resultKey) readStream)
				 parseValue)
		typedEntity: span origin;
		otelSpan: span
]

{ #category : #'private - utility' }
OTelFamixJavaLinker >> makeInstance: rawValue [

	| instance type |
	rawValue isString ifTrue: [ 
		^ self newPrimitive
			  value: rawValue;
			  type: (self findType: 'java.util.String') ].
	rawValue isArray
		ifTrue: [ "primitive or enum value"
			type := self findType: (rawValue at: 1).
			instance := (self isPrimitiveType: type)
				            ifTrue: [ self newPrimitive ]
				            ifFalse: [ self newEnumValue ].
			instance value: rawValue.
			self halt ]
		ifFalse: [ "dictionary or object"
			type := self findType: (rawValue removeKey: '@type').
			rawValue removeKey: '@id' ifAbsent: nil.
			(self isDictionary: type)
				ifTrue: [ instance := self newPrimitive value: rawValue ]
				ifFalse: [ 
					instance := self newObject.
					self halt.
					rawValue associationsDo: [ :assoc | 
						(self makeInstance: assoc value)
							container: instance;
							typedEntity:
								(type attributes
									 detect: [ :attr | attr name = assoc key ]
									 ifNone: [ 
										 type inheritedAttributes
											 detect: [ :attr | attr name = assoc key ]
											 ifNone: nil ]) ] ].
			self halt ].

	^ instance type: type
]

{ #category : #accessing }
OTelFamixJavaLinker >> methodKey: aString [

	methodKey := aString
]

{ #category : #'private - utility' }
OTelFamixJavaLinker >> mooseNameOf: fullyQualifiedName [

	^ '::' join: (fullyQualifiedName splitOn: $.)
]

{ #category : #accessing }
OTelFamixJavaLinker >> resultKey: aString [

	resultKey := aString
]

{ #category : #transforming }
OTelFamixJavaLinker >> value: model [

	"Link trace model with a Java model using class, method, args and result tags."

	(model allWithType: FamixOTelSpan) do: [ :span | 
		self linkOrigin: span.
		self linkArgs: span.
		self linkResult: span ].
	^ model
]
