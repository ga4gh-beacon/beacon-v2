# Repository and Branch Organization

The development of Beacon code and documentation happens in the [`beacon-v2` repository](https://github.com/ga4gh-beacon/beacon-v2).

## Core branches

### `main`

The `main` branch is the branch used for production, it reflects the last version that beacon v2 has reached by accomplishing the milestones that ga4gh has set for the beacon to be considered as a new version. It can only be committed by a PR from the develop branch and exceptionally by some hotfixes to correct errors spotted after its official deployment.

### `develop`

The `develop` branch is the branch used for development, it reflects the current state of the progress of development. It can be modified by all the PR from the feature branches that have been finished (this means that must include all the merges from the subfeature branches) and the PR must reach a consensus to be finally accepted.

### `website-docs`

This branch is used to maintain the website at <https://docs.genomebeacons.org>. The relevant files consists of anything under `/docs` as well as the configuration file (`/mkdocs.yaml`) and the workflow file for processing the pages under `/.github/workflows/mk-beacon-docs.yaml`.

Changes to the Markdown files in the `/docs` directory (and its children) will initiate the processing of the workflow file; updating of the website than may take some minutes.

### `gh-pages`

The `gh-pages` branch is generated from the `/docs` directory through its `mkdocs` workflow and contains the website itself. **Do not edit**

## Hotfix branches

These are the branches that are meant to fix some bugs that break the specifications and need an urgent fix. The branches are directly deployed towards the `main` branch.

### `entry-type-definitions-cleanup`

This branch aims to redefine the wording of the entry types in a way that makes more clear what are the entry types. As the old definitions could mislead to some confusions, this is a sensible change that is needed to directly affect the current modification.

<b>Current status:</b><span style="color:blue">Waiting for PR to be accepted.</span>

### `hotfix_filteringTermsResults`

As the beaconFilteringTermsResults.json "type" property of the FilteringTerm is ambiguous, this branch has the objective to fix this and make filtering terms object to be operative and ready to point to the filtering terms type.

<b>Current status:</b><span style="color:blue">Waiting for PR to be accepted.</span>

### `schema-urgent-fixes`

Some of the instances of the schema were missing attributes and other aspects that are required to make a beacon work. This is mandatory to be urgently fixed and this is the purpose of this branch deployment.

<b>Current status:</b><span style="color:blue">Waiting for PR to be accepted.</span>

## Feature and subfeature branches

The feature branches are the branches that bring a lot of changes together to change some specific part of the specifications. They can be composed by different subfeature branches that commit to them or just have one single working branch. The feature branches commit to the `develop` branch as they are the changes that will lead beacon to be upgraded to a new version. The subfeature branches commit to their parent feature branch, as they are a microchange of all the aspects that have to change in a new feature that is being developed. The branches are named as the main purpose of them, so it is made very clear what is the working area of them and the subfeature branches add the name of the feature branch they belong as a prefix followed by an underscore. The list of these feature branches with their subfeature branches is the one shown next:

### `clean-up`

#### `clean-up_sticky_modified_files`

<b>Current status:</b><span style="color:blue">Last commit by @jrambla.</span>

#### `clean-up_renaming_entity_to_entry_type`

<b>Current status:</b><span style="color:blue">Added in framework-refactor-entry-type-definitions branch by @mbaudis and waiting for a PR to be accepted.</span>

#### `clean-up_decouple-model-framework-refs`

<b>Current status:</b><span style="color:blue">Last commit by @mbaudis.</span>

#### `clean-up_move-CURIE-to-beaconCommonComponents`

<b>Current status:</b><span style="color:blue">This branch has not had any commit.</span>

#### `clean-up_de-snakify-token-names`

<b>Current status:</b><span style="color:blue">This branch has not had any commit.</span>

#### `clean-up_refactor-analysys-pipeline-info`

<b>Current status:</b><span style="color:blue">Last commit by @mbaudis.</span>

### `resultsets`

#### `resultsets_remove-requirement-results-resultsCount`

<b>Current status:</b><span style="color:blue">Last commit by @mbaudis.</span>

### `requestParameters`

#### `requestParameters_genomicVariations-fix`

<b>Current status:</b><span style="color:blue">Last commit by @mbaudis.</span>

#### `requestParameters_list-parameters-with-comma`

<b>Current status:</b><span style="color:blue">This branch has not had any commit.</span>

### `phenopackets`

#### `phenopackets_standards-alignment`

<b>Current status:</b><span style="color:blue">Last commit by @mbaudis.</span>

### `network`

#### `network_aggregator-and-networks-support`

<b>Current status:</b><span style="color:blue">This branch has not had any commit.</span>

#### `network_meta-add-aggregator-flag`

<b>Current status:</b><span style="color:blue">Last commit by @mbaudis.</span>

### `anyOf`

#### `anyOf_filteringTerms`

<b>Current status:</b><span style="color:blue">This branch has not had any commit.</span>

### `genomicVariations`

<b>Current status:</b><span style="color:blue">Waiting for PR to be accepted.</span>

### `received-filters`

<b>Current status:</b><span style="color:blue">Waiting for PR to be accepted.</span>

### `response-meta-add-warnings`

<b>Current status:</b><span style="color:blue">Waiting for PR to be accepted.</span>

### `framework-refactor-entry-type-definitions`

<b>Current status:</b><span style="color:blue">Waiting for PR to be accepted.</span>







==TBD==

