# Model defined records

A beacon instance will allow to retrieve data - in contrast to the aggregated
boolean and count responses - if it supports `record` granularity. The type of
document(s) is selected either through the [REST path](/rest-api/)
or by specifying the entity through the `requestedEntityId`. 

While any beacon can in principle choose its own data model - and thereby the
schemas of records it supports - for biomedical genomics beacons we recommend the
support of the Beacon default data model

## Beacon Default Data Model

The Beacon v2 default data model provides a set of schemas for common data entities with
a focus on biomedical genomics (although neither specific to medical application or human genomics _per se_).

In contrast to earlier versions of the protocol, the Beacon v2 default models provide
the technical blueprint for rich, structured data responses to Beacon queries, such as
annotated genomic variations, biosamples from which matched variants were retrieved
or data about individuals and study cohorts, where available and authorized.

Detailed information is available through the [Models Introduction](/models/#introduction)
and the default schemas documented from there.

### Examples

=== "Biosample in Beacon v2.0"

    This example is a single biosample response, e.g. as the result of a REST path
    call (`.../biosamples/{id}/`). The response just demonstrates some of the available
    biosample parameters and removes some technical/meta information for clarity.
    Also, the sample contains fields which are **not** defined in the default
    schema (such as  `icdoMorphology`...); but although the use of custom fields is discouraged to
    enhance interoperability, the use of `additionalProperties` is allowed so the
    data itself is schema conform. 

    ```
    {
      "meta": {
        "apiVersion": "v2.0.0",
        "beaconId": "org.progenetix",
        "receivedRequestSummary": {
            ...
        },
        "returnedGranularity": "record",
        "returnedSchemas": [
          {
            "entityType": "biosample",
            "schema": "https://progenetix.org/services/schemas/biosample/"
          }
        ],
      },
      "responseSummary": {
        "exists": true,
        "numTotalResults": 1
      },
      "response": {
        "resultSets": [
          {
            "exists": true,
            "setType": "dataset",
            "id": "progenetix",
            "resultsCount": 1,
            "results": [
              {
                "id": "pgxbs-kftva5c9",
                "individualId": "pgxind-kftx25hb",
                "notes": "Mantle cell lymphoma",
                "biosampleStatus": {
                  "id": "EFO:0009656",
                  "label": "neoplastic sample"
                },
                "collectionMoment": "P66Y",
                "sampleOriginType": {
                  "id": "OBI:0001479",
                  "label": "specimen from organism"
                },
                "dataUseConditions": {
                  "id": "DUO:0000004",
                  "label": "no restriction"
                },
                "externalReferences": [
                  {
                    "id": "geo:GSE13331",
                    "reference": "https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE13331"
                  }
                ],
                "histologicalDiagnosis": {
                  "id": "NCIT:C4337",
                  "label": "Mantle Cell Lymphoma"
                },
                "icdoMorphology": {
                  "id": "pgx:icdom-96733",
                  "label": "Mantle cell lymphoma"
                },
                "icdoTopography": {
                  "id": "pgx:icdot-C77.9",
                  "label": "Lymph node, NOS"
                },
                "pathologicalStage": {
                  "id": "NCIT:C92207",
                  "label": "Stage Unknown"
                },
                "sampleOriginDetail": {
                  "id": "UBERON:0000029",
                  "label": "lymph node"
                },
                "updated": "2020-09-10 17:44:04.888000"
              }
            ]
          }
        ]
      }
    }
    ```

## Alternative Data Models

 In principle, the separation of framework and models allows for different models in domains
 outside of the genomics focussed Beacon v2 realm, e.g. “Imaging Beacon”, to be built using the same Framework.
