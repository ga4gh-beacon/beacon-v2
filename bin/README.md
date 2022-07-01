# Beacon Unifier & Documentation Tools

This directory contains some tools for schema conversion and testing as well as for
the generation of readable schema representations in the ReadTheDocs-style documentation.

## Repository Unification & Conversion

A conversion run currently is performed in a local setting with:

```
./yamlerRunner.sh
```
However, paths etc. depend on the local setup and can be modified in the shell
script.

## Use of `.yaml` or `.json` in **src** local `$ref` values

At this time we use `...schema.json` values in the local src schemas although
those are written in YAML and therefore the local references wouldn't work
(since the referenced source files would be `...schema.yaml`). This is just to
avoid errors when re-writing the files & assumes that the tested schemas then
always will be in the `json` tree.

We may change this; in principle local conversions could regex their way...

```
/\$ref:\s+((?!http)[^\s]+?)\.json([^\s]+?)?/$ref: $1.yaml$2/
```

... and vice versa. 

## Documentation for Automatic Generation of Markdown Tables from Schemas

See this [link](SCHEMAS2MD.md).
