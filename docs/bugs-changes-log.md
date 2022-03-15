# Bugs & Changes

## 2002-03-14: Documentation in Repository

As of today the new/emerging Beacon v2 documentation is meintained in this repository. We're testing rendered versions (same text/code base) through Github actions ([here](https://beacon-project.io/beacon-v2-unity-testing/)) and [ReadTheDocs](https://beacon-v2-unity.readthedocs.io/en/latest/).

* [ ](BUG) created and linked [docs.genomebeacons.org](http://docs.genomebeacons.org)
sub-domain to the Github hosted version of the rendered documentation
* [x]merging of previous separate documentation repository content from _beacon-v2-schema-documentation_
in the "unity" repository and archiving of the old one

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
  |         |-- beacon-v2-default-model
  |              |-- analyses ...
  |              |-- biosamples ...
  |              |-- genomicVariations ...
  |              |-- ...
  |              |-- endpoints.yaml
  |
  |-- bin ...
  |-- docs ...               
...
```

#### 2022-03-08: Automated pulling from current origin repos

* [x]added simple pull commands to the conversion for automatic update to the donor repos

```
git -C $BEACONMODELPATH pull
git -C $BEACONFRAMEWORKPATH pull
```

* [x]updated to current crop of PRs

#### 2022-02-24: Path fixes

* changed the path replacements to the current repo, resulting in e.g. <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2-unity-testing/main/framework/json/responses/sections/beaconInformationalResponseMeta.json>

#### 2022-02-23: Re-tool

* [x]replacement of the previopus general `yamler.py` with a dedicated `beaconYamler.py`
* [x]moving replacements to [./bin/config.yaml](./tools/config.yaml)
* [x]requirement for complete arguments (in and out paths, in- and out formats) - see [./bin/yamlerRunner.sh](./bin/yamlerRunner.sh)

#### 2022-02-22: Creation of repository

* [x]design of directory structure
* [x]test tooling & population with auto-converted files

