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
    data itself remains schema conform. 

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
                "id": "pgxbs-kftvi9i0",
                "individualId": "pgxind-kftvi9i0",
                "notes": "Primary Tumor",
                "biosampleStatus": {
                  "id": "EFO:0009656",
                  "label": "neoplastic sample"
                },
                "collectionMoment": "P44Y1M24D",
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
                    "id": "pgx:TCGA.933b9daf-a5bf-46cf-92b6-5ddd8279919c",
                    "label": "TCGA case_id"
                  },
                  {
                    "id": "pgx:TCGA.TCGA-76-6663",
                    "label": "TCGA submitter_id"
                  },
                  {
                    "id": "pgx:TCGA.005cb7ce-5050-43aa-85ff-cd56ed830535",
                    "label": "TCGA sample_id"
                  },
                  {
                    "id": "pgx:TCGA.GBM",
                    "label": "TCGA GBM project"
                  }
                ],
                "histologicalDiagnosis": {
                  "id": "NCIT:C3058",
                  "label": "Glioblastoma"
                },
                "icdoMorphology": {
                  "id": "pgx:icdom-94403",
                  "label": "Glioblastoma, NOS"
                },
                "icdoTopography": {
                  "id": "pgx:icdot-C71.9",
                  "label": "Brain, NOS"
                },
                "pathologicalStage": {
                  "id": "NCIT:C92207",
                  "label": "Stage Unknown"
                },
                "sampleOriginDetail": {
                  "id": "UBERON:0000955",
                  "label": "brain"
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
