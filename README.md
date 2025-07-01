# Unified repository for Beacon Code & Documentation

## Description

This repository is a unified repository representing the different parts of the Beacon API:

* [framework](framework)
* [models](models)
* Beacon v2 Documentation
    - authoritive source already in this repository [`/docs`](docs)
    - rendered version through [docs.genomebeacons.org](https://docs.genomebeacons.org)
    - Please note that edits to the documentation (and document generation) happens on/from the [website-docs](https://github.com/ga4gh-beacon/beacon-v2/tree/website-docs) branch!

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

## 2.2

*Released, July, 1, 2025*
[Beacon-v2.2](https://github.com/ga4gh-beacon/beacon-v2/tree/81dbe9c0ed693b4e897d81abb1043954bd2e65ba)

* De-restricting Resultset formats
* filteringTerms scope definition modification
* Rounding counts for queries with count responses

## 2.1.2

*Released, July, 1, 2025*
[Beacon-v2.1.2](https://github.com/ga4gh-beacon/beacon-v2/tree/8325ddf65d8bbfc71c235bce4dac98fb2cf0af81)

* Fix incorrect reference in models
* Removing filtering terms references specific to each entry type
* Removing ft examples for configuration
* Delete /configuration/filteringTermsSchema.yaml/json
* src -> json cosmetics fix
* Fix for failing timeElement validation
* Fix complexValue example
* Schema urgent fixes endpoints all absolute paths
* Fix date-time format string
* Changes for issue 156 OpenAPI related

## 2.1.1

*Released, December 13, 2024*
[Beacon-v2.1.1](https://github.com/ga4gh-beacon/beacon-v2/tree/47af89c8fd199d2674e5ca7fb504815ebc145e63)

* Updated links for make beacon compatible with upgraded VRS version 1.3
* Changed uri for uri-template in Endpoint.singleEntryUrl
* Moved info definition from beaconCommonComponents to an own common info schema
* Added links to each of the schema version releases in the changelog
* Improved inline documentation
* Deleted includedConcepts from aCollectionOf
* Removed the particular filteringTermsUrl entry related to a particular entry type
* Moved default outside items object to the same items level
* Defined content for default property in OpenAPI
* Created examples for filters in OpenAPI
* Moved default property in to the lowest level for securityLevels property in OpenAPI
* Redefined includeResultsetResponses in OpenAPI
* Defined content for responses in OpenAPI
* Refactored definitions for $defs
* Implemented new feature for filteringTerms values

## 2.1.0

*Released, July, 19, 2024*
[Beacon-v2.1.0](https://github.com/ga4gh-beacon/beacon-v2/tree/16862205c79294fae5473f7fa330bf5929b3b120)

* Relocated TypedQuantity required to proper level of the schema for complexValue
* Added end and start entities for ageRange and iso8601duration for age
* Filtering terms scopes changed from string to array of strings

## 2.0.1

*Released July, 16, 2024*
[Beacon-v2.0.1](https://github.com/ga4gh-beacon/beacon-v2/tree/f6f85c445922831bd398552384593206c86287de)

* Replaced ENSGLOSSARY for SO ontology family in documentation examples
* Moved CURIE to beaconCommonComponents
* Created filtering terms entity
* Removed validation directories
* Several fixes to entity types, typos and other non-breaking changes

## 2.0.0

*Released June, 21, 2022*
[Beacon-v2.0.0](https://github.com/ga4gh-beacon/beacon-v2/tree/d07ef1626321f7428374a4f68d864dfa5e98370f)

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

