# Genomic Variant Queries

For querying of genomic variations Beacon v2 builds on and extends the options provided
by earlier versions.

## Query Examples

### Beacon SNV Query 

=== "Beacon v2 GET"

	```
	?datasetIds=TEST&referenceName=NC_000017.11&start=7577120&referenceBases=G&alternateBases=A
	```


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
	            "datasets": {
	                "datasetIds": ["TEST"]
	            },
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
	    },
	    "filters": []
	}
	```


=== "Beacon v1"

	```
	?assemblyId=GRCh38&datasetIds=TEST&referenceName=17&start=7577120&referenceBases=G&alternateBases=A
	```

=== "Beacon v0.3"

	```
	?ref=GRCh38&beacon=TEST&chrom=17&pos=7577121&referenceAllele=C&allele=A
	```

	Before Beacon v0.4 a 1-based coordinate system was being used.


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



