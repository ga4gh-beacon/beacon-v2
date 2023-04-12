
<h2>Progenetix & Beacon<span style="color: red; font-weight: 800;"><sup>+</sup></span></h2>

The Beacon+ implementation - developed in the Python & MongoDB based [`bycon` project](https://github.com/progenetix/bycon/) -
implements an expanding set of Beacon v2 paths for the [Progenetix](http://progenetix.org)
resource :flag_ch:.

### Scoped responses from query object

In queries with a complete `beaconRequestBody` the type of the delivered data is independent
of the path and determined in the `requestedSchemas`. So far, Beacon+ will compare the first
of those to its supported responses and provide the results accordingly; it doesn't matter
if the endpoint was `/beacon/biosamples/` or `/beacon/variants/` etc.

Below is an example for the standard test "small deletion CNVs in the CDKN2A locus, in gliomas"
Progenetix test query, here responding with the matched variants. Exchanging the `entryType`
entry to

* `{ "entryType": "biosample", "schema:": "https://progenetix.org/services/schemas/Biosample/"}`

would change this to a biosample response. The example ccan be tested by POSTing this as `application/json`
to `http://progenetix.org/beacon/variants/` or `http://progenetix.org/beacon/biosamples/`.

```json
{
    "$schema":"beaconRequestBody.json",
    "meta": {
        "apiVersion": "2.0",
        "requestedSchemas": [
            {
                "entryType": "genomicVariant",
                "schema:": "https://progenetix.org/services/schemas/genomicVariant"
            }
        ]
    },
    "query": {
        "requestParameters": {
            "datasets": {
                "datasetIds": ["progenetix"]
            },
            "assemblyid": "GRCh38",
            "referenceName": "9",
            "start": [21500001, 21975098],
            "end": [21967753, 22500000], 
            "variantType": "DEL"
        }
    },
    "filters": [
        { "id": "NCIT:C3058", "includeDescendantTerms": true }
    ]
}
```


### Paths

#### Base `/`

The root path provides the standard `BeaconInfoResponse`.

* [/](https://progenetix.org/beacon/)

----

#### Base `/filtering_terms`

##### `/filtering_terms/`

* [/filtering_terms/](https://progenetix.org/beacon/filtering_terms/)
* 
----

#### Base `/biosamples`

##### `/biosamples/` + query

* [/biosamples?filters=cellosaurus:CVCL_0004](https://progenetix.org/beacon/biosamples?filters=cellosaurus:CVCL_0004)
  - this example retrieves all biosamples having an annotation for the Cellosaurus _CVCL_0004_
  identifier (K562)

##### `/biosamples/{id}/`

* [/biosamples/pgxbs-kftva5c9](http://progenetix.org/beacon/biosamples/pgxbs-kftva5c9)
  - retrieval of a single biosample

##### `/biosamples/?testMode=true`

* [/biosamples?testMode=true](http://progenetix.org/beacon/biosamples?testMode=true)
  - retrieval of some random samples
  - for testing API responses

##### `/biosamples/{id}/g_variants`

* [/biosamples/pgxbs-kftva5c9/g_variants/](http://progenetix.org/beacon/biosamples/pgxbs-kftva5c9/g_variants/)
  - retrieval of all variants from a single biosample

----

#### Base `/individuals`

##### `/individuals` + query

* [/individuals?filters=NCIT:C7541](https://progenetix.org/beacon/individuals?filters=NCIT:C7541)
  - this example retrieves all individuals having an annotation associated with _NCIT:C7541_ (retinoblastoma)
  - in Progenetix, this particular code will be part of the annotation for the _biosample(s)_ associated with the returned individual
* [/individuals/?filters=PATO:0020001,NCIT:C9291](https://progenetix.org/beacon/individuals/?filters=PATO:0020001,NCIT:C9291)
  - this query returns information about individuals with an anal carcinoma (**NCIT:C9291**) and a known male genotypic sex (**PATO:0020001**)
  - in Progenetix, the information about its sex is associated with the _Individual_ object (and therefore in the _individuals_ collection), whereas the information about the cancer type is a property of the _Biosample_ (and therefore stored in the _biosamples_ collection)

##### `/individuals` + query + `requestedSchema=phenopacket`

Progenetix provides `phenopacket` as (currently experimental) alternative schema (`requestedSchema`) for `/individuals`.
This feature allows the combined delivery of attributes annotated w/ the biosamples and such general of the individual, as well as
e.g. linking to genomic variation data.

* [/individuals?requestedSchema=phenopacket&filters=PATO:0020001,NCIT:C9291](https://progenetix.org/beacon/individuals?requestedSchema=phenopacket&filters=PATO:0020001,NCIT:C9291)

##### `/individuals/{id}`

* [/individuals/pgxind-kftx25hb/](http://progenetix.org/beacon/individuals/pgxind-kftx25hb/)
  - retrieval of a single individual

##### `/individuals/?testMode=true`

* [/individuals?testMode=true](http://progenetix.org/beacon/individuals?testMode=true)
  - retrieval of some random individuals
  - for testing API responses

##### `/individuals/{id}/g_variants`

* [/individuals/pgxind-kftx25hb/g_variants/](http://progenetix.org/beacon/individuals/pgxind-kftx25hb/g_variants)
* [/individuals/pgxind-kftx25hb/genomicVariations/](http://progenetix.org/beacon/individuals/pgxind-kftx25hb/genomicVariations/)
  - retrieval of all variants from a single individual

----

#### Base `/g_variants`

There is currently (April 2021) still some discussion about the implementation and naming
of the different types of genomic variant endpoints. Since the Progenetix collections
follow a "variant observations" principle all variant requests are directed against
the local `variants` collection.

`variants` is used as alias.

##### `/g_variants?testMode=true`

* [/g_variants?testMode=true](http://progenetix.org/beacon/g_variants?testMode=true)
  - retrieval of some random variants
  - for testing API responses

##### `/g_variants` + query

* [/variants/?assemblyId=GRCh38&referenceName=17&variantType=DEL&filterLogic=AND&start=7500000&start=7676592&end=7669607&end=7800000](http://progenetix.org/beacon/variants/?assemblyId=GRCh38&referenceName=17&variantType=DEL&filterLogic=AND&start=7500000&start=7676592&end=7669607&end=7800000)
  - This is an example for a Beacon "Bracket Query" which will return focal deletions in the TP53 locus (by position).

##### `/g_variants/{id}`

* [/g_variants/pgxvar-5f5a35586b8c1d6d377b77f6](http://progenetix.org/beacon/g_variants/pgxvar-5f5a35586b8c1d6d377b77f6)

##### `/g_variants/{id}/biosamples`

* [/g_variants/pgxvar-5f5a35586b8c1d6d377b77f6/biosamples](http://progenetix.org/beacon/g_variants/pgxvar-5f5a35586b8c1d6d377b77f6/biosamples)

----

#### Base `/analyses`

The Beacon v2 `/analyses` endpoint accesses the Progenetix `callsets` collection
documents, i.e. information about the genomic variants derived from a single
analysis. In Progenetix the main use of these documents is the storage of e.g.
CNV statistics or binned genome calls.

`/callsets` is an alias in Progenetix

##### `/analyses?testMode=true`

* [/analyses/?testMode=true](http://progenetix.org/beacon/analyses?testMode=true)
  - retrieval of some random analyses
  - for testing API responses

##### `/analyses` + query

* [/analyses?filters=cellosaurus:CVCL_0004](https://progenetix.org/beacon/analyses?filters=cellosaurus:CVCL_0004)
  - this example retrieves all biosamples having an annotation for the Cellosaurus _CVCL_0004_
  identifier (K562)

<h3>Changes<img align="right" width="160px" src="https://progenetix.org/img/progenetix-logo-black.png"></h3>

* 2022-04-17: removed some non-standard examples (e.g. `variants_in_sample`)
* 2021-11-02: added `/testMode` example
* 2021-07-21: added [`/map`](https://progenetix.org/beacon/map) endpoint (incomplete/unser construction)
* 2021-07-21: added [`/configuration`](https://progenetix.org/beacon/configuration) endpoint (incomplete/unser construction)
* 2021-07-02: update for [`/filteringTerms`](https://progenetix.org/beacon/filteringTerms) endpoint to v2b4
* 2021-06-25: updated for `datasets` parameter as object
* 2021-06-24: Updated response structure conforming to v2b4:
  - `response_summary`
  - removal of `response` root element & direct use of `result_sets`
* 2021-06-24: Updated query structure conforming to v2b4
  - `entityType` format fixed
  - `filters` now objects
* 2021-06-23: New JSON POST example & topic
* 2021-06-07: Added `variants_interpretations` example
* 2021-05-29: New `resultSets` response format
  - no change to front-end or examples here but change of `bycon` backend
* 2021-05-11: Added `/analyses`
* 2021-05-02: Added base path for `BeaconInfoResponse`
* 2021-04-26: First Version

