# Informations for Different Types of Beacon Users

The Beacon documentation provides information for different types of users,
depending on their interests and use cases. Although those will overlap, we highlight
information relevant for some general scenarios throughout the documentation.

## Users

A Beacon **user** (or end-user) is interested in querying Beacon instances and networks, either through
web interfaces by using the Beacon API. While users of Beacon web forms in principle
do not need to understand the underlying query syntax and response formats they too may
benefit from some insights into the general capabilities of the underlying protocol.

!!! Warning "User"
    * Beacon v2 [Model](models.md)
    * Knowing what is available in an instance
        * Data [Models and Schemas](models.md)
        * Beacon [Flavours](beacon-flavours.md) & Response Granularity
        * [Security](security.md) 
        * Other Request, Response & Error Elements
    * Using Beacon v2 Features
        * Genomic [Variant Queries](variant-queries.md)
        * [Filters](filters.md) for Phenotypes, Diseases & Other Parameters
        * Alternative Schemas [Link](models.md)

<!--        * [OpenAPI](https://www.openapis.org) -->


## Deployers and Implementers

A Beacon **Deployer** is someone who wants to make their genomics resource accessible
through the Beacon protocol, without necessarily being interested or experienced in the
computational aspects; while a Beacon **Implementer** provides the technical expertise (and
potentially may get involved with Beacon development itself, e.g. to extend the protocol
for novel use cases). 

!!! Important "Deployer"

    * Beacon v2 [Models](models.md)

    * Reference Implementation [Link](https://b2ri-documentation.readthedocs.io/en/latest/)
        * Infrastructure requirements
        * How to install
        * Configuration
            * Cohorts and/or Datasets
            * Entry types
            * Filtering terms
            * Alternative schemas
            * Granularity & Security
        * Administration
        * Testing the instance


!!! Note "Implementer"

    * Beacon v2 [Models](models.md)
    * Protocol basics
        * Requests, responses & errors [variant-queriesi.md]
        * [OpenAPI](https://www.openapis.org)
    * Beacon v2 Features
        * [Filters](filters.md)
        * Alternative schemas [Link](models.md)
    * Configuration
        * Granularity & security [Link](framework.md)
    * Verifying compliance


## Stakeholder

!!! Danger "Stakeholder"
    * Integration into GA4GH
    * Leveraging The Beacon Framework in other domains
    * Success Stories:
        * [Implementations](other-implementations.md)
        * Real world data
    
