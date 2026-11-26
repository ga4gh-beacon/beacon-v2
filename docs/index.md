# _Genome Beacons_ - Beacon Protocol Documentation

__Beacon__ is a **protocol and specification** established by the **Global
Alliance for Genomics and Health** ([GA4GH](https://www.ga4gh.org)). It defines
an open standard for the discovery of genomic variants and biomedical
data in single or distributed resources. It empowers _federated_ data
models, _i.e._ the discovery - and potential retrieval - of data from different
organisational and geographic locations using shared standards.

<figure markdown>
![Beacon v2 Cartoon](img/Beacon-Networks-v2-graphics/Beacon-Networks-v2-graphics-Michael.003.png){: style="width: 600px; margin-top: -30px; margin-bottom: -30px;" }
</figure>
<div class="figcaption"><b>Concept behind the Beacon specification</b> The protocol defines a framework
  for queries potentially containing genomic, phenotypic, clinical and techmical parameters.
While all beacons support the minimal response of "yes / no" upon a query, <b>Beacon</b>
<i>enables</i> rich responses including detailed information about samples and experiments if
supported by the individual resource and in the given context of security and authorisation.</div>

The Beacon specification is developed by an international team of sientists and
technology experts, as a product of the [GA4GH Discovery work stream](https://ga4gh-discovery.github.io)
and with major support from the European bioinformatics infrastructure organization
[ELIXIR](https://elixir-europe.org).

The current **{{config.beacon_major_version}}** version of the Beacon protocol
has number of powerful features:

* [genomic variation queries](/variant-queries),
  including region queries (i.e. returning variants within a genomic/chromosomal region)
* support for information about samples or subjects (e.g. phenotypes or
  other biomedical parameters), depending on the potentially required [authentication and authorization](/security/)
    - feature queries are powered by [_filters_](/filters/)
      with options to control the use of hierarchical terms and the precision of term matching
* data delivery using the Beacon [data model](/records/) or through [_handover_](/handovers/)
  protocols
    - _handovers_ allows for data in different formats - such as
      VCF for genomic variants or Phenopackets - and the use of additional
      authentication options

!!! warning "Move to Beacon {{config.beacon_major_version}}!"

    On [2022-04-21](formats-standards/#dates-and-times) Beacon v2 has been approved as an official [GA4GH standard](https://www.ga4gh.org/) through the GA4GH steering committee.

    Beacon v1 and earlier are not longer supported. Deployers of Beacon instances
    or networks should migrate to **{{config.beacon_major_version}}** of the
    standard. The functionality of Beacon v1 [can be easily implemented in v2](https://genomebeacons.org/FAQ/#v1-emulation). 

This website represents mostly technical information about the Beacon [**framework**](/framework/) and data [**model**](/models/) and about ways towards to "**beaconize**" genomics datasets and resources.
Additional information about the Beacon project - including news, events, publications - is available
through [genomebeacons.org](https://genomebeacons.org).

!!! Important "Historical Tip"

    Originally, the Beacon protocol (versions 0 and 1) allowed researchers only
    to get information about the presence/absence of a given, specific, genomic
    mutation in a set of data but did not support phenotypic or other
    query parameters or the retrieval of matched records.  

## Components

Beacon consists of two components, the **_Framework_** and the **_Models_**. 
The [Framework](framework.md) {{config.repo_framework_icon}} contains the format for the requests and responses, whereas the [Models](models.md) {{config.repo_models_icon}} define the [structure](https://json-schema.org/specification-links.html#2020-12) of the biological data response. The overall function of these components is to provide the instructions to design a **[REST API](https://en.wikipedia.org/wiki/Overview_of_RESTful_API_Description_Languages)**
(REpresentational State Transfer Application Programming Interface) e.g. using a Beacon's **OpenAPI**
specification ([OAS](https://swagger.io/resources/open-api)). 

!!! Attention "Framework interdependency, releases and alternative models"

    In principle, this dual system allows for different Models (in other domains outside of the Beacon v2 model realm, e.g. "Imaging Beacon" to be built using the same Framework. However, in the current context of Beacon v2, we consider the two elements interdependent and likely to be updated together for subsequent major versions (e.g. from v2 to v3).

## Informations for Different Types of Beacon Users

The Beacon documentation provides information for different types of users,
depending on their interests and use cases. Although those will overlap, we highlight
information relevant for some general scenarios throughout the documentation.

### Users

A Beacon **user** (or end-user) is interested in querying Beacon instances and networks, either through
web interfaces by using the Beacon API. While users of Beacon web forms in principle
do not need to understand the underlying query syntax and response formats they too may
benefit from some insights into the general capabilities of the underlying protocol.

!!! Warning "User"
    * Beacon [Models](models.md)
    * Knowing what is available in an instance
        * Data [Models and Schemas](models.md)
        * Beacon [Flavours](beacon-flavours.md) & Response Granularity
        * [Security](security.md) 
        * Other Request, Response & Error Elements
    * Using Beacon Features
        * Genomic [Variant Queries](variant-queries.md)
        * [Filters](filters.md) for Phenotypes, Diseases & Other Parameters
        * Alternative Schemas [Link](models.md)

<!--        * [OpenAPI](https://www.openapis.org) -->

### Deployers and Implementers

A Beacon **Deployer** is someone who wants to make their genomics resource accessible
through the Beacon protocol, without necessarily being interested or experienced in the
computational aspects; while a Beacon **Implementer** provides the technical expertise (and
potentially may get involved with Beacon development itself, e.g. to extend the protocol
for novel use cases). 

!!! Important "Deployer"

    * Beacon [Models](models.md)

    * Reference Implementation [Link](https://b2ri-documentation.readthedocs.io/en/latest/)
        * Infrastructure requirements
        * How to install
        * [Configuration](https://github.com/EGA-archive/beacon-2.x)
            * Cohorts and/or Datasets
            * Entry types
            * Filtering terms
            * Alternative schemas
            * Granularity & Security
        * Administration
        * Testing the instance


!!! Note "Implementer"

    * Beacon
        * [Framework](framework.md)
        * [Models](models.md)
    * Protocol basics
        * [Requests](variant-queries.md), responses & errors
        * [OpenAPI](https://www.openapis.org)
    * Beacon Features
        * [Filters](filters.md)
        * Alternative schemas [Link](models.md)
    * Configuration
        * Granularity & security [Link](framework.md)
    * Verifying compliance
