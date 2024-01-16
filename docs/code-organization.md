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

## Topic branches

==TBD==

