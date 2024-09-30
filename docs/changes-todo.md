# TODO, Bugs & Changes

This page only lists changes w/ regard to the documentation and general organization
of the Beacon project site(s) as well as with overarching repository organization.

## Changes

### 2024-08-08: [genomebeacons.org](https://genomebeacons.org) now default Beacon domain

We have now migrated towards general use fo the `genomebeacons.org` domain for
Beacon-related services and documentation. The main addresses are:

* [genomebeacons.org](https://genomebeacons.org) - main site for information, news ...
* [docs.genomebeacons.org](https://docs.genomebeacons.org) - documentation site for API development and implementations

In due course we will disentangle the current pages and purge the more general Beacon
information from [docs.genomebeacons.org](https://docs.genomebeacons.org). A start
has been made with the **F**requently **A**sked **Q**uestions section which is now under
[genomebeacons.org/FAQ](https://genomebeacons.org/FAQ).

The old domain [beacon-project.io](https://beacon-project.io) still exists but
is only used for forwarding.


### 2023-06-12: Restructured and extended documentation

* new separation of navigation areas into "Introducing Beacon", "Using Beacons",
  "Creating Beacons" and "Beacon Development", with subtopics such as "Data Discovery",
  "Data Delivery" ...
* combined "what-is-beacon-v2" into rewritten index page
* new pages for "Data Delivery": [Biosamples, Variants...](/records/) and
  [Data Handovers](/handovers/) - so far limited content

@mbaudis

### 2023-06-04: Improved filter documentation & HTTPS

* extended & clarified "filters" documentation
    - [filter types](/filters/#filter-types) in line with specification
    - example for pseudo-numerical [value queries](/filters/#pseudo-numerical-value-queries) in `GET` context
* fixed `HTTPS` issue (by brute-forcing all links on site to `https://`)

@mbaudis

### 2023-03-14: New `website-docs` branch

To protect the code branches we are using now a separate ``website-docs`` branch in `beacon-v2` for documentation
website updates. Please make sure all documentation edits happen there!

@mbaudis

### 2022-06-20: Retiring of `beacon-framework-v2` and `beacon-v2-Models` repos

* all issues and PRs were either resolved or transferred to this repository
* [x] repos were clearly labeled as `archived` w/ pointers to this one here and
archived (_i.e._ set to read only)
* also archiving of the `implementations-v2` repository (part of documentation)

### 2022-05-11: Retiring ReadTheDocs configuration & more

* removed ReadTheDocs configuration files
* added some "how to implement" instructions

### 2022-04-21: GA4GH approval notice

### 2022-04-18: Documentation updates

* Shuffled small fragments to facilitate comprehension.

### 2022-04-17: Documentation updates

* Updated default schemas tables according to the newest changes.
* Moved `filters.md` from section _Beacon Components_ to _Implement..._.
* Dismissed pages w/o content (`_rest-api.md` and `_tips-for-implementers.md`).
* Dismissed link to RTD version (deprecated).

### 2022-04-01: Documentation updates

* Partial update of Default schemas Tables (still work in progress)
* Updated `bin` files that parse JSON schemas

### 2022-03-30: Documentation updates

* Updated diagram in [Models](models.md#Introduction) page.
* Removal of some outdated text, e.g. reference to TEMPLATE model (for now)
* continuous updates from upstream

### 2022-03-28: Documentation updates

* added content to the [Standards](formats-standards.md) page (VRS, Phenopackets, coordinates)
* [Queries](variant-queries.md) page now with comparison table for (some) variant type terms

### 2022-03-25: Miscellanea changes in `docs/*.md`

* Changes in multiple Markdown pages.
* Moved from `mermaid` to `mermaid2` plugin.

### 2022-03-24: Retiring Separate _Implementations_ Repository

* Started adding content to pages such as `networks.md and `roles.md`
* Moved pages to different locations in navigation. Created `security.md` under *Beacon Types*.
* Example implementations have been moved from the [`implementations-v2` repository](https://github.com/ga4gh-beacon/implementations-v2) to the [Beacon v2 Documentation](https://github.com/ga4gh-beacon/beacon-v2/edit/main/docs/implementations/) - web [access here](https://docs.genomebeacons.org/other-implementations/).

### 2022-03-23: Name Change to `beacon-v2`

* The repository name and file paths have been changed from `beacon-v2-unity-testing`
to `beacon-v2`.
* Added miscellanea suggestions from Jorge (not all of them).

### 2022-03-22: More Reorganization of Navigation

* Moved content from `implementations-and-networks` to `other-implementations` and left only the "Networks" Part.
* Added `mkdocs-mermaid2-plugin` both to `mkdocs.yaml` and to github workflows.
* Moved Schemas (Markdown Tables) and Terms List from main navigation to `Beacon Compoments/Models`
* Reorganization of navigation
* Added pages: [Tips for Implementers](_tips-for-implementers.md)

### 2022-03-21: Reorganization of navigation

* Reorganization of navigation
* Deleted page `implement-and-deploy.md`
* Added pages: [What is Beacon v2](what-is-beacon-v2.md) and [Implementation options](implementations-options.md)
* [Filters](filters.md) Page Updated

### 2022-03-18: Macros and Variables for Documentation pages

The `mkdocs-macros-plugin` has been activated, allowing the use of site-wide variables:

* `repo_model_url: https://github.com/ga4gh-beacon/beacon-v2/tree/main/models/src`
* this can be used inline as `{{config.repo_model_url}}`

### 2022-03-16: Documentation Content and Formats Updates

* [x] addition of more variant query examples
* [x] new landing pages for `Implementations and Networks` and [Standards Integration](formats-standards.md)
* [x] many adjustments to documentation structure, appearance and representation (e.g. content tabs for query examples)

### 2022-03-14: Documentation in Repository

As of today the new/emerging Beacon v2 documentation is meintained in this repository. We're testing rendered versions (same text/code base) through Github actions ([here](https://genomebeacons.org/beacon-v2/)) and [ReadTheDocs](https://beacon-v2-unity.readthedocs.io/en/latest/).

* [x] testing of [ReadTheDocs version](https://beacon-v2-unity.readthedocs.io/) vs. a [`material` themed build](https://genomebeacons.org/beacon-v2/)
* [x] created and linked [docs.genomebeacons.org](https://docs.genomebeacons.org)
sub-domain to the Github hosted version of the rendered documentation
* [x] merging of previous separate documentation repository content from _beacon-v2-schema-documentation_
in the "unity" repository and archiving of the old one

### 2022-03-11: Removing `yaml` export version

Since moving to source in YAML the existence of a separate `yaml` export seems unnecessary & maybe confusing. Removed.

### 2022-03-09: Nesting models

The structure of the `models` directory has now be changed to have the default model as one of possibly multiple
options as per the discussions in [#1](https://github.com/ga4gh-beacon/beacon-v2/issues/1).
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

### 2022-03-08: Automated pulling from current origin repos

* added simple pull commands to the conversion for automatic update to the donor repos

```
git -C $BEACONMODELPATH pull
git -C $BEACONFRAMEWORKPATH pull
```

* updated to current crop of PRs

### 2022-02-24: Path fixes

* changed the path replacements to the current repo, resulting in e.g. <https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2/main/framework/json/responses/sections/beaconInformationalResponseMeta.json>

### 2022-02-23: Re-tool

* [x] replacement of the previopus general `yamler.py` with a dedicated `beaconYamler.py`
* [x] moving replacements to [bin/config.yaml](https://github.com/ga4gh-beacon/beacon-v2/bin/config.yaml)
* [x] requirement for complete arguments (in and out paths, in- and out formats) - see [bin/yamlerRunner.sh](https://github.com/ga4gh-beacon/beacon-v2/bin/yamlerRunner.sh)

### 2022-02-22: Creation of repository

* [x] design of directory structure
* [x] test tooling & population with auto-converted files

--------------------------------------------------------------------------------

## TODO

<!-- When done => please check & move to some dated item in Changes above -->

* [x] re-structuring of [Framework page](framework.md)
    - [ ] add part about necessary files, dependening on installation type (e.g. if not needing to support OpenAPI)
* [ ] add more [Implementations](other-implementations.md)
* [ ] extend [Query documentation](variant-queries.md)
    - [x] expand the table comparing different "variant types"
    - [ ] use more content from the variant scouts document


