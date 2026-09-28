# Beacon Aggregations

## General changes

### `aggregationTerms` in `requests`

* improved the description which contained errors from the previous "list of lists"
  structure and did some confusing double-definitions of the same concepts
* changed the name of `categories` for specifying the returns of defined in `aggregationTerms`
  to `selectors`
* refactored `selectors` to a cleaner structure, so far with 3 different types
    - `ValueSelectors`
    - `RangeSelectors`
    - `SplitSelectors`
* this allows 2 ways tio define value bins:
    - ranges which might not cover the whole value space
    - splits for, well, splitting the value space into bins of arbitrary sizes

### `beaconAggregationResults` in `responses/sections/`

* removed `categories` (and `splits`) from the response definition since they don't
  serve a purpose besides a checkback of which selectors were applied
* TODO: clear directive that zero values have to be returned for categories

### `beaconAggregationTermsResults` in `responses/sections/`

* reference the definitions for the selectors in `aggregationTerms` in `requests`
  instead of separate definition

### `endpoints`

* corrected to `beaconAggregationConceptsResponse`

### Example Documents

#### aggregationTerms-example

* new document with aggregators aggr1-4
* includes demonstration of `selectors` for values and ranges

#### beaconRequestBody-MAX-example

* added `aggr3` as example of how to use the `aggregators` parameter in the request

#### beaconAggregationTermsResponse-example

* fixed the example document which was just an unedited copy of filteringTerms