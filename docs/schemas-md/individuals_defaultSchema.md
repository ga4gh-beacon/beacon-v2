|Term | Description | Type | Properties | Example | Enum|
| ---| ---| ---| ---| ---| --- |
| [diseases](./obj/diseases.md) | Diseases diagnosed e.g. to an individual, defined by diseaseID, age of onset, stage, level of severity, outcome and the presence of family history. Similarities to GA4GH Phenopackets v2 `Disease` | array | [ageOfOnset](./obj/ageOfOnset.md), [diseaseCode](./obj/diseaseCode.md), [familyHistory](./obj/familyHistory.md), [notes](./obj/notes.md), [severity](./obj/severity.md), [stage](./obj/stage.md) | NA | NA|
| [ethnicity](./obj/ethnicity.md) | Ethnic background of the individual. Value from NCIT Race (NCIT:C17049) ontology term descendants, e.g. NCIT:C126531 (Latin American). A geographic ancestral origin category that is assigned to a population group based mainly on physical characteristics that are thought to be distinct and inherent. [ NCI ]  | object | [id](./obj/id.md), [label](./obj/label.md) | `[{"id": "NCIT:C42331", "label": "African"}, {"id": "NCIT:C41260", "label": "Asian"}, {"id": "NCIT:C126535", "label": "Australian"}, {"id": "NCIT:C43851", "label": "European"}, {"id": "NCIT:C77812", "label": "North American"}, {"id": "NCIT:C126531", "label": "Latin American"}, {"id": "NCIT:C104495", "label": "Other race"}]` | NA|
| [exposures](./obj/exposures.md) | Exposures (lifestyle, behavioural exposures) occurred to individual, defined by exposure ID, date and age of onset, dose, and duration. | array | [ageAtExposure](./obj/ageAtExposure.md), [date](./obj/date.md), [duration](./obj/duration.md), [exposureCode](./obj/exposureCode.md), [unit](./obj/unit.md), [value](./obj/value.md) | NA | NA|
| [geographicOrigin](./obj/geographicOrigin.md) | Individual's country or region of origin (birthplace or residence place regardless of ethnic origin). Value from GAZ Geographic Location ontology (GAZ:00000448), e.g. GAZ:00002459 (United States of America). | object | [id](./obj/id.md), [label](./obj/label.md) | `[{"id": "GAZ:00002955", "label": "Slovenia"}, {"id": "GAZ:00002459", "label": "United States of America"}, {"id": "GAZ:00316959", "label": "Municipality of El Masnou"}, {"id": "GAZ:00000460", "label": "Eurasia"}]` | NA|
| [id](./obj/id.md) | Individual identifier (internal ID). | string | NA | P0001 | NA|
| [info](./obj/info.md) | Placeholder to allow the Beacon to return any additional information that is necessary or could be of interest in relation to the query or the entry returned. It is recommended to encapsulate additional informations in this attribute instead of directly adding attributes at the same level than the others in order to avoid collision in the names of attributes in future versions of the specification. | object | NA | NA | NA|
| [interventionsOrProcedures](./obj/interventionsOrProcedures.md) | Class describing a clinical procedure or intervention. Provenance: GA4GH Phenopackets v2 `Procedure` | array | [ageAtProcedure](./obj/ageAtProcedure.md), [bodySite](./obj/bodySite.md), [dateOfProcedure](./obj/dateOfProcedure.md), [procedureCode](./obj/procedureCode.md) | NA | NA|
| [karyotypicSex](./obj/karyotypicSex.md) | The chromosomal sex of an individual represented from a selection of options. | string | NA | NA | UNKNOWN_KARYOTYPE, XX, XY, XO, XXY, XXX, XXYY, XXXY, XXXX, XYY, OTHER_KARYOTYPE|
| [measures](./obj/measures.md) | Definition of a measurement class. Provenance: GA4GH Phenopackets v2 `Measurement` | array | [assayCode](./obj/assayCode.md), [date](./obj/date.md), [measurementValue](./obj/measurementValue.md), [notes](./obj/notes.md), [observationMoment](./obj/observationMoment.md), [procedure](./obj/procedure.md) | NA | NA|
| [pedigrees](./obj/pedigrees.md) | Pedigree studies in which the individual is part of. | array | [disease](./obj/disease.md), [id](./obj/id.md), [members](./obj/members.md), [numSubjects](./obj/numSubjects.md) | NA | NA|
| [phenotypicFeatures](./obj/phenotypicFeatures.md) | Used to describe a phenotype that characterizes the subject or biosample. | array | [evidence](./obj/evidence.md), [excluded](./obj/excluded.md), [featureType](./obj/featureType.md), [modifiers](./obj/modifiers.md), [notes](./obj/notes.md), [onset](./obj/onset.md), [resolution](./obj/resolution.md), [severity](./obj/severity.md) | NA | NA|
| [sex](./obj/sex.md) | Sex of the individual. Value from NCIT General Qualifier (NCIT:C27993): 'unknown' (not assessed or not available) (NCIT:C17998), 'female' (NCIT:C16576), or 'male', (NCIT:C20197). | object | [id](./obj/id.md), [label](./obj/label.md) | `[{"id": "NCIT:C16576", "label": "female"}, {"id": "NCIT:C20197", "label": "male"}, {"id": "NCIT:C1799", "label": "unknown"}]` | NA|
| [treatments](./obj/treatments.md) | Treatment(s) prescribed/administered, defined by treatment ID, date and age of onset, dose, schedule and duration. | array | [ageAtOnset](./obj/ageAtOnset.md), [cumulativeDose](./obj/cumulativeDose.md), [doseIntervals](./obj/doseIntervals.md), [routeOfAdministration](./obj/routeOfAdministration.md), [treatmentCode](./obj/treatmentCode.md) | NA | NA|

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

