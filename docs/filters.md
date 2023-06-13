# Filters

_Filters_ represent a powerful addition to the Beacon query API. They are rules for selecting records based upon the field values those records contain. The rules can refer to bio-ontology or custom terms, numerical or alphanumerical values, and employ wildcards, standard operators or other principles of selection. This empowers such options as queries for phenotypes, disease codes or technical parameters associated with observed genomic variants.

!!! Important "Using Filters"

	Please see [Using Filters in Queries](/filters/#using-filters-in-queries) for more information on how to use filters in Beacon requests.

## Filter types
A Beacon can support four types of Filters.

1. **Bio-ontology terms** for biomedical data or procedural metadata that are contained in public repositories such as the EMBL-EBI [Ontology Lookup Service](https://www.ebi.ac.uk/ols/index) or the NCBO [BioPortal](https://bioportal.bioontology.org/).  Bio-ontology terms are identified using the full term/class identifier as CURIE, e.g. “HP:0100526”.
2. **Custom terms** for biomedical or metadata terms that are locally defined by a Beacon (e.g. not corresponding to known bio-ontology terms).  Custom terms must contain unique identifiers that are used in Beacon requests.
3. **Numerical values** include integer, decimal and float data types.
4. **Alphanumerical values** include alphabetic letters and special characters with or without numbers.

## _/filtering_terms_  informational endpoint

The _/filtering_terms_ endpoint returns a list of all data fields whose values may be subjected to filtering, plus the data type(s) for those fields, and/or the list of extant values for each of those data fields in the current dataset.  In addition, for each bio-ontology used by a Beacon, the endpoint response includes a description of the bio-ontology in [Phenopackets Resource](https://phenopacket-schema.readthedocs.io/en/latest/resource.html) format.

The endpoint's `filterTerms` response identifies the Filter types.

Bio-ontology and custom term Filter types contain:

* `type` = resource name (required) 
* `id` = term id (required) 
* `label` = term label (optional)

```
"response":{
	"resources":[
		{
			"id":"hp",
			"name":"Human Phenotype Ontology",
			"url":"http://purl.obolibrary.org/obo/hp.owl",
			"version":"27-03-2020",
			"namespacePrefix":"HP",
			"iriPrefix":"http://purl.obolibrary.org/obo/HP_"
		},
		...
	],
	"filterTerms": [
		{
			"type": "ontologyTerm",
			"id": "HP:0008773",
			"label": "neoplasm of the lung"
		},
		...
	]
}
```

Alphanumerical value Filter types contain:

* `type` = data type as 'alphanumeric' (required) 
* `id` = field id (required) 
* `label` = field label (optional) 

```
"filterTerms": [
	{
		"type": "alphanumeric",
		"id": "PATO:0000011",
		"label": "age"
	},
	...
]
```


## Using Filters in Queries

For all query types, the logical `AND` is implied between Filters. The Filter `id` is required for all query types.

!!! Note "Filters in `GET` Requests"

	`GET` requests use a `filters` parameter for one or more (comma-separated) filter `id` values.
	In this case general filter defaults apply (e.g. `{ "includeDescendantTerms": true }`). Generally,
	use of filters other than CURIE values for filter ids is discouraged.

### Simple CURIE based filters query

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


### Hierarchical ontology query

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


### Semantic similarity query

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

### Numerical value query

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

### Alphanumerical value query
 
A Beacon will query free-text values within fields when the required `operator` and alphanumerical `value` parameters are set in the filters request. Queries can be for exact alphanumerical values, used to exclude alphanumerical values, or employ wildcards to match patterns within alphanumerical values.  In all query classes, the `id` parameter identifies the field name, the `operator` parameter defines the operator to use, and the `value` parameter provides the field query value.

#### 'EXACT' value query

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

#### 'NOT' value query

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
