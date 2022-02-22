# beacon-v2-unity
Unified repository for Beacon v2 Components - For Testing Only

At this stage, the repository content has been generated automatically:

1. convert `.json` files from original framework & model repositories into `.yaml` [./framework/src/](./framework/src/) and [./models/src/](./models/src/), using [./tools/yamlerRunner.sh](./tools/yamlerRunner.sh) with [./tools/yamler.py](./tools/yamler.py). (<= code quality "prototyping")
2. perform some text replacements over the source tree (see [./tools/replacements.txt](./tools/replacements.txt) - more may be needed?
3. re-write the modified YAML source files into the output `json` and `yaml` directories

## Directory structure

```
|-docs              TBD; could contain the source for the Readthedocs documentation
|
|- framework
|   |
|   |- src          schema source in YAML format; for editing
|   |
|   |- json         JSON versions of the schema files generated from src, intended as the authorative/referencable version
|   |
|   |- yaml         YAML versions of the schema files generated from src, intended as the authorative/referencable version
|
|- models
|   |
|   |- src          schema source in YAML format; for editing
|   |
|   |- json         JSON versions of the schema files generated from src, intended as the authorative/referencable version
|   |
|   |- yaml         YAML versions of the schema files generated from src, intended as the authorative/referencable version
```
