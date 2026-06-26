# Beacon Aggregations

!!! warning "WiP"

    Beacon aggregations are currently work in progress and may change without deprecation. They are **not** part of the official version 2.n specification and should not be implemented in production environments yet. Use with caution for testing, follow related PRs and provide feedback!

    * [Proposals for Aggregated Response](https://github.com/ga4gh-beacon/beacon-v2/discussions/238)

## Overview and Use Cases

While the `Beacon` API provides different ways to discover and potentially retrieve
data in biomedical genomics resources, with version 2.n responses were limited to
global content (boolean or overall count of matched data and static collection information)
or full record level access which for most resources would not be possible in a
public context. Responses under the new `aggregated` granularity level allow to:

* provide granular data overwiews about the content of resources and their collections,
  e.g. numbers of samples with individual features or combinations of features
* profile query responses for multiple (single or intersected) parameters

## Endpoints

### `/aggregation_terms`

Similar to the `/filtering_terms` endpoint, this endpoint returns the list of
individual aggregation terms that can be used to construct the `aggregators` parameters.

#### Examples for `/aggregation_terms`

This example beacon provides aggregation terms at the `/aggregation_terms` entry type inside `response.aggregationTerms`; for space reasons they are split
into different views here.

=== "Histological Diagnoses"

    ```json
    {
      "id": "HistologicalDiagnoses",
      "label": "Histological Diagnoses",
      "modelProperty": "biosample.histologicalDiagnosis.id"
    }
    ```

=== "Selected Diagnoses"
    
    Here the values for the `histologicalDiagnosis` property are only evaluated
    for a few selected entities.

    ```json
    {
      "id": "SelectedCarcinomaDiagnoses",
      "label": "Selected Carcinoma Diagnoses",
      "modelProperty": "biosample.histologicalDiagnosis.id",
      "selectors": [
        {
          "label": "Prostate Adenocarcinoma",
          "value": "NCIT:C2919"
        },
        {
          "label": "Breast Ductal Carcinoma",
          "value": "NCIT:C4017"
        },
        {
          "label": "Lung Adenocarcinoma",
          "value": "NCIT:C3512"
        }
      ]
    }
    ```

=== "Sex at Birth"

    This aggregation does not indicate a specific property in the model but provides the available selectors.

    ```json
    {
      "id": "SexAtBirth",
      "selectors": [
        { 
          "label": "female", 
          "value": "NCIT:C16576"
        },
        {
          "label": "male", 
          "value": "NCIT:C20197"
        },
        {
          "label": "unknown", 
          "value": "NCIT:C1799"
        }
      ]
    }
    ```

=== "Age at onset of disease"

    This aggregation does not indicate a specific property in the model but provides the available selectors.

    ```json
    {
      "description": "Aggregation by the age of onset of the individuals with pre-defined age ranges.",
      "id": "AgeOfOnset",
      "label": "Age of Onset",
      "modelProperty": "individual.diseases.ageofOnset",
      "selectors": [
          {
              "label": "birth to 18 months",
              "rangeBounds": ["P0D", "P18M"],
              "sortOrder": 1
          },
          {
              "label": "1.5 to 10 years",
              "rangeBounds": ["P18M", "P10Y"],
              "sortOrder": 2
          },
          {
              "label": "10 to 60 years",
              "rangeBounds": ["P10Y", "P60Y"],
              "sortOrder": 3
          },
          {
              "label": "60 years and older",
              "rangeBounds": ["P60Y"],
              "sortOrder": 4
          }
      ]
    }
    ```

### Other endpoints

Standard data endpoints can provide aggregation results, if the `aggregated`
granularity is specified in the request. 

## Requests

### Parameters

* `requestedGranularity`
* `aggregators`: list of aggregation objects to be applied to the query. The aggregation
  objects (_i.e._ `aggregators`) are constructed from one or more aggregation terms which
  should be indicate in the `/aggregation_terms` endpoint.

## Responses

The format of the response will be a
`beaconAggregationReponse`, _i.e._ an extension of a `beaconCountResponse` with
an additional section `responseAggregation` containing the aggregation results.

For `beaconResultsetResponses` (e.g. upon a query at a data endpoints such as
`/biosamples`), per resultset `resultsAggregation` should be provided instead of
the `results` section.

## Examples

=== "Simple - `aggr1`"

    #### Request

    The example request uses the ontology filter `NCIT:C3512` to match individuals
    with lung adenocarcinomas and requests data aggregations. No aggregators
    are specified in the request; _i.e._ the beacon decides.

    ```json
    {
      "requestedGranularity": "aggregated",
      "filters": [
        {"id": "NCIT:C3512"}
      ],
      "aggregators": [
        {
          "requestId": "aggr1",
          "aggregationTerms": [
            {"id": "SexAtBirth"}
          ]
        }
      ]
    }
    ```

    #### Response

    Here the beacon provides (only) an aggregation of the sex of the matched individuals.

    ```json
    "resultsAggregation": [
      {
          "requestId": "aggr1",
          "aggregationTerms": [
              {"id": "SexAtBirth"}
          ],
          "categoriesAndValues": [
              {
                  "count": 778,
                  "ids": ["NCIT:C16576"],
                  "names": ["female"]
              },
              {
                  "count": 957,
                  "id": ["NCIT:C20197"],
                  "names": ["male"]
              },
              {
                  "count": 11,
                  "ids": ["NCIT:C1799"],
                  "names": ["unknown"]
              }
          ]
      }
    ]
    ```

=== "With Selectors - `aggr2`"

    #### Request

    **Note**: In principle the `selectors` parameter would not be needed here
    if the beacon indicates that those selectors are part of a predefined
    `SelectedCarcinomaDiagnoses` `aggregationTerm`.

    ```json
    "aggregators": [
      {
        "requestId": "aggr2",
        "aggregationTerms": [
          {
            "id": "SelectedCarcinomaDiagnoses",
            "label": "Selected diagnoses (some carcinoma entities)",
            "selectors": [
              {
                "label": "Prostate Adenocarcinoma",
                "value": "NCIT:C2919"
              },
              {
                "label": "Breast Ductal Carcinoma",
                "value": "NCIT:C4017"
              },
              {
                "label": "Lung Adenocarcinoma",
                "value": "NCIT:C3512"
              }
            ]
          }
    ]}]
    ```

    Only the `aggregators` parameter is shown (which could be combined w/ any
    `filters` and/or variant parameters request, depending on the beacon).


    #### Response

    Here the beacon provides (only) an aggregation of the sex of the matched individuals.

    ```json
    "resultsAggregation": [
      {
        "requestId": "aggr2",
        "aggregationTerms": [
          {
            "id": "SelectedCarcinomaDiagnoses",
            "label": "Selected diagnoses (some carcinoma entities)"
          }
        ],
        "categoriesAndValues": [
          {
            "count": 426,
            "ids": ["NCIT:C2919"],
            "names": ["Prostate Adenocarcinoma"]
          },
          {
            "count": 523,
            "ids": ["NCIT:C4017"],
            "names": ["Breast Ductal Carcinoma"]
          },
          {
            "count": 317,
            "ids": ["NCIT:C3512"],
            "names": ["Lung Adenocarcinoma"]
          }
        ],
      }
    ]
    ```

=== "Two Dimensions - `aggr3`"

    #### Request

    Here the intersecting counts for 2 properties are reported. Note that for
    `SexAtBirth` only known values are used; _i.e._ the `unknown` (or other...)
    category is not included in the aggregations.

    As above, the `selectors` parameter would not be needed for the `SelectedCarcinomaDiagnoses`
    if the same values are part of its definition.

    ```json
    "aggregators": [
      {
        "requestId": "aggr3",
        "aggregationTerms": [
          {
            "id": "SexAtBirth",
            "selectors": [
              {"value": "NCIT:C16576"},
              {"value": "NCIT:C20197"}
            ]
          },
          {
            "id": "SelectedCarcinomaDiagnoses",
            "selectors": [
              {
                "label": "Prostate Adenocarcinoma",
                "value": "NCIT:C2919"
              },
              {
                "label": "Breast Ductal Carcinoma",
                "value": "NCIT:C4017"
              },
              {
                "label": "Lung Adenocarcinoma",
                "value": "NCIT:C3512"
              }
            ]
          }
        ]
      }
    ]
    ```

    Only the `aggregators` parameter is shown (which could be combined w/ any
    `filters` and/or variant parameters request, depending on the beacon).

    #### Response

    ![Stacked Bar Chart Example](img/aggregations-disease-by-sex-example-plot.png){ style="float: right; margin: 20px 0px 10px 20px; width: 350px" }
    
    Aggregation of the different combinations for selected values representing
    sex at birth and histological diagnosis are returned.

    [![plotly logo](img/plotly-logo.png){ style="float: left; margin: 5px 20px 5px 0px; width: 100px" }](https://plotly.com/javascript/)

    The stacked bar chart was generated in Plotly.js from the Beacon 2D aggregation in the example below, directly derived from the response JSON on the Progenetix site and reflecting the resource's content. The list of `aggregationTerms` is essential for understanding the order of
    the dimensions in the `ids` and `names` in the `categoriesAndValues` list - 
    think of them as `[x, y]` axes and `[x, y]` values in a plot (though the
    order can obviousluy be transposed). The example plot does not necessarily reflect
    the example data.


    ```json
    "resultsAggregation": [
      {
        "requestId": "aggr3",
        "aggregationTerms": [
          {"id": "SexAtBirth", "label": "Sex at Birth"},
          {"id": "HistologicalDiagnoses", "label": "Selected Diagnoses"}
        ],
        "categoriesAndValues": [
          {
            "count": 426,
            "ids": ["NCIT:C20197", "NCIT:C2919"],
            "names": ["male", "Prostate Adenocarcinoma"]
          },
          {
            "count": 0,
            "ids": ["NCIT:C16576", "NCIT:C2919"],
            "names": ["female", "Prostate Adenocarcinoma"]
          },
          {
            "count": 4,
            "ids": ["NCIT:C20197", "NCIT:C4017"],
            "names": ["male", "Breast Ductal Carcinoma"]
          },
          {
            "count": 501,
            "ids": ["NCIT:C16576", "NCIT:C4017"],
            "names": ["female", "Breast Ductal Carcinoma"]
          },
          {
            "count": 201,
            "ids": ["NCIT:C20197", "NCIT:C3512"],
            "names": ["male", "Lung Adenocarcinoma"]
          },
          {
            "count": 66,
            "ids": ["NCIT:C16576", "NCIT:C3512"],
            "names": ["female", "Lung Adenocarcinoma"]
          }
        ]
      }
    ]
    ```

=== "With Range Selectors - `aggr4`"

    #### Request

    **Note**: In principle the `selectors` parameter would not be needed here
    if the beacon indicates that those range selectors are part of a predefined
    `AgeOfOnset` `aggregationTerm`.

    ```json
    "aggregators": [
      {
        "requestId": "aggr4",
        "aggregationTerms": [
          {
            "id": "AgeOfOnset",
            "selectors": [
              {
                "label": "birth to 18 months",
                "rangeBounds": ["P0D", "P18M"],
                "sortOrder": 1
              },
              {
                "label": "1.5 to 10 years",
                "rangeBounds": ["P18M", "P10Y"],
                "sortOrder": 2
              },
              {
                "label": "10 to 60 years",
                "rangeBounds": ["P10Y", "P60Y"],
                "sortOrder": 3
              },
              {
                "label": "60 years and older",
                "rangeBounds": ["P60Y"],
                "sortOrder": 4
              }
            ]
          }
        ]
      }
    ]
    ```

    Only the `aggregators` parameter is shown (which could be combined w/ any
    `filters` and/or variant parameters request, depending on the beacon).


    #### Response

    Here the beacon provides (only) an aggregation of the sex of the matched individuals.

    ```json
    "resultsAggregation": [
      {
        "requestId": "aggr4",
        "aggregationTerms": [
          {
            "description": "Age of onset of the disease addressed in the data. The aggregation of age values has been peformed on splits for the indicated age ranges. The number of individuals with unknown or older age of onset is included as a separate category.",
            "id": "AgeOfOnset",
            "sorted": true
          }
        ],
        "categoriesAndValues": [
          {
            "count": 426,
            "ids": ["[P0D, P18M)"],
            "names": ["birth to 18 months"]
          },
          {
            "count": 339,
            "ids": [
              "[P18M, P10Y)"],
            "names": ["1.5 to 10 years"]
          },
          {
            "count": 61,
            "ids": ["[P10Y, P60Y)"],
            "names": ["10 to 60 years"]
          },
          {
            "count": 719,
            "ids": ["other"],
            "names": ["older or unknown"]
          }
        ]
      }
    ]
    ```




## DEV: Changes

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
* removed the full examples since they are provided in a separate examples document

### `endpoints`

* corrected to `beaconAggregationTermsResponse`
* adding the `beaconAggregationResponse` as an option to all endpoints files already containing a `beaconCountResponse` reference

### Example Documents

#### aggregationTerms-example

* new document with aggregators aggr1-4
* includes demonstration of `selectors` for values and ranges

#### beaconRequestBody-MAX-example

* added `aggr3` as example of how to use the `aggregators` parameter in the request

#### beaconAggregationTermsResponse-example

* fixed the example document which was just an unedited copy of filteringTerms

#### beaconAggregationResults-examples

* aligned the examples with the aggr1-4 examples in the `aggregationTerms-example` document
