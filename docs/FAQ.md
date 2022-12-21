# Frequently Asked Questions

??? faq "Do I need (to understand) the Beacon model to launch a simple beacon?"

    No - the [Beacon Framework](/framework) describes the overall structure of the API requests, responses, parameters etc. One can implement e.g. a Boolean beacon (_cf._ the
    original protocol) without any use of the model, just by providing a well-formed
    JSON response upon a request [very similar to the (pre-)v1 allele request](/variant-queries/#beacon-sequence-queries).
 
    ##### last change 2022-12-21 by Michael Baudis [:fontawesome-brands-github:](https://github.com/mbaudis)

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

