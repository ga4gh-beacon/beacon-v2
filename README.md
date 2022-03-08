# Unified repository for Beacon v2 - For Testing Only

## Description

This repository is intended as a unification and replacement of the main repositories representing the Beacon API:

* [beacon-framework-v2](https://github.com/ga4gh-beacon/beacon-framework-v2)
* [beacon-v2-Models](https://github.com/ga4gh-beacon/beacon-v2-Models)
* [beacon-v2-schema-documentation](https://github.com/ga4gh-beacon/beacon-v2-schema-documentation)

As with other schema projects, here we separate between the schema source files (in `src`; JSON-Schema written in YAML) and the generated versions for referencing. The current setup allows already the direct referencing of the generated JSON schemas but has not been tested yet in its completeness using e.g. the Beacon Verifier. Examples:

* `ontologyTerm`:
    - JSON: <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2-unity-testing/main/framework/json/common/ontologyTerm.json>
    - YAML: <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2-unity-testing/main/framework/yaml/common/ontologyTerm.yaml>
* `beaconRequestBody`:
    - JSON: <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2-unity-testing/main/framework/json/requests/beaconRequestBody.json>
    - YAML: <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2-unity-testing/main/framework/yaml/requests/beaconRequestBody.yaml>

### Status

At this stage, the repository content is beeing generated automatically (using local versions of the repositories):

1. convert `.json` files from original framework & model repositories into `.yaml` [./framework/src/](./framework/src/) and [./models/src/](./models/src/), using [./tools/yamlerRunner.sh](./tools/yamlerRunner.sh) with [./tools/beaconYamler.py](./tools/yamler.py).
2. perform some text replacements over the source tree (see [./tools/config.yaml](./tools/config.yaml) - more may be needed?
3. re-write the modified YAML source files into the output `json` and `yaml` directories

### TODO

* integrate the documentation repository & generation of the schema tables from `src`
* (in the long run) switch to manual maintenance/editing of `src` and retire the current framework and model repos

### Changes

#### 2022-03-08: Automated pulling from current origin repos

* added simple pull commands to the conversion for automatic update to the donor repos
```
git -C $BEACONMODELPATH pull
git -C $BEACONFRAMEWORKPATH pull
```
* updated to current crop of PRs

#### 2022-02-24: Path fixes

* changed the path replacements to the current repo, resulting in e.g. <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2-unity-testing/main/framework/json/responses/sections/beaconInformationalResponseMeta.json>

#### 2022-02-23: Re-tool

* replacement of the previopus general `yamler.py` with a dedicated `beaconYamler.py`
* moving replacements to [./bin/config.yaml](./tools/config.yaml)
* requirement for complete arguments (in and out paths, in- and out formats) - see [./bin/yamlerRunner.sh](./bin/yamlerRunner.sh)

#### 2022-02-22: Creation of repository

* design of directory structure
* test tooling & population with auto-converted files

## Directory structure

```
|-docs          TBD; could contain the source for the Readthedocs documentation
|
|- framework
|   |
|   |- src      schema source in YAML format; for editing
|   |
|   |- json     JSON versions of the schema files generated from src, authorative/referenceable version
|   |
|   |- yaml     YAML versions of the schema files generated from src, for reference/testing
|
|- models
|   |
|   |- src      schema source in YAML format; for editing
|   |
|   |- json     JSON versions of the schema files generated from src, authorative/referenceable version
|   |
|   |- yaml     YAML versions of the schema files generated from src, for reference/testing
|
|- bin          scripts and configurations for creating the unified structure
    |
    |- yamlerRunner.sh    runs the conversions for the different repos and format options
    |
    |- beaconYamler.py    conversion app
    |
    |- config.yaml        text replacements and options
```

Steps 1 & 2 obviously won't be necessary after transitioning to the respective src files as the working versions. Step 3 would be converted into a GH action.
