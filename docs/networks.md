# Beacon Networks

Many Beacon instances will be part of networks, although a Beacon can be instantiated as stand-alone solution.
The Beacon design includes several features aimed to be consumed by Beacon network aggregators. For example,
a Beacon endpoint declares which entities are implemented in that particular instance, which are the ontology
terms supported or the URL endpoints where different elements could be found.

<figure markdown>
  ![Beacon Network](img/beacon-network.png){ width="750" }
  <figcaption>Beacon v2 Networks</figcaption>
</figure>

## Networking heterogeneous beacons

In addition to genomic variation queries with Boolean responses
the Beacon v2 protocol permits the implementers to support different types of
entities (e.g. biosample and analysis data) both to be queried against and to be
returned in Beacon responses - so a request may retrieve information about the
samples in which an indicated genomic variant had been found or information about
technical parameters used to detect such a variant.

However, individual beacons will have different profiles regarding the supported
parameters, supported entities or the filtering terms recognized. Here, a number
of information endpoints allow the profiling of beacons which is especially important
when designing Beacon networks and aggregating their responses.

### Supported filters

[Filters](/filters) represent a powerful way to [query various features](/filters/#using-filters-in-queries)
in beacon entities. When designing a network of multiple beacons the
[`filtering_terms` informational endpoints](/filters/#filtering_terms-informational-endpoint)
can be utilized to e.g. implement translators for harmonizing the possibly differing
terms used in the individual Beacon instances.

==TBD==
