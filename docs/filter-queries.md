# Filters in Queries

For all query types, the logical `AND` is implied between Filters. The Filter `id` is required for all query types.

!!! Note "Filters in `GET` Requests"

	`GET` requests use a `filters` parameter for one or more (comma-separated) filter `id` values.
	In this case general filter defaults apply (e.g. `{ "includeDescendantTerms": true }`). Generally,
	use of filters other than CURIE values for filter ids is discouraged.

## Simple CURIE based filters query

The following query retrieves (or filters retrieved...) data matching the diagnosis of
Papillary Renal Cell Carcinoma (NCIT:C6975) from a publication identified through its PubMed id (22824167):

=== "GET"

	```http
	/biosamples?filters=PMID:22824167,NCIT:C6975
	```

=== "POST"

	```json
	"filters": [
		{
			"id": "PMID:22824167"
		},
		{
			"id": "NCIT:C6975"
		}
	]
	```


## Hierarchical ontology query

A Beacon will query for entities associated with the submitted bio-ontology term(s), and by default, all descendent terms.
The optional `includeDescendantTerms` parameter can be set to either `true` or `false`. The default and assumed value
of `includeDescendantTerms` is `true`, thus if the parameter is not set, then the use of bio-ontology terms in a Beacon
request implies that a hierarchical ontology search is requested.

Request example of two filters, where one filter excludes matches with descendent terms:

=== "POST"

	```json
	"filters": [
		{
			"id": "HP:0100526",
			"includeDescendantTerms": false
		},
		{
			"id": "HP:0005978"
		}
	]
	```


## Semantic similarity query

A Beacon will query for entities that are associated with bio-ontology terms that are similar to the submitted terms.  The Beacon API is agnostic to the semantic similarity model implemented by a Beacon and how a Beacon applies the relative thresholds of similarity.  A semantic similarity query request contains the required `similarity` parameter with a value set to define the relative threshold level of `high`, `medium` or `low`.

POST request example of two Filters using differing relative similarity thresholds:

```json
"filters": [
	{
		"id": "HP:0100526",
		"similarity": "high"
	},
	{
		"id": "HP:0005978",
		"similarity": "medium"
	}
]
```

## Numerical value query

A Beacon will query for quantitative properties when the required `operator` and numerical `value` parameters are set in the filters request. 
The `id` parameter identifies the field name, the `operator` parameter defines the operator to use, and the `value` parameter provides the field query value. Equality and relational operators (= < >) can be used between field name and field value pairs, and field values can be associated with units if applicable.

POST request example of a Filter for individuals over 70 years of age (age = PATO:0000011, age syntax as ISO 8601):

```json
"filters": [
	{
		"id": "PATO:0000011",
		"operator": ">",
		"value": "P70Y"
	}
]
```

## Alphanumerical value query
 
A Beacon will query free-text values within fields when the required `operator` and alphanumerical `value` parameters are set in the filters request. Queries can be for exact alphanumerical values, used to exclude alphanumerical values, or employ wildcards to match patterns within alphanumerical values.  In all query classes, the `id` parameter identifies the field name, the `operator` parameter defines the operator to use, and the `value` parameter provides the field query value.

### 'EXACT' value query

The `operator` parameter is set to the equality (=) operator.

POST request example of using free-text to filter medical history (past medical history = HP:0032443):

```json
"filters": [
	{
		"id": "HP:0032443",
		"operator": "=",
		"value": "unknown medical history"
	}
]
```

**'LIKE' value query**

The inclusion of a percent sign (%) wildcard character within the `value` parameter represents zero or more characters within a LIKE style string match.  The wildcard character can lead the query string, end the string, or surround the string.

POST request example to filter medical history free-text for any reference to cancer:

```json
"filters": [
	{
		"id": "HP:0032443",
		"operator": "=",
		"value": "%cancer%"
	}
]
```

### 'NOT' value query

The `operator` parameter is set to the logical not (!) operator.  The `value` parameter should not be present in field value.  The wildcard character can be used if required.

POST request example to filter medical history free-text for records that do not include the query string:

```json
"filters": [
	{
		"id": "HP:0032443",
		"operator": "!",
		"value": "unknown medical history"
	}
]
```
