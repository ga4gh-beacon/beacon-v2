# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

 * List parameters in `GET` queries
 * Added `FAQ.md`page to `docs`

### Changed

 * Updated `docs`:
    - `filters.md`
    - `variant-queries.md`
    - `changes-todo.md` 
    - `ComplexValue.md`
    - `README.md`
    - Added missing descriptions to models properties (see issue #42)

 * Updated `framework`:

   - `commonDefinitions.{json,yaml}`
   - Moved `CURIE` to `beaconCommonComponents`
   - Created entity `FilteringTerm` (see Issue #31)
   - Improved descriptions

 * Updated `models`:

### Fixed

 * Fixed `POST`queries for `g_variant` (w/ examples)
 * Removed 'json' references inside the yaml version (PR [#43](https://github.com/ga4gh-beacon/beacon-v2/pull/43))
 * added missing `type: object` to `ResultsetInstance` (PR [#82](https://github.com/ga4gh-beacon/beacon-v2/pull/82))

### Deprecated

### Removed

### Security

## [2.0.0] - 2022-06-21

Beacon v2 specification stable version (approved on 2022-04-21 as an official GA4GH standard).
