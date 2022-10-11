|Term | Description | Type | Properties | Example | Enum|
| ---| ---| ---| ---| ---| --- |
| [biosampleStatus](./obj/biosampleStatus.md) | Ontology value from Experimental Factor Ontology (EFO) Material Entity term (BFO:0000040). Classification of the sample in abnormal sample (EFO:0009655) or reference sample (EFO:0009654). | object | [id](./obj/id.md), [label](./obj/label.md) | `[{"id": "EFO:0009654", "label": "reference sample"}, {"id": "EFO:0009655", "label": "abnormal sample"}, {"id": "EFO:0009656", "label": "neoplastic sample"}, {"id": "EFO:0010941", "label": "metastasis sample"}, {"id": "EFO:0010942", "label": "primary tumor sample"}, {"id": "EFO:0010943", "label": "recurrent tumor sample"}]` | NA|
| [collectionDate](./obj/collectionDate.md) | Date of biosample collection in ISO8601 format. | string | NA | 2021-04-23 | NA|
| [collectionMoment](./obj/collectionMoment.md) | Individual's or cell cullture age at the time of sample collection in the ISO8601 duration format `P[n]Y[n]M[n]DT[n]H[n]M[n]S`. | string | NA | P32Y6M1D, P7D | NA|
| [diagnosticMarkers](./obj/diagnosticMarkers.md) | NA | array | [id](./obj/id.md), [label](./obj/label.md) | NA | NA|
| [histologicalDiagnosis](./obj/histologicalDiagnosis.md) | Disease diagnosis that was inferred from the histological examination. RECOMMENDED. | object | [id](./obj/id.md), [label](./obj/label.md) | `[{"id": "NCIT:C3778", "label": "Serous Cystadenocarcinoma"}]` | NA|
| [id](./obj/id.md) | Biosample identifier (external accession or internal ID). | string | NA | S0001 | NA|
| [individualId](./obj/individualId.md) | Reference to the individual from which that sample was obtained. | string | NA | P0001 | NA|
| [info](./obj/info.md) | Placeholder to allow the Beacon to return any additional information that is necessary or could be of interest in relation to the query or the entry returned. It is recommended to encapsulate additional informations in this attribute instead of directly adding attributes at the same level than the others in order to avoid collision in the names of attributes in future versions of the specification. | object | NA | NA | NA|
| [measurements](./obj/measurements.md) | Definition of a measurement class. Provenance: GA4GH Phenopackets v2 `Measurement` | array | [assayCode](./obj/assayCode.md), [date](./obj/date.md), [measurementValue](./obj/measurementValue.md), [notes](./obj/notes.md), [observationMoment](./obj/observationMoment.md), [procedure](./obj/procedure.md) | NA | NA|
| [notes](./obj/notes.md) | Any relevant info about the biosample that does not fit into any other field in the schema. | string | NA | Some free text | NA|
| [obtentionProcedure](./obj/obtentionProcedure.md) | Ontology value from NCIT Intervention or Procedure ontology term (NCIT:C25218) describing the procedure for sample obtention, e.g. NCIT:C15189 (biopsy). | object | [ageAtProcedure](./obj/ageAtProcedure.md), [bodySite](./obj/bodySite.md), [dateOfProcedure](./obj/dateOfProcedure.md), [procedureCode](./obj/procedureCode.md) | `[{"code": {"id": "NCIT:C15189", "label": "biopsy"}}, {"code": {"id": "NCIT:C157179", "label": "FGFR1 Mutation Analysis"}}]` | NA|
| [pathologicalStage](./obj/pathologicalStage.md) | Pathological stage, if applicable, preferably as subclass of NCIT:C28108 - Disease Stage Qualifier. RECOMMENDED. | object | [id](./obj/id.md), [label](./obj/label.md) | `[{"id": "NCIT:C27977", "label": "Stage IIIA"}]` | NA|
| [pathologicalTnmFinding](./obj/pathologicalTnmFinding.md) | NA | array | [id](./obj/id.md), [label](./obj/label.md) | `[{"id": "NCIT:C48725", "label": "T2a Stage Finding"}, {"id": "NCIT:C48709", "label": "N1c Stage Finding"}, {"id": "NCIT:C48699", "label": "M0 Stage Finding"}]` | NA|
| [phenotypicFeatures](./obj/phenotypicFeatures.md) | Used to describe a phenotype that characterizes the subject or biosample. | array | [evidence](./obj/evidence.md), [excluded](./obj/excluded.md), [featureType](./obj/featureType.md), [modifiers](./obj/modifiers.md), [notes](./obj/notes.md), [onset](./obj/onset.md), [resolution](./obj/resolution.md), [severity](./obj/severity.md) | NA | NA|
| [sampleOriginDetail](./obj/sampleOriginDetail.md) | Tissue from which the sample was taken or sample origin matching the category set in 'sampleOriginType'. Value from Uber-anatomy ontology (UBERON) or BRENDA tissue / enzyme source (BTO), Ontology for Biomedical Investigations (OBI) or Cell Line Ontology (CLO), e.g. 'cerebellar vermis' (UBERON:0004720), 'HEK-293T cell' (BTO:0002181), 'nasopharyngeal swab specimen' (OBI:0002606), 'cerebrospinal fluid specimen' (OBI:0002502). | object | [id](./obj/id.md), [label](./obj/label.md) | `[{"id": "UBERON:0000474", "label": "female reproductive system"}, {"id": "BTO:0002181", "label": "HEK-293T cell"}, {"id": "OBI:0002606", "label": "nasopharyngeal swab specimen"}]` | NA|
| [sampleOriginType](./obj/sampleOriginType.md) | Category of sample origin. Value from Ontology for Biomedical Investigations (OBI) material entity (BFO:0000040) ontology, e.g. 'specimen from organism' (OBI:0001479),'xenograft' (OBI:0100058), 'cell culture' (OBI:0001876) | object | [id](./obj/id.md), [label](./obj/label.md) | `[{"id": "OBI:0001479", "label": "specimen from organism"}, {"id": "OBI:0001876", "label": "cell culture"}, {"id": "OBI:0100058", "label": "xenograft"}]` | NA|
| [sampleProcessing](./obj/sampleProcessing.md) | Status of how the specimen was processed,e.g. a child term of EFO:0009091. | object | [id](./obj/id.md), [label](./obj/label.md) | `[{"id": "EFO:0009129", "label": "mechanical dissociation"}]` | NA|
| [sampleStorage](./obj/sampleStorage.md) | Status of how the specimen was stored. | object | [id](./obj/id.md), [label](./obj/label.md) |  | NA|
| [tumorGrade](./obj/tumorGrade.md) | Term representing the tumor grade. Child term of NCIT:C28076 (Disease Grade Qualifier) or equivalent. | object | [id](./obj/id.md), [label](./obj/label.md) | `[{"id": "NCIT:C28080", "label": "Grade 3a"}]` | NA|
| [tumorProgression](./obj/tumorProgression.md) | Tumor progression category indicating primary, metastatic or recurrent progression. Ontology value from Neoplasm by Special Category ontology (NCIT:C7062), e.g. NCIT:C84509 (Primary Malignant Neoplasm). | object | [id](./obj/id.md), [label](./obj/label.md) | `[{"id": "NCIT:C84509", "label": "Primary Malignant Neoplasm"}, {"id": "NCIT:C4813", "label": "Recurrent Malignant Neoplasm"}]` | NA|

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

