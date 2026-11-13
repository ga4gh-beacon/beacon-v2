|Term | Description | Type | Properties | Example | Enum|
| ---| ---| ---| ---| ---| --- |
| biosampleId | Reference to the biosample entry id that this value was measured in. | string | NA | 008dafdd-a3d1-4801-8c0a-8714e2b58e48 | NA|
| featureId | Native accession of the quantified genomic feature as it appears in the matrix row. MUST equal featureIdentifier.id of the matching feature. Not a CURIE and not genomicFeatures.id. | string | NA | ENSG00000141510.18, ENST00000269305.9 | NA|
| id | Internal Beacon identifier for this expression value entry. | string | NA | expressionValue-001 | NA|
| matrixId | Reference to the matrix entry id that this value belongs to. | string | NA | matrix-gene-expression-001 | NA|
| value | Numeric expression quantification for this feature in this biosample. Units and scale are defined by the parent matrix (expressionUnitAndScale). | number | NA | 100 | NA|

## Examples
These are examples extracted directly from the [GitHub repository](https://github.com/ga4gh-beacon/beacon-v2).

=== "MAX"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "id": "expressionValue-tp53-gse88557-001",
	    "biosampleId": "008dafdd-a3d1-4801-8c0a-8714e2b58e48",
	    "featureId": "ENSG00000141510.18",
	    "matrixId": "GSE88557",
	    "value": 1247.5
	}
	```

=== "MIN"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "id": "expressionValue-001",
	    "biosampleId": "008dafdd-a3d1-4801-8c0a-8714e2b58e48",
	    "featureId": "ENSG00000141510.18",
	    "matrixId": "matrix-gene-expression-001",
	    "value": 100
	}
	```

