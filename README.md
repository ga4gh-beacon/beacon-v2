# Unified repository for Beacon v2 Code & Documentation

## Description

This repository is a unified repository representing the different parts of the Beacon API:

* [framework](framework)
* [models](models)
* Beacon v2 Documentation
    - authoritive source already in this repository [`/docs`](docs)
    - rendered version through [here](https://beacon-project.io/beacon-v2/) (alternative address is [docs.genomebeacons.org](https://docs.genomebeacons.org))

As with other schema projects, here we separate between the schema source files (in `src`; JSON-Schema written in YAML) and the generated versions for referencing. The current setup allows already the direct referencing of the generated JSON schemas. Examples:

* `ontologyTerm`:
    - YAML (source): 
        * edit: <https://github.com/ga4gh-beacon/beacon-v2/blob/main/framework/src/common/ontologyTerm.yaml>
        * raw: <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2/main/framework/src/common/ontologyTerm.yaml>
    - JSON: <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2/main/framework/json/common/ontologyTerm.json>
* `biosamples/defaultSchema`
    - YAML (source): 
        * edit: <https://github.com/ga4gh-beacon/beacon-v2/blob/main/models/src/beacon-v2-default-model/biosamples/defaultSchema.yaml>
        * raw: <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2/main/models/src/beacon-v2-default-model/biosamples/defaultSchema.yaml>
    - JSON: <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2/main/models/json/beacon-v2-default-model/biosamples/defaultSchema.yaml>
* `beaconRequestBody`:
    - YAML (source): <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2/main/framework/src/requests/beaconRequestBody.yaml>
    - JSON: <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2/main/framework/json/requests/beaconRequestBody.json>

There is a set of tools in [`/bin`](./bin/) to facilitate the conversion. ATM, after editing `...yaml` schema files somewhere in the `/src` tree, a (local) run of `bin/yamlerRunner.sh` - which re-generates the `....json` files in the `/json` tree) has to be performed before pushing changes.

### Changelog

## 2.1.0

*Released, July, 19, 2024*

* Relocated TypedQuantity required to proper level of the schema for complexValue
* Added end and start entities for ageRange and iso8601duration for age
* Filtering terms scopes changed from string to array of strings

## 2.0.1

*Released July, 16, 2024*

* Replaced ENSGLOSSARY for SO ontology family in documentation examples
* Moved CURIE to beaconCommonComponents
* Created filtering terms entity
* Removed validation directories
* Several fixes to entity types, typos and other non-breaking changes

## 2.0.0

*Released June, 21, 2022*

* change notes with respect to the repository & documentation are now in [docs.genomebeacons.org](https://docs.genomebeacons.org/changes-todo/)
* NOTE: on 2022-06-20 the previous development repositories have been archived:
    - ARCHIVE - [beacon-framework-v2](https://github.com/ga4gh-beacon/beacon-framework-v2)
    - ARCHIVE - [beacon-v2-Models](https://github.com/ga4gh-beacon/beacon-v2-Models)


## Directory structure

```
|-docs          Contain the source (Markdown) for the mkdocs generated documentation
|
|- framework
|   |
|   |- src      schema source in YAML format; for editing
|   |
|   |- json     JSON versions of the schema files generated from src, authorative/referenceable version
|
|- models
|   |
|   |- src      schema source in YAML format; for editing
|   |
|   |- json     JSON versions of the schema files generated from src, authorative/referenceable version
|
|- bin          scripts and configurations for creating the unified structure
    |
    |- yamlerRunner.sh    runs the conversions for the different repos and format options
    |
    |- beaconYamler.py    conversion app
    |
    |- config.yaml        text replacements and options
```

