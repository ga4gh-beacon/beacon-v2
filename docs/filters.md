# Filters

_Filters_ represent a powerful addition to the Beacon query API. They are rules for selecting records based upon the field values those records contain. The rules can refer to bio-ontology or custom terms, numerical or alphanumerical values, and employ wildcards, standard operators or other principles of selection. This empowers such options as queries for phenotypes, disease codes or technical parameters associated with observed genomic variants.

!!! Important "Using Filters"

	Please see [Using Filters in Queries](/filters/#using-filters-in-queries) for
	more information on how to use filters in Beacon requests.

## Filter types

A Beacon can support three general types of Filters.

1. **Bio-ontology terms and public identifiers** for biomedical data, procedural
   metadata or prefixed identifiers listed in public repositories such as the EMBL-EBI
   [Ontology Lookup Service](https://www.ebi.ac.uk/ols/index), the NCBO [BioPortal](https://bioportal.bioontology.org/)
   or PubMed. `OntologyFilters` are identified using the full term/class identifier
   as CURIE, e.g. “HP:0100526”.
2. **Numerical and alphanumerical values** including an indicator for their logical
   scope - preferably as a CURIE (e.g. `HP:0032443` _Past medical history_), a
   comparator and a numerical, pseudo-numerical (e.g. ISO8601 period) or string
   value
3. **Custom terms** for biomedical or metadata terms that are locally defined by
   a Beacon (e.g. not corresponding to known bio-ontology terms). Custom terms must
   contain unique identifiers that are used in Beacon requests (e.g. local prefixes).

## _/filtering_terms_  informational endpoint

The _/filtering_terms_ endpoint returns a list of all data fields whose values may be subjected to filtering, plus the data type(s) for those fields, and/or the list of extant values for each of those data fields in the current dataset. In addition, for each bio-ontology used by a Beacon, the endpoint response includes a description of the bio-ontology in [Phenopackets Resource](https://phenopacket-schema.readthedocs.io/en/latest/resource.html) format.

The endpoint's `filteringTerms` response identifies the Filter types.

Bio-ontology and custom term Filter types contain:

* `type` = resource name (required) 
* `id` = term id (required) 
* `label` = term label (optional)

```json
"response":{
	"resources":[
		{
			"id":"hp",
			"name":"Human Phenotype Ontology",
			"url":"https://purl.obolibrary.org/obo/hp.owl",
			"version":"27-03-2020",
			"namespacePrefix":"HP",
			"iriPrefix":"https://purl.obolibrary.org/obo/HP_"
		},
		...
	],
	"filteringTerms": [
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

```json
"filteringTerms": [
	{
		"type": "alphanumeric",
		"id": "PATO:0000011",
		"label": "age"
	}
]
```

## Using Filters in Queries

The Filter `id` is required for all query types.

!!! Note "Boolean Logic Between Filtering Terms"

	Beacon queries as of v2 always imply a logical **AND** between query parameters
	and individual filters, _i.e._ all conditions have to be met. There is currently
	no support for Boolean expressions.

!!! Note "Filters in `GET` Requests"

	`GET` requests use a `filters` parameter for one or more (comma-separated) filter `id` values.
	In this case general filter defaults apply (e.g. `{ "includeDescendantTerms": true }`). Generally,
	use of filters other than CURIE values for filter ids is discouraged.

!!! Attention "List Parameters in GET Requests"

	Since the direct interpretation of list parameters in queries is not supported by
	some server environments (e.g. PHP, GO…), list parameters such as `start` and `end`
	should be provided as **comma-concatenated** strings when using them in GET requests.

### CURIE based filters query (type "OntologyFilters")

!!! note "Hierarchical term expansion"

    It is recommended that the use of terms from hierarchical ontologies/classifications
    uses an internal term expansion mechanism - _i.e._ records with parameters containing
    a child term are matched when the parent term is being queried.
    This default behaviour can be modified (see below).

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


#### Modified hierarchical ontology query

A Beacon will query for entities associated with the submitted bio-ontology term(s), and by default, all descendant terms.
The optional `includeDescendantTerms` parameter can be set to either `true` or `false`. The default and assumed value
of `includeDescendantTerms` is `true`, thus if the parameter is not set, then the use of bio-ontology terms in a Beacon
request implies that a hierarchical ontology search is requested.

Request example of two filters, where one filter excludes matches with descendant terms:

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


#### Semantic similarity query

A Beacon will query for entities that are associated with bio-ontology terms that are similar to the submitted terms. The Beacon API is agnostic to the semantic similarity model implemented by a Beacon and how a Beacon applies the relative thresholds of similarity. A semantic similarity query request contains the required `similarity` parameter with a value set to define the relative threshold level of `high`, `medium` or `low`.

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

### Alphanumerical value queries

A Beacon will query for quantitative properties when the required `operator` and
numerical `value` parameters are set in the filters request. The `id` parameter
identifies the logical scope (with the exact field depending on the internal data
model at the resource), the `operator` parameter defines the operator to use,
and the `value` parameter provides the field query value. Equality and relational
operators (= < >) can be used between field name and field value pairs, and field
values can be associated with units if applicable.

#### (Pseudo-)numerical value queries

##### Example of a Filter for individuals over 70 years of age

* age = PATO:0000011, age syntax as ISO 8601

=== "GET"

    * `filters=age:>P70Y`
        - intuitive use but w/o clear scoping (age... when?)
    * `filters=PATO_0000011:>P70Y` ("age")
        - using a term for expressing the age quality of the ISO8601 duration
        - computationally more robust but w/o additional quality (age... when?)
    * `filters=EFO_0004847:>P70Y` ("age at onset")
        - specific for an "onset" scope of the age value

=== "POST"

	```json
	"filters": [
		{
			"id": "PATO:0000011",
			"operator": ">",
			"value": "P70Y"
		}
	]
	```

We recommend that implementers provide **term expansions** for equivalent terms,
depending on the context. Also, it is up to the implementers to provide the
correct tooling for e.g. transformation of input values (e.g. numerical age in
years and comparator) to the standardized wire format (e.g. ages/durations are
**always** transmitted as ISO8601 periods) as well as the correct deparsing and
use (e.g. the ISO values probably will be converted to some numerical format for
database matches).


#### Text matches
 
A Beacon will query free-text values within fields when the required `operator`
and alphanumerical `value` parameters are set in the filters request. Queries can
be for exact alphanumerical values, used to exclude alphanumerical values, or employ
wildcards to match patterns within alphanumerical values. In all query classes,
the `id` parameter identifies the field name, the `operator` parameter defines the
operator to use, and the `value` parameter provides the field query value.

##### 'EXACT' value query

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

The inclusion of a percent sign (%) wildcard character within the `value` parameter represents zero or more characters within a LIKE style string match. The wildcard character can lead the query string, end the string, or surround the string.

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

##### 'NOT' value query

The `operator` parameter is set to the logical not (!) operator. The `value` parameter should not be present in field value. The wildcard character can be used if required. The following example shows how to filter medical history free-text for records that do not include the query string:

=== "GET"

    `filters=HP_0032443:!unknown+medical+history`

=== "POST"

	```json
	"filters": [
		{
			"id": "HP:0032443",
			"operator": "!",
			"value": "unknown medical history"
		}
	]
	```
