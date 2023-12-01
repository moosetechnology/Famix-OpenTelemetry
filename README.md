[![Moose version](https://img.shields.io/badge/Moose-10-%23aac9ff.svg)](https://github.com/moosetechnology/Moose)
[![Moose version](https://img.shields.io/badge/Moose-11-%23aac9ff.svg)](https://github.com/moosetechnology/Moose)
![Build Info](https://github.com/moosetechnology/Famix-OpenTelemetry/workflows/CI/badge.svg)
[![Coverage Status](https://coveralls.io/repos/github/moosetechnology/Famix-OpenTelemetry/badge.svg?branch=main)](https://coveralls.io/github/moosetechnology/Famix-OpenTelemetry?branch=main)

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
To support this modularity, the importer works like an ELT pipeline.  
- **Extractors** retrieve the raw trace data from a source outside the image and deserialize it.
Some extractors can output the retrieved data to a file, by configuring them with `outputFilename:`.
The data can then be extracted from the file, for example with `OTelJSONFileExtractor`.  
- **Loaders** understand a specific raw data structure and use it to build the model.  
- **Transformers** are optional, they can process or apply modifications to the trace model.

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

### Supported Telemetry Aggregators

| Aggregator | Baseline |
|---|---|
| Zipkin | default |
| Elasticsearch | `elasticsearch` |

### Available Transformers

| Transformer | Description | Baseline |
|---|---|---|
| TagTransformer | modifies `Span` tags that match a predicate with a pluggable block | default |
| FamixLinker | links `Span`s to their origin in a Famix model | default |
| FamixValueLinker | links origin and generates a FamixValue model from serialized arguments and result | `value` |

### Examples

#### Example with ElasticSearch

```st
Metacello new
  githubUser: 'moosetechnology' project: 'Famix-OpenTelemetry' commitish: 'main' path: 'src';
  baseline: 'FamixOpenTelemetry';
  load: 'elasticsearch'.

elasticExtractor := OTelElasticsearchExtractor new.
elasticExtractor
  beHttps;
  endpoint: 'endpointToElastic';
  index: '<your index name>';
  apiKey: '<your api key>';
  size: 30.

importer := OpenTelemetryImporter new.
importer
  extractor: elasticExtractor;
  loader: OTelElasticsearchOtelLoader new.
model := importer import. "returns a filled FamixOTelModel"

model allWithType: FamixOTelTrace.
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
        model: traceModel;
        "configure an entity finder, this one is for searching a FamixJava model"
        entityFinder: (FamixJavaEntityFinder new model: javaModel)) }.
importer import. "fills traceModel with FamixOTel and FamixValue entities"
```
