## Summary

Beacon v2 is a **protocol/specification** established by the **Global Alliance for Genomics and Health initiative** ([GA4GH](https://www.ga4gh.org)) that defines an open standard for federated discovery of genomic (and phenoclinic) data in biomedical research and clinical applications. 

!!! Important "Historical Tip"

    Originally, the Beacon protocol (versions 0 and 1) allowed researchers to get information about the presence/absence of a given, specific, genomic mutation in a set of data, from patients of a given disease or from the population in general.
    ![Beacon v1](https://beacon-project.io/assets/img/Beacon-v1.png)

The current version of the protocol is **v2** and introduces new features which were considered important by the community such as:

* extended and clearer specified [genomic variation queries](/variant-queries), including patterns (wildcards) and region queries (i.e. returning variants within a genomic/chromosomal region)
* get a list of samples related to a phenotype, provided the required [authentication or authorization](/security)
* powerful [_filters_](/filters), primarily based on CURIE terms for ontologies and references, including options to control the use of hierarchical terms or the precision of term matching
* scoped data delivery (e.g. matched variant details or sample information) as part of Beacon responses or through _handover_ protocols

## Components

Beacon v2 consists of two components, the **_Framework_** and the **_Models_**. 

The [Framework](framework.md) {{config.repo_framework_icon}} contains the format for the requests and responses, whereas the [Models](models.md) {{config.repo_models_icon}} define the [structure](https://json-schema.org/specification-links.html#2020-12) of the biological data response. The overall function of these components is to provide the instructions to design a **REST API** (REpresentational State Transfer Application Programming Interface) with **OpenAPI** Specification (OAS). The [OAS](https://swagger.io/resources/open-api)  defines a standard, language-agnostic interface that is used by software developers to implement [REST APIs](https://en.wikipedia.org/wiki/Overview_of_RESTful_API_Description_Languages). 

!!! Attention "Framework interdependency, releases and alternative models"

    In principle, this dual system allows for different Models (in other domains outside of the Beacon v2 realm, e.g. "Imaging Beacon" to be built using the same Framework. However, in the current context of Beacon v2, we consider the two elements interdependent and likely to be updated together for subsequent major versions (e.g. from v2 to v3).
