|Term | Description | Type | Properties | Example | Enum|
| ---| ---| ---| ---| ---| --- |
| [cohortDataTypes](./obj/cohortDataTypes.md) | Type of information. Preferably values from Genomics Cohorts Knowledge Ontology (GeCKO) or others when GeCKO is not applicable. | array | [id](./obj/id.md), [label](./obj/label.md) | `[{"id": "OGMS:0000015", "label": "clinical history"}, {"id": "OBI:0000070", "label": "genotyping assay"}, {"id": "OMIABIS:0000060", "label": "survey data"}]` | NA|
| [cohortDesign](./obj/cohortDesign.md) | Definition of an ontology term. | object | [id](./obj/id.md), [label](./obj/label.md) | NA | NA|
| [cohortSize](./obj/cohortSize.md) | Count of unique Individuals in cohort (individuals meeting criteria for ´user-defined´ cohorts). If not previously known, it could be calculated by counting the individuals in the cohort. | integer | NA | 14765, 20000 | NA|
| [cohortType](./obj/cohortType.md) | Cohort type by its definition. If a cohort is declared ´study-defined´ or ´beacon-defined´ criteria are to be entered in cohort_inclusion_criteria; if a cohort is declared ‘user-defined' cohort_inclusion_criteria could be automatically populated from the parameters used to perform the query. | string | NA | NA | study-defined, beacon-defined, user-defined|
| [collectionEvents](./obj/collectionEvents.md) | TBD | array | [eventAgeRange](./obj/eventAgeRange.md), [eventCases](./obj/eventCases.md), [eventControls](./obj/eventControls.md), [eventDataTypes](./obj/eventDataTypes.md), [eventDate](./obj/eventDate.md), [eventDiseases](./obj/eventDiseases.md), [eventEthnicities](./obj/eventEthnicities.md), [eventGenders](./obj/eventGenders.md), [eventLocations](./obj/eventLocations.md), [eventNum](./obj/eventNum.md), [eventPhenotypes](./obj/eventPhenotypes.md), [eventSize](./obj/eventSize.md), [eventTimeline](./obj/eventTimeline.md) | NA | NA|
| [exclusionCriteria](./obj/exclusionCriteria.md) | Criteria used for defining the cohort. It is assumed that all cohort participants will match or NOT match such criteria. | object | [ageRange](./obj/ageRange.md), [diseaseConditions](./obj/diseaseConditions.md), [ethnicities](./obj/ethnicities.md), [genders](./obj/genders.md), [locations](./obj/locations.md), [phenotypicConditions](./obj/phenotypicConditions.md) | NA | NA|
| [id](./obj/id.md) | Cohort identifier. For ´study-defined´ or ´beacon-defined´cohorts this field is set by the implementer. For ´user-defined´ this unique identifier could be generated upon the query that defined the cohort, but could be later edited by the user. | string | NA | cohort-T2D-2010 | NA|
| [inclusionCriteria](./obj/inclusionCriteria.md) | Criteria used for defining the cohort. It is assumed that all cohort participants will match or NOT match such criteria. | object | [ageRange](./obj/ageRange.md), [diseaseConditions](./obj/diseaseConditions.md), [ethnicities](./obj/ethnicities.md), [genders](./obj/genders.md), [locations](./obj/locations.md), [phenotypicConditions](./obj/phenotypicConditions.md) | NA | NA|
| [name](./obj/name.md) | Name of the cohort. For ´user-defined´ this field could be generated upon the query, e.g. a value that is a concatenationor some representation of the user query. | string | NA | Wellcome Trust Case Control Consortium, GCAT Genomes for Life | NA|

## Examples
These are examples extracted directly from the [GitHub repository](https://github.com/ga4gh-beacon/beacon-v2-Models).

=== "MIN"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "cohortType": "study-defined",
	    "id": "cohort0001",
	    "name": "GCAT Genomes for Life"
	}
	```

=== "MID"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "cohortDataTypes": [
	        {
	            "id": "OGMS:0000015",
	            "label": "clinical history"
	        },
	        {
	            "id": "OBI:0000070",
	            "label": "genotyping assay"
	        },
	        {
	            "id": "OMIABIS:0000060",
	            "label": "survey data"
	        }
	    ],
	    "cohortDesign": {
	        "id": "OMIABIS:0001019",
	        "label": "longitudinal study design"
	    },
	    "cohortSize": 20000,
	    "cohortType": "study-defined",
	    "id": "cohort0001",
	    "inclusionCriteria": {
	        "ageRange": {
	            "end": {
	                "iso8601duration": "P40Y"
	            },
	            "start": {
	                "iso8601duration": "P18Y"
	            }
	        },
	        "genders": [
	            {
	                "id": "NCIT:C16576",
	                "label": "female"
	            },
	            {
	                "id": "NCIT:C20197",
	                "label": "male"
	            }
	        ],
	        "locations": [
	            {
	                "id": "GAZ:00004501",
	                "label": "Catalonia Autonomous Community"
	            }
	        ]
	    },
	    "name": "GCAT Genomes for Life"
	}
	```

=== "MAX"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "cohortDataTypes": [
	        {
	            "id": "OGMS:0000015",
	            "label": "clinical history"
	        },
	        {
	            "id": "OBI:0000070",
	            "label": "genotyping assay"
	        },
	        {
	            "id": "OMIABIS:0000060",
	            "label": "survey data"
	        }
	    ],
	    "cohortDesign": {
	        "id": "OMIABIS:0001019",
	        "label": "longitudinal study design"
	    },
	    "cohortSize": 20000,
	    "cohortType": "study-defined",
	    "collectionEvents": [
	        {
	            "eventDataTypes": {
	                "availability": true,
	                "distribution": {
	                    "dataTypes": {
	                        "blood collected from fasting subject": 51,
	                        "survey data": 98
	                    }
	                }
	            },
	            "eventDate": "2019-04-23",
	            "eventEthnicities": {
	                "availability": true,
	                "availabilityCount": 101,
	                "distribution": {
	                    "ethnicities": {
	                        "African": 3,
	                        "European": 90,
	                        "Latin American": 8
	                    }
	                }
	            },
	            "eventGenders": {
	                "availability": true,
	                "availabilityCount": 101,
	                "distribution": {
	                    "genders": {
	                        "female": 51,
	                        "male": 50
	                    }
	                }
	            },
	            "eventNum": 1,
	            "eventSize": 101
	        }
	    ],
	    "id": "cohort0001",
	    "inclusionCriteria": {
	        "ageRange": {
	            "end": {
	                "iso8601duration": "P40Y"
	            },
	            "start": {
	                "iso8601duration": "P18Y"
	            }
	        },
	        "genders": [
	            {
	                "id": "NCIT:C16576",
	                "label": "female"
	            },
	            {
	                "id": "NCIT:C20197",
	                "label": "male"
	            }
	        ],
	        "locations": [
	            {
	                "id": "GAZ:00004501",
	                "label": "Catalonia Autonomous Community"
	            }
	        ]
	    },
	    "name": "GCAT Genomes for Life"
	}
	```

