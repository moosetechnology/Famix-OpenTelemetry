# Famix-OpenTelemetry

Famix metamodel for [OpenTelemetry](https://opentelemetry.io) traces.

## Installation

```st
Metacello new
  githubUser: 'moosetechnology' project: 'Famix-OpenTelemetry' commitish: 'main' path: 'src';
  baseline: 'FamixOpenTelemetry';
  load
```

## Modelizing values

It is possible to modelize serialized runtime values stored in traces using [Famix-Value](https://github.com/moosetechnology/Famix-Value), by loading the `Value` group:

```st
Metacello new
  githubUser: 'moosetechnology' project: 'Famix-OpenTelemetry' commitish: 'main' path: 'src';
  baseline: 'FamixOpenTelemetry';
  load: 'Value'
```
