# Beacon REST API

While the full power of the Beacon API can be unlocked through the use of structured
queries using JSON serialization ("POST" requests), the majority of common queries can
be implemented through standard query URLs with parameters (GET queries).

## Example Beacon API URLs

Beacon REST paths in general follow the format

`__APIroot__/__entryType__/{id}/`

or

`__APIroot__/__entryType__/{id}/__requestedSchema__`

A typical example would e.g. the request to retrieve all genomic variants associated with a biosample

`https://example.com/beacon/api/biosamples/bios-st4582/g_variants`

??? note "REST Endpoint Definitions"

    The endpoind paths available for a given Beacon instance are defined in
    `__APIroot__/beaconMap/` [Github](https://github.com/ga4gh-beacon/beacon-v2/blob/main/models/src/beacon-v2-default-model/beaconMap.yaml)
  
### Typical Endpoint Patterns

==(TBD)==

