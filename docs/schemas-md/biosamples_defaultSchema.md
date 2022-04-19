|Term | Description | Type | Properties | Example | Enum|
| ---| ---| ---| ---| ---| --- |
| [biosampleStatus](./obj/biosampleStatus.md) | Definition of an ontology term. | object | [id](./obj/id.md), [label](./obj/label.md) | NA | NA|
| [collectionDate](./obj/collectionDate.md) | Date of biosample collection in ISO8601 format. | string | NA | 2021-04-23 | NA|
| [collectionMoment](./obj/collectionMoment.md) | Individual's or cell cullture age at the time of sample collection in the ISO8601 duration format `P[n]Y[n]M[n]DT[n]H[n]M[n]S`. | string | NA | P32Y6M1D, P7D | NA|
| [diagnosticMarkers](./obj/diagnosticMarkers.md) | Clinically relevant biomarkers. RECOMMENDED. | array | [id](./obj/id.md), [label](./obj/label.md) | NA | NA|
| [histologicalDiagnosis](./obj/histologicalDiagnosis.md) | Definition of an ontology term. | object | [id](./obj/id.md), [label](./obj/label.md) | NA | NA|
| [id](./obj/id.md) | Biosample identifier (external accession or internal ID). | string | NA | S0001 | NA|
| [individualId](./obj/individualId.md) | Reference to the individual from which that sample was obtained. | string | NA | P0001 | NA|
| [info](./obj/info.md) | Placeholder to allow the Beacon to return any additional information that is necessary or could be of interest in relation to the query or the entry returned. It is recommended to encapsulate additional informations in this attribute instead of directly adding attributes at the same level than the others in order to avoid collision in the names of attributes in future versions of the specification. | object | NA | NA | NA|
| [measurements](./obj/measurements.md) | List of measurements of the sample. | array | [assayCode](./obj/assayCode.md), [date](./obj/date.md), [measurementValue](./obj/measurementValue.md), [notes](./obj/notes.md), [observationMoment](./obj/observationMoment.md), [procedure](./obj/procedure.md) | NA | NA|
| [notes](./obj/notes.md) | Any relevant info about the biosample that does not fit into any other field in the schema. | string | NA | Some free text | NA|
| [obtentionProcedure](./obj/obtentionProcedure.md) | Class describing a clinical procedure or intervention. Provenance: GA4GH Phenopackets v2 `Procedure` | object | [ageAtProcedure](./obj/ageAtProcedure.md), [bodySite](./obj/bodySite.md), [dateOfProcedure](./obj/dateOfProcedure.md), [procedureCode](./obj/procedureCode.md) | NA | NA|
| [pathologicalStage](./obj/pathologicalStage.md) | Definition of an ontology term. | object | [id](./obj/id.md), [label](./obj/label.md) | NA | NA|
| [pathologicalTnmFinding](./obj/pathologicalTnmFinding.md) | Pathological TNM findings, if applicable, preferably as subclass of NCIT:C48698 - Cancer TNM Finding Category (NCIT:C48698). RECOMMENDED. | array | [id](./obj/id.md), [label](./obj/label.md) | `[{"id": "NCIT:C48725", "label": "T2a Stage Finding"}, {"id": "NCIT:C48709", "label": "N1c Stage Finding"}, {"id": "NCIT:C48699", "label": "M0 Stage Finding"}]` | NA|
| [phenotypicFeatures](./obj/phenotypicFeatures.md) | List of phenotypic abnormalities of the sample. RECOMMENDED. | array | [evidence](./obj/evidence.md), [excluded](./obj/excluded.md), [featureType](./obj/featureType.md), [modifiers](./obj/modifiers.md), [notes](./obj/notes.md), [onset](./obj/onset.md), [resolution](./obj/resolution.md), [severity](./obj/severity.md) | NA | NA|
| [sampleOriginDetail](./obj/sampleOriginDetail.md) | Definition of an ontology term. | object | [id](./obj/id.md), [label](./obj/label.md) | NA | NA|
| [sampleOriginType](./obj/sampleOriginType.md) | Definition of an ontology term. | object | [id](./obj/id.md), [label](./obj/label.md) | NA | NA|
| [sampleProcessing](./obj/sampleProcessing.md) | Definition of an ontology term. | object | [id](./obj/id.md), [label](./obj/label.md) | NA | NA|
| [sampleStorage](./obj/sampleStorage.md) | Definition of an ontology term. | object | [id](./obj/id.md), [label](./obj/label.md) | NA | NA|
| [tumorGrade](./obj/tumorGrade.md) | Definition of an ontology term. | object | [id](./obj/id.md), [label](./obj/label.md) | NA | NA|
| [tumorProgression](./obj/tumorProgression.md) | Definition of an ontology term. | object | [id](./obj/id.md), [label](./obj/label.md) | NA | NA|

## Examples
These are examples extracted directly from the [GitHub repository](https://github.com/ga4gh-beacon/beacon-v2-Models).

=== "MIN"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "biosampleStatus": {
	        "id": "EFO:0009655",
	        "label": "abnormal sample"
	    },
	    "id": "sample-example-0001",
	    "sampleOriginType": {
	        "id": "UBERON:0000474",
	        "label": "female reproductive system"
	    }
	}
	```

=== "MID"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "biosampleStatus": {
	        "id": "EFO:0009655",
	        "label": "abnormal sample"
	    },
	    "collectionDate": "2020-09-11",
	    "collectionMoment": "P32Y6M1D",
	    "id": "sample-example-0001",
	    "obtentionProcedure": {
	        "procedureCode": {
	            "id": "OBI:0002654",
	            "label": "needle biopsy"
	        }
	    },
	    "sampleOriginType": {
	        "id": "UBERON:0000992",
	        "label": "ovary"
	    }
	}
	```

