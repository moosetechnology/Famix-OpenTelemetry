"
Generates JaCoCo reports from raw execution data embedded in traces.
"
Class {
	#name : 'OTelJaCoCoCoverageReporter',
	#superclass : 'OTelAbstractTransformer',
	#instVars : [
		'coverageKey',
		'jarPath',
		'outputPath',
		'classPaths'
	],
	#category : 'Famix-OpenTelemetry-Importer-Coverage',
	#package : 'Famix-OpenTelemetry-Importer-Coverage'
}

{ #category : 'accessing' }
OTelJaCoCoCoverageReporter >> classPaths [

	^ classPaths
]

{ #category : 'accessing' }
OTelJaCoCoCoverageReporter >> classPaths: aStringCollection [

	classPaths := aStringCollection
]

{ #category : 'accessing' }
OTelJaCoCoCoverageReporter >> coverageKey [

	^ coverageKey
]

{ #category : 'accessing' }
OTelJaCoCoCoverageReporter >> coverageKey: aString [

	coverageKey := aString
]

{ #category : 'transforming' }
OTelJaCoCoCoverageReporter >> extractCoverageFrom: span [

	| filename |
	filename := span name , '.' , span hash asString.
	(outputPath asFileReference / filename , 'exec') ensureDelete
		ensureCreateFile binaryWriteStreamDo: [ :s |
		s nextPutAll: (span tags at: coverageKey) base64Decoded ].

	LibC runCommand: (self htmlWriteCommandForFileNamed: filename).
	LibC runCommand: (self writeCommandForFileNamed: filename).

	span cacheAt: #coverage put: outputPath , '/' , filename , '.xml'
]

{ #category : 'writing' }
OTelJaCoCoCoverageReporter >> htmlWriteCommandForFileNamed: filename [

	| outputFullPath |
	outputFullPath := (outputPath asFileReference / filename)
		                  absolutePath pathString.
	^ String streamContents: [ :s |
		  s << 'eval $(printf "java -jar \"' << jarPath << '\" report \"'
		  << outputFullPath << '.exec\" --html \"' << outputFullPath
		  << '\" "; java -jar "' << jarPath << '" execinfo "'
		  << outputFullPath << '.exec" | tail -n +4 | awk -v paths="'.
		  classPaths
			  do: [ :path | s nextPutAll: path ]
			  separatedBy: [ s nextPut: $, ].
		  s nextPutAll:
			  '" ''BEGIN {split(paths, dirs, ",")} {for (i in dirs) {file=dirs[i] "/" $NF ".class"; if (system("[ -f \"" file "\" ]") == 0) {print "--classfiles \"" file "\""; break}}}'' | tr "\n" " ")' ]
]

{ #category : 'accessing' }
OTelJaCoCoCoverageReporter >> jarPath [

	^ jarPath
]

{ #category : 'accessing' }
OTelJaCoCoCoverageReporter >> jarPath: aString [

	jarPath := aString
]

{ #category : 'accessing' }
OTelJaCoCoCoverageReporter >> outputPath [

	^ outputPath
]

{ #category : 'accessing' }
OTelJaCoCoCoverageReporter >> outputPath: aString [

	outputPath := aString
]

{ #category : 'transforming' }
OTelJaCoCoCoverageReporter >> value: model [

	model allSpans do: [ :span | self extractCoverageFrom: span ].
	^ model
]

{ #category : 'writing' }
OTelJaCoCoCoverageReporter >> writeCommandForFileNamed: filename [
	"This command generates a JaCoCo report for the given execution data file and saves the result as an XML file.
	It dynamically appends all relevant `--classfiles` arguments for classes associated with the execution data.
	These class files are searched in multiple directories (`paths`) and filtered to include only those that exist.
	Components of the command:
	- `eval` executes the dynamically constructed command.
	- `printf` prints the fixed portion of the JaCoCo report command.
	- `java -jar ... execinfo ...` lists the class names associated with the execution data.
	- `tail -n +4` skips the first three lines of metadata in the `execinfo` output.
	- `awk` processes the class names to:
		1. Define potential directories containing `.class` files (stored in `paths`).
		2. Iterate over the directories to check if the `.class` file exists.
		3. Append the valid `--classfiles` argument for the first directory where the `.class` file is found.
	- `tr '\n' ' '` combines all `--classfiles` arguments into a single line."

	| outputFullPath |
	outputFullPath := (outputPath asFileReference / filename)
		                  absolutePath pathString.
	^ String streamContents: [ :s |
		  s << 'eval $(printf "java -jar \"' << jarPath << '\" report \"'
		  << outputFullPath << '.exec\" --xml \"' << outputFullPath
		  << '.xml\" "; java -jar "' << jarPath << '" execinfo "'
		  << outputFullPath << '.exec" | tail -n +4 | awk -v paths="'.
		  classPaths
			  do: [ :path | s nextPutAll: path ]
			  separatedBy: [ s nextPut: $, ].
		  s nextPutAll:
			  '" ''BEGIN {split(paths, dirs, ",")} {for (i in dirs) {file=dirs[i] "/" $NF ".class"; if (system("[ -f \"" file "\" ]") == 0) {print "--classfiles \"" file "\""; break}}}'' | tr "\n" " ")' ]
]
