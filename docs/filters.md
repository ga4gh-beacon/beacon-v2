# Filters

_Filters_ represent a powerful addition to the Beacon query API. They are rules for selecting records based upon the field values those records contain. The rules can refer to bio-ontology or custom terms, numerical or alphanumerical values, and employ wildcards, standard operators or other principles of selection. This empowers such options as queries for phenotypes, disease codes or technical parameters associated with observed genomic variants.

!!! Important "Using Filters"

	Please see the [Filters in Queries](/filter-queries) page for more information on how to use filters in Beacon requests.

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
			"type": "Human Phenotype Ontology",
			"id": "HP:0008773",
			"label": "neoplasm of the lung"
		},
		...
	]
}
```

Numerical value Filter types contain:

* `type` = data type as 'numeric' (required) 
* `id` = field id (required) 
* `label` = field label (optional) 

```
"filterTerms": [
	{
		"type": "numeric",
		"id": "PATO:000001",
		"label": "age"
	},
	...
]
```

Alphanumerical value Filter types contain:

* `type` = data type as 'alphanumeric' (required) 
* `id` = field id (required) 
* `label` = field label (optional) 

```
"filterTerms": [
	{
		"type": "alphanumeric",
		"id": "HP:0032443",
		"label": "past medical history"
	},
	...
]
```
