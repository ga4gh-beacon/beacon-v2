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

## Alternative Data Models

 In principle, the separation of framework and models allows for different models in domains
 outside of the genomics focussed Beacon v2 realm, e.g. “Imaging Beacon”, to be built using the same Framework.
