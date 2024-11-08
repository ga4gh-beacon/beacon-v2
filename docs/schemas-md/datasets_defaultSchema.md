|Term | Description | Type | Properties | Example | Enum|
| ---| ---| ---| ---| ---| --- |
| [createDateTime](./obj/createDateTime.md) | The time the dataset was created (ISO 8601 format) | string | NA | 2017-01-17T20:33:40Z | NA|
| [dataUseConditions](./obj/dataUseConditions.md) | Data use conditions applying to this dataset. | object | [duoDataUse](./obj/duoDataUse.md) | NA | NA|
| [description](./obj/description.md) | Description of the dataset | string | NA | This dataset provides examples of the actual data in this Beacon instance. | NA|
| [externalUrl](./obj/externalUrl.md) | URL to an external system providing more dataset information (RFC 3986 format). | string | NA | https://example.org/wiki/Main_Page | NA|
| [id](./obj/id.md) | Unique identifier of the dataset | string | NA | ds01010101 | NA|
| [info](./obj/info.md) | Placeholder to allow the Beacon to return any additional information that is necessary or could be of interest in relation to the query or the entry returned. It is recommended to encapsulate additional informations in this attribute instead of directly adding attributes at the same level than the others in order to avoid collision in the names of attributes in future versions of the specification. | object | NA | NA | NA|
| [name](./obj/name.md) | Name of the dataset | string | NA | Dataset with synthetic data | NA|
| [updateDateTime](./obj/updateDateTime.md) | The time the dataset was updated in (ISO 8601 format) | string | NA | 2017-01-17T20:33:40Z | NA|
| [version](./obj/version.md) | Version of the dataset | string | NA | v1.1 | NA|

## Examples
These are examples extracted directly from the [GitHub repository](https://github.com/ga4gh-beacon/beacon-v2-Models).

=== "MAX"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "createDateTime": "2017-01-17T20:33:40Z",
	    "dataUseConditions": {
	        "duoDataUse": [
	            {
	                "id": "DUO:0000007",
	                "label": "disease specific research",
	                "modifiers": [
	                    {
	                        "id": "EFO:0001645",
	                        "label": "coronary artery disease"
	                    }
	                ],
	                "version": "17-07-2016"
	            }
	        ]
	    },
	    "description": "This dataset provides examples of the actual data in this Beacon instance.",
	    "externalUrl": "https://example.org/wiki/Main_Page",
	    "id": "ds01010101",
	    "name": "Dataset with synthetic data",
	    "updateDateTime": "2017-01-17T20:33:40Z",
	    "version": "v1.1"
	}
	```

=== "MIN"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "id": "ds01010101",
	    "name": "Dataset with synthetic data"
	}
	```

