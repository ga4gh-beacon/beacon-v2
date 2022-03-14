# Unified repository for Beacon v2 (_UNDER CONSTRUCTION_)

## Description

This repository is intended as a unification and replacement of the main repositories representing the Beacon API:

* [beacon-framework-v2](https://github.com/ga4gh-beacon/beacon-framework-v2)
* [beacon-v2-Models](https://github.com/ga4gh-beacon/beacon-v2-Models)
* [beacon-v2-schema-documentation](https://github.com/ga4gh-beacon/beacon-v2-schema-documentation)

As with other schema projects, here we separate between the schema source files (in `src`; JSON-Schema written in YAML) and the generated versions for referencing. The current setup allows already the direct referencing of the generated JSON schemas but has not been tested yet in its completeness using e.g. the Beacon Verifier. Examples:

* `ontologyTerm`:
    - YAML (source): <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2-unity-testing/main/framework/src/common/ontologyTerm.yaml>
    - JSON: <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2-unity-testing/main/framework/json/common/ontologyTerm.json>
* `beaconRequestBody`:
    - YAML (source): <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2-unity-testing/main/framework/src/requests/beaconRequestBody.yaml>
    - JSON: <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2-unity-testing/main/framework/json/requests/beaconRequestBody.json>

### Status

At this stage, since the development work still is performed in the framework and model repositories, the `src` content is beeing generated automatically (using local versions of the repositories) and modified - steps 1 & 2 - followed by the export of the schemas (step 3):

1. convert `.json` files from original framework & model repositories into `.yaml` [./framework/src/](./framework/src/) and [./models/src/](./models/src/), using [./tools/yamlerRunner.sh](./tools/yamlerRunner.sh) with [./tools/beaconYamler.py](./tools/yamler.py).
2. perform some text replacements over the source tree (see [./tools/config.yaml](./tools/config.yaml) - more may be needed?
3. re-write the modified YAML source files into the output `json` and `yaml` directories

Steps 1 & 2 obviously won't be necessary after transitioning to the respective `src` files as the working versions. Step 3 will be converted into a GH action.

### TODO

* integrate the documentation repository & generation of the schema tables from `src`
* (in the long run) switch to manual maintenance/editing of `src` and retire the current framework and model repos

### Changes

#### 2022-03-11: Removing `yaml` export version

Since moving to having the source in YAML the existence of a separate `yaml` export seems unnecessary & maybe confusing. Removed.


#### 2022-03-09: Nesting models

The structure of the `models` directory has now be changed to have the default model as one of possibly multiple
options as per the discussions in [#1](https://github.com/ga4gh-beacon/beacon-v2-unity-testing/issues/1).
The current structure (below) might not be final (e.g. placing of the `beaconConfiguration.yaml`, `beaconMap.yaml`, `endpoints.yaml` files?).

```
beacon
  |
  |-- framework ...
  |-- models
  |    |-- src
  |    |    |-- beacon-v2-default-model
  |    |         |-- analyses ...
  |    |         |-- biosamples ...
  |    |         |-- genomicVariations ...
  |    |         |-- ...
  |    |         |-- endpoints.yaml
  |    |     
  |    |-- json
  |    |    |-- beacon-v2-default-model
  |    |         |-- analyses ...
  |    |         |-- biosamples ...
  |    |         |-- genomicVariations ...
  |    |         |-- ...
  |    |         |-- endpoints.yaml
  |    |          
...
```

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

