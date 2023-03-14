# Famix-OpenTelemetry

Famix metamodel for [OpenTelemetry](https://opentelemetry.io) traces.

## Installation

```st
Metacello new
  githubUser: 'moosetechnology' project: 'Famix-OpenTelemetry' commitish: 'main' path: 'src';
  baseline: 'FamixOpenTelemetry';
  load
```

## Importing

OpenTelemetry traces can be stored in a variety of telemetry backends, such as Zipkin or any OTelCollector.
To support this modularity, the importer works as a pipeline configured with an extractor, which fetches the raw trace data, and a loader, which parses the data and builds the model.
In addition, it can be configured with transformers to process or apply modifications to the trace model.

```st
importer := OpenTelemetryImporter new.
importer
  extractor: (OTelZipkinExtractor new endpoint: 'http://localhost:9411');
  loader: OTelZipkinLoader new;
  transformers: { OTelTagTransformer new
      predicate: [ :tag | "match a tag" ];
      block: [ :value | "compute its new value" ] }.
importer import. "returns a filled FamixOTelModel"
```

## Modeling Values

It is possible to model serialized runtime values stored in traces using [Famix-Value](https://github.com/moosetechnology/Famix-Value).
To enable this feature, load the `value` group:

```st
Metacello new
  githubUser: 'moosetechnology' project: 'Famix-OpenTelemetry' commitish: 'main' path: 'src';
  baseline: 'FamixOpenTelemetry';
  load: 'value'
```

A transformer, such as an instance of `OTelFamixValueLinker`, can be added to the import pipeline to create a FamixValue model.
The values can also be linked to the model of the application that produced them by configuring the given FamixValue importer.
In order to enable navigation between the traces and the values when inspecting entities, they must coexist in the same `FamixOTelValueModel`.

```st
traceModel := FamixOTelValueModel new.
javaModel := MooseModel root at: 1. "model of the Java application that produced the traces"
importer loader: (OTelZipkinLoader new model: traceModel).
importer transformers: { OTelFamixValueLinker new
    "keys of tags containing the relevant values"
    classKey: 'class';
    methodKey: 'method';
    argsKey: 'arguments';
    resultKey: 'result';
    "configure a FamixValue importer, this one understands JSON from the Jackson Java library"
    importer: (FamixValueJavaJacksonImporter new
         linkedModel: javaModel;
         model: traceModel) }.
importer import. "fills traceModel with FamixOTel and FamixValue entities"
```
