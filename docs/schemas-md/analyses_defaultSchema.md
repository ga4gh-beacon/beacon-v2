|Term | Description | Type | Properties | Example | Enum|
| ---| ---| ---| ---| ---| --- |
| [aligner](./obj/aligner.md) | Reference to mapping/alignment software | string | NA | bwa-0.7.8 | NA|
| [analysisDate](./obj/analysisDate.md) | Date at which analysis was performed. | string | NA | 2021-10-17 | NA|
| [biosampleId](./obj/biosampleId.md) | Reference to the `id` of the biosample this analysis is reporting on. | string | NA | S0001 | NA|
| [id](./obj/id.md) | Analysis reference ID (external accession or internal ID) | string | NA | NA | NA|
| [individualId](./obj/individualId.md) | Reference to the `id` of the individual this analysis is reporting on. | string | NA | P0001 | NA|
| [info](./obj/info.md) | Placeholder to allow the Beacon to return any additional information that is necessary or could be of interest in relation to the query or the entry returned. It is recommended to encapsulate additional informations in this attribute instead of directly adding attributes at the same level than the others in order to avoid collision in the names of attributes in future versions of the specification. | object | NA | NA | NA|
| [pipelineName](./obj/pipelineName.md) | Analysis pipeline and version if a standardized pipeline was used | string | NA | Pipeline-panel-0001-v1 | NA|
| [pipelineRef](./obj/pipelineRef.md) | Link to Analysis pipeline resource | string | NA | https://doi.org/10.48511/workflowhub.workflow.111.1 | NA|
| [runId](./obj/runId.md) | Run identifier (external accession or internal ID). | string | NA | SRR10903401 | NA|
| [variantCaller](./obj/variantCaller.md) | Reference to variant calling software / pipeline | string | NA | GATK4.0 | NA|

## Examples
These are examples extracted directly from the [GitHub repository](https://github.com/ga4gh-beacon/beacon-v2-Models).

=== "MIN"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "analysisDate": "2021-10-17",
	    "id": "analyses-example-0001",
	    "pipelineName": "Pipeline-panel-0001-v1"
	}
	```

=== "MAX"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "aligner": "bwa-0.7.8",
	    "analysisDate": "2021-10-17",
	    "biosampleId": "S0001",
	    "id": "analyses-example-0001",
	    "individualId": "P0001",
	    "pipelineName": "Pipeline-panel-0001-v1",
	    "pipelineRef": "https://doi.org/10.48511/workflowhub.workflow.111.1",
	    "runId": "SRR10903401",
	    "variantCaller": "GATK4.0"
	}
	```

