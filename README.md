# Unified repository for Beacon v2 Code & Documentation

## Description

This repository is intended as a unification and replacement of the main repositories representing the Beacon API:

---
**NOTE**

At this time we still process changes in the original Beacon v2 development repositories:

* [beacon-framework-v2](https://github.com/ga4gh-beacon/beacon-framework-v2)
* [beacon-v2-Models](https://github.com/ga4gh-beacon/beacon-v2-Models)

The schema links below represent daily updated versions pulled from these development
repositories.

---

* [framework](framework)
* [models](models)
* Beacon v2 Documentation
    - authoritive source already in this repository [`/docs`](docs)
    - rendered version through [here](https://beacon-project.io/beacon-v2/) (alternative address is [docs.genomebeacons.org](http://docs.genomebeacons.org))

As with other schema projects, here we separate between the schema source files (in `src`; JSON-Schema written in YAML) and the generated versions for referencing. The current setup allows already the direct referencing of the generated JSON schemas but has not been tested yet in its completeness using e.g. the Beacon Verifier. Examples:

* `ontologyTerm`:
    - YAML (source): <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2/main/framework/src/common/ontologyTerm.yaml>
    - JSON: <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2/main/framework/json/common/ontologyTerm.json>
* `beaconRequestBody`:
    - YAML (source): <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2/main/framework/src/requests/beaconRequestBody.yaml>
    - JSON: <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2/main/framework/json/requests/beaconRequestBody.json>

### Status

At this stage, since the development work still is performed in the framework and model repositories, the `src` content is beeing generated automatically (using local versions of the repositories) and modified - steps 1 & 2 - followed by the export of the schemas (step 3):

1. convert `.json` files from original framework & model repositories into `.yaml` [framework/src/](framework/src/) and [models/src/](models/src/), using [bin/yamlerRunner.sh](bin/yamlerRunner.sh) with [./tools/beaconYamler.py](bin/beaconYamler.py).
2. perform some text replacements over the source tree (see [./tools/config.yaml](bin/config.yaml) - more may be needed?
3. re-write the modified YAML source files into the output `json` directory

Steps 1 & 2 obviously won't be necessary after transitioning to the respective `src` files as the working versions. Step 3 will be converted into a GH action.

### TODO

* integrate the documentation repository & generation of the schema tables from `src`
* (in the long run) switch to manual maintenance/editing of `src` and retire the current framework and model repos

### Changes

* change notes with respect to the repository & documentation are now in [docs.genomebeacons.org](http://docs.genomebeacons.org/bugs-changes-log/)

## Directory structure

```
|-docs          TBD; will contain the source for the Readthedocs documentation
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

