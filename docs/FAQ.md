# Frequently Asked Questions

!!! Note "Citation"

    **Beacon v2 and Beacon Networks: a "lingua franca" for federated data discovery in biomedical genomics, and beyond.**
    Jordi Rambla, Michael Baudis, Tim Beck, Lauren A. Fromont, Arcadi Navarro, Manuel Rueda, Gary Saunders, Babita Singh, J.Dylan Spalding, Juha Tornroos,  Claudia Vasallo, Colin D.Veal, Anthony J.Brookes.  _Human Mutation_ (2022) [DOI](https://doi.org/10.1002/humu.24369).

??? faq "How do I emulate Beacon v1 while supporting the v2 protocol?<a id="v1-emulation"> </a>" 

    The [Beacon Framework](/framework) describes the overall structure of the API
    requests, responses, parameters etc. One can implement e.g. a Boolean beacon (_cf._ the
    original protocol) without any use of the model, just by providing a well-formed
    JSON response upon a request [very similar to the (pre-)v1 allele request](/variant-queries/#beacon-sequence-queries).


    ##### Minimal Example Request

    This example is for a minimal SNV-type variant query.

    ```
    /beacon/g_variants/?referenceName=refseq:NC_000017.11&start=7577120&referenceBases=G&alternateBases=A
    ```

    ##### Example Boolean Response

    In this minimal response to the query above the beacon indicates that its default
    response is Boolean and that it could interpreted it against the `genomicVariant` entity and in the context of the same Beacon version.

    In principle one could launch a Beacon instance using the example response document as a template
    in whatever server environment one has at hand. However, a proper Beacon v2
    installation also has to provide informational endpoints (`/info`, `/map` ...)
    to allow it's integration through [aggregators](/networks/).

    ```json
    {
      "meta": {
        "apiVersion": "v2.0.0",
        "beaconId": "org.progenetix.beacon",
        "receivedRequestSummary": {
          "apiVersion": "v2.0.0",
          "pagination": {
            "limit": 2000,
            "skip": 0
          },
          "requestedGranularity": "boolean",
          "requestedSchemas": [
            {
              "entityType": "genomicVariant",
              "schema": "https://progenetix.org/services/schemas/genomicVariant/"
            }
          ],
          "requestParameters": {
            "alternateBases": "A",
            "referenceBases": "G",
            "referenceName": "refseq:NC_000017.11",
            "start": [
              7577120
            ]
          }
        },
        "returnedGranularity": "boolean",
        "returnedSchemas": [
          {
            "entityType": "genomicVariant",
            "schema": "https://progenetix.org/services/schemas/genomicVariant/"
          }
        ]
      },
      "responseSummary": {
        "exists": true
      }
    }
    ```
 
    ##### last change 2023-02-17 by Michael Baudis [:fontawesome-brands-github:](https://github.com/mbaudis)

??? faq "Is it `Beacon` or `beacon`?"

    The uppercase `Beacon` is used to label API, framework or protocol and their
    components - while lower case `beacons` are instances of these, _i.e._ individual
    resources using the protocol.
    
    ##### last change 2022-10-01 by Michael Baudis [:fontawesome-brands-github:](https://github.com/mbaudis)

??? faq "What types of genomic variants are supported in Beacon queries?"

    Beacon v2.0 does not provide a mechanism to detect what types of genomic variant
    queries are supported by a given instance.

    Beacon had been originally designed to handle the "simplest" type of genomic
    variant queries in which a `position`, `alternateBases` (_i.e._ one or more base
    sequence of the variant at the position) and - sometimes optional - the reference
    sequence at this position (necessary e.g. for small deletions).

    Beacon v1.1 in principle supported "bracketed" queries and a `variantType` parameter
    (pointing to the VCF use) - see the [current documentation](http://docs.genomebeacons.org/variant-queries/#beacon-bracket-queries) for details. However, the support & interpretation was - and still is (2022-12-13) -
    left to implementers. Similar for [Beacon Range Queries](http://docs.genomebeacons.org/variant-queries/#beacon-range-queries).

    However, the [Beacon documentation](http://docs.genomebeacons.org/variant-queries/#varianttype-parameter-interpretation)
    provides information about use and expected interpretation of `variantType` values, specifically
    for copy number variations.

    ##### last change 2022-12-14 by Michael Baudis [:fontawesome-brands-github:](https://github.com/mbaudis)


??? faq "How can I handle haplotype queries & representation in Beacon v2?"<a id="haplotypes"> </a>"

    #### Queries

    The Beacon framework currently (_v2.0_ and earlier) considers genomic
    variants to be _allelic_ and does not support the query for multiple alleles
    or "haplotype shorthand expressions" (e.g. `C,T`).

    **Workarounds** In case of a specific need for haplotype queries implementers
    of a given beacon with control of its data content in principle can extend their
    query model to support shorthand haploype expressions, as long as they support
    the standard format, too. However, such an approach may be superseeded or in conflict
    with future direct protocol support.

    An approach in line with the current protocol would be to query for one allelic
    variant with a record-level `genomicVariation` response, and then query the
    retrieved variants individually by their `id` in combination with the second
    allele.

    #### Variant representation

    As with queries the Beacon "legacy" format does not support haplotype representation
    but would represent each allelic variation separately. The same is true for the
    VRSified variant representation which for v2.0 corresponds to VRS v1.2.
    However, draft versions of the VRS standard (will) address haplotype and genotype
    representations and will be adopted by Beacon v2.n after reaching a release state.




