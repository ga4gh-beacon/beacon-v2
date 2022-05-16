# Beacon REST API

While the full power of the Beacon API can be unlocked through the use of structured
queries using JSON serialization ("POST" requests), the majority of common queries can
be implemented through standard query URLs with parameters (GET queries).

## Beacon API URL structure

Beacon REST paths in general follow the format

`__APIroot__/__entryType__/{id}/`

or

`__APIroot__/__entryType__/{id}/__requestedSchema__`

A typical example would e.g. the request to retrieve all genomic variants associated with a biosample

`https://example.com/beacon/api/biosamples/bios-st4582/g_variants`

??? note "REST Endpoint Definitions"

    The endpoind paths available for a given Beacon instance are defined in
    `__APIroot__/beaconMap/` [Github](https://github.com/ga4gh-beacon/beacon-v2/blob/main/models/src/beacon-v2-default-model/beaconMap.yaml)

### `POST` requests

In `POST` requests queries and metadata are defined in JSON objects as specified
in the model supported by the Beacon instance. For more information see

* the [requests](/framework/#the-requests) documentation
* the [models](/models)

### `GET` queries

By default the Beacon model supports a limited set of query parameters, most notably
such addressing genomic variations. Examples can be found in the [Genomic Queries](/variant-queries)
documentation and in the requests section of the default model.
  
### List parameters in `GET` queries

Several of the common query parameters have a multiple value option, _i.e._ are
assumed to be lists. A typical use case here would be the construction of [Bracket Queries](variant-queries/#beacon-bracket-queries)
which use 2 of each `start` and `end` values.

??? Attention "Use a comma `,` separator for list values in `GET`"

    Due to the problem of some web frameworks with the interpretation of multiple
    values for the same parameter we recommend the consistant use of a single
    parameter name and comma-concatenated values.

    * ~~`&start=1234000&start=5234000`~~
    * `&start=1234000,5234000`
