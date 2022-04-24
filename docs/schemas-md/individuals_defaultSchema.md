|Term | Description | Type | Properties | Example | Enum|
| ---| ---| ---| ---| ---| --- |
| [diseases](./obj/diseases.md) | List of disease(s) been diagnosed to the individual, defined by disease ontology ID(s), age of onset, stage and the presence of family history. | array | [ageOfOnset](./obj/ageOfOnset.md), [diseaseCode](./obj/diseaseCode.md), [familyHistory](./obj/familyHistory.md), [notes](./obj/notes.md), [severity](./obj/severity.md), [stage](./obj/stage.md) | NA | NA|
| [ethnicity](./obj/ethnicity.md) | Definition of an ontology term. | object | [id](./obj/id.md), [label](./obj/label.md) | NA | NA|
| [exposures](./obj/exposures.md) | NA | array | [ageAtExposure](./obj/ageAtExposure.md), [date](./obj/date.md), [duration](./obj/duration.md), [exposureCode](./obj/exposureCode.md), [unit](./obj/unit.md), [value](./obj/value.md) | NA | NA|
| [geographicOrigin](./obj/geographicOrigin.md) | Definition of an ontology term. | object | [id](./obj/id.md), [label](./obj/label.md) | NA | NA|
| [id](./obj/id.md) | Individual identifier (internal ID). | string | NA | P0001 | NA|
| [info](./obj/info.md) | Placeholder to allow the Beacon to return any additional information that is necessary or could be of interest in relation to the query or the entry returned. It is recommended to encapsulate additional informations in this attribute instead of directly adding attributes at the same level than the others in order to avoid collision in the names of attributes in future versions of the specification. | object | NA | NA | NA|
| [interventionsOrProcedures](./obj/interventionsOrProcedures.md) | NA | array | [ageAtProcedure](./obj/ageAtProcedure.md), [bodySite](./obj/bodySite.md), [dateOfProcedure](./obj/dateOfProcedure.md), [procedureCode](./obj/procedureCode.md) | NA | NA|
| [karyotypicSex](./obj/karyotypicSex.md) | The chromosomal sex of an individual represented from a selection of options. The values correspond to the ordinal values in the Phenopackets schema where: 0 - UNKNOWN_KARYOTYPE (Untyped or inconclusive karyotyping); 1 - XX (Female); 2 - XY (Male); 3 - XO (Single X chromosome only); 4 - XXY (Two X and one Y chromosome); 5 - XXX (Three X chromosomes); 6 - XXYY (Two X chromosomes and two Y chromosomes); 7 - XXXY (Three X chromosomes and one Y chromosome); 8 - XXXX (Four X chromosomes); 9 - XYY (One X and two Y chromosomes); 10 - OTHER_KARYOTYPE (None of the above types) | string | NA | NA | UNKNOWN_KARYOTYPE, XX, XY, XO, XXY, XXX, XXYY, XXXY, XXXX, XYY, OTHER_KARYOTYPE|
| [measures](./obj/measures.md) | NA | array | [assayCode](./obj/assayCode.md), [date](./obj/date.md), [measurementValue](./obj/measurementValue.md), [notes](./obj/notes.md), [observationMoment](./obj/observationMoment.md), [procedure](./obj/procedure.md) | NA | NA|
| [pedigrees](./obj/pedigrees.md) | NA | array | [disease](./obj/disease.md), [id](./obj/id.md), [members](./obj/members.md), [numSubjects](./obj/numSubjects.md) | NA | NA|
| [phenotypicFeatures](./obj/phenotypicFeatures.md) | NA | array | [evidence](./obj/evidence.md), [excluded](./obj/excluded.md), [featureType](./obj/featureType.md), [modifiers](./obj/modifiers.md), [notes](./obj/notes.md), [onset](./obj/onset.md), [resolution](./obj/resolution.md), [severity](./obj/severity.md) | NA | NA|
| [sex](./obj/sex.md) | Definition of an ontology term. | object | [id](./obj/id.md), [label](./obj/label.md) | NA | NA|
| [treatments](./obj/treatments.md) | NA | array | [ageAtOnset](./obj/ageAtOnset.md), [cumulativeDose](./obj/cumulativeDose.md), [doseIntervals](./obj/doseIntervals.md), [routeOfAdministration](./obj/routeOfAdministration.md), [treatmentCode](./obj/treatmentCode.md) | NA | NA|

## Examples
These are examples extracted directly from the [GitHub repository](https://github.com/ga4gh-beacon/beacon-v2-Models).

=== "MIN"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "id": "Ind001",
	    "sex": {
	        "id": "NCIT:C16576",
	        "label": "female"
	    }
	}
	```

=== "MID"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "diseases": [
	        {
	            "ageOfOnset": {
	                "ageGroup": {
	                    "id": "NCIT:C49685",
	                    "label": "Adult 18-65 Years Old"
	                }
	            },
	            "diseaseCode": {
	                "id": "OMIM:164400",
	                "label": "Spinocerebellar ataxia 1"
	            },
	            "familyHistory": false,
	            "severity": {
	                "id": "HP:0012829",
	                "label": "Profound"
	            },
	            "stage": {
	                "id": "OGMS:0000119",
	                "label": "acute onset"
	            }
	        }
	    ],
	    "ethnicity": {
	        "id": "NCIT:C43851",
	        "label": "European"
	    },
	    "geographicOrigin": {
	        "id": "GAZ:00002955",
	        "label": "Slovenia"
	    },
	    "id": "Ind001",
	    "measures": [
	        {
	            "assayCode": {
	                "id": "LOINC:26515-7",
	                "label": "Platelets [#/volume] in Blood"
	            },
	            "date": "2017-05-03",
	            "measurementValue": {
	                "units": {
	                    "id": "NCIT:C103452",
	                    "label": "Per Milliliter"
	                },
	                "value": 55345
	            },
	            "observationMoment": {
	                "age": {
	                    "iso8601duration": "P55Y8M12D"
	                }
	            }
	        }
	    ],
	    "sex": {
	        "id": "NCIT:C16576",
	        "label": "female"
	    }
	}
	```

