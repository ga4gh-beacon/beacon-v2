# Unified repository for Beacon v2 Components - For Testing Only (as of Feb '22)

At this stage, the repository content has been generated automatically:

1. convert `.json` files from original framework & model repositories into `.yaml` [./framework/src/](./framework/src/) and [./models/src/](./models/src/), using [./tools/yamlerRunner.sh](./tools/yamlerRunner.sh) with [./tools/yamler.py](./tools/yamler.py). (<= code quality "prototyping")
2. perform some text replacements over the source tree (see [./tools/replacements.txt](./tools/replacements.txt) - more may be needed?
3. re-write the modified YAML source files into the output `json` and `yaml` directories

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
|- tools        scripts and configurations for creating the unified structure
```

Steps 1 & 2 obviously won't be necessary after transitioning to the respective src files as the working versions. Step 3 would be converted into a GH action.
