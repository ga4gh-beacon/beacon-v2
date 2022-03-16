# Genomic Variant Queries

For querying of genomic variations Beacon v2 builds on and extends the options provided
by earlier versions.

## Query Examples

### Beacon SNV Query

#### Example: _EIF4A1_ Single Base Mutation

This is an example for a single base mutation (`G>A`) in the _EIF4A1_ eukaryotic translation initiation factor 4A1.

=== "Beacon v2 GET"

	```
	?referenceName=NC_000017.11&start=7577120&referenceBases=G&alternateBases=A
	```

	#### Optional

	* `datasetIds=__some-dataset-ids__`
	* `filters` ...


=== "Beacon v2 POST"

	```
	{
	    "$schema":"beaconRequestBody.json",
	    "meta": {
	        "apiVersion": "2.0",
	        "requestedSchemas": [
	            {
	                "entityType": "genomicVariation",
	                "schema:": "https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2-unity-testing/main/models/json/beacon-v2-default-model/genomicVariations/defaultSchema.json"
	            }
	        ]
	    },
	    "query": {
	        "requestParameters": {
	            "referenceName": "NC_000017.11",
	            "start": [7577120],
	            "referenceBases": "G",
	            "alternateBases": "A"
	        }
	    },
	    "requestedGranularity": "record",
	    "pagination": {
	        "skip": 0,
	        "limit": 5
	    }
	}
	```

	There are optional parameters [`datasetIds`, `filters` ...] and also the option to specify the response type
	(through `requestedGranularity`) and returned data format (`requestedSchemas`). Please follow this up in the
	[framework documentation](framework.md).



=== "Beacon v1"

	```
	?assemblyId=GRCh38&referenceName=17&start=7577120&referenceBases=G&alternateBases=A
	```

	#### Optional

	* `datasetIds=__some-dataset-ids__`

=== "Beacon v0.3"

	```
	?ref=GRCh38&chrom=17&pos=7577121&referenceAllele=C&allele=A
	```

	#### Optional

	* `beacon=__some-beacon-id__`

	Before Beacon v0.4 a 1-based coordinate system was being used.



### Beacon CNV Queries

#### Example: _TP53_ Deletion Query by Coordinates

The following example shows a "bracket query" for focal deletions of the _TP53_ gene locus:

* The start of the deletion has to occurr anywhere from approx. 2.5Mb 5' of the CDR start to just before the end of the CDR.
* The end of the matched CNVs has to be anywhere from the start of the gene locus to approx. 2.5Mb 3' of its end.

This leads to matching of deletion CNVs which have at least some base overlap with the gene locus but are not
larger than approx. 5Mb (operational definitions of focality vary between 1 and 5Mb).

=== "Beacon v2 GET"

	```
	?datasetIds=TEST&referenceName=NC_000017.11&variantType=DEL&start=5000000&start=7676592&end=7669607&end=10000000
	```

	#### Optional

	* `datasetIds=__some-dataset-ids__`
	* `filters` ...


=== "Beacon v2 POST"

	```
	{
	    "$schema":"https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2-unity-testing/main/framework/json/requests/beaconRequestBody.json",
	    "meta": {
	        "apiVersion": "2.0",
	        "requestedSchemas": [
	            {
	                "entityType": "genomicVariation",
	                "schema:": "https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2-unity-testing/main/models/json/beacon-v2-default-model/genomicVariations/defaultSchema.json"
	            }
	        ]
	    },
	    "query": {
	        "requestParameters": {
	            "referenceName": "NC_000017.11",
	            "start": [ 5000000, 7676592 ],
	            "end": [ 7669607, 10000000 ],
	            "variantType": "DEL"
	        }
	    },
	    "requestedGranularity": "record",
	    "pagination": {
	        "skip": 0,
	        "limit": 5
	    }
	}
	```

	There are optional parameters [`datasetIds`, `filters` ...] and also the option to specify the response type
	(through `requestedGranularity`) and returned data format (`requestedSchemas`). Please follow this up in the
	[framework documentation](framework.md).


=== "Beacon v1"

	```
	?assemblyId=GRCh38&referenceName=17&variantType=DEL&start=5000000&start=7676592&end=7669607&end=10000000
	```

	#### Optional

	* `datasetIds=__some-dataset-ids__`


=== "Beacon v0.3"

	CNV query options were only implemented with Beacon v0.4, based on Beacon<sup>+</sup> prototyping.




==(TBD)==

## Query Parameter Change Log

<!--TODO: Should this go to a separate Beacon chamges page and be referenced?-->

### Beacon v2

* use of sequence reference id's which obviate the need for a `assemblyId` parameter
* **range queries**
	- with specified single start and end parameters a query should match any vatiant
	with partial or complete overlap with this sequence range
	- additional parameters (e.g. `referenceBases`, `alternateBases`, `variantType`...)
	may be used to scope the range query

### Beacon v1 (based on v0.4)

* switch to _0-based interbase_ coordinates for the API with _1-based_ coordinates
recommended for query forms
	- this represents the common GA4GH usage and the practice e.g. of the UCSC genome browser
* introduction of _bracketed queries_
	- specification of intervals for `start` and `end` positions when querying multi-base
	variants allows for "fuzzy" CNV queries
* support of a `variantType` parameter to specify e.g. CNV queries (`DUP`, `DEL`)
	- `variantType` is not required for precise queries with specified `referenceBases`
	and `alternateBases`



