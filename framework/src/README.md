# beacon-framework-v2
Beacon Framework version 2

## Introduction
The GA4GH Beacon specification is composed by two parts:

* the Beacon Framework (in *this* repo) 
* the Beacon Model (in the [Models repo](https://github.com/ga4gh-beacon/beacon-v2-Models))

The **Beacon Framework** is the part that describes the overall structure of the API requests, responses, parameters, the common components, etc. It could also be referred in this document as simply the *Framework*.

A **Beacon Model** describes the set of concepts included in a Beacon version (e.g. Beacon v2), like *individual* or *biosample*. It could also be referred in this document as simply the *Model*.

The Framework could be considered the *syntax* and the Model as the *semantics*. 

Refer to the [Models repo](https://github.com/ga4gh-beacon/beacon-v2-Models) for further information about the Model and how to use it.

The Framework doesn't include anything related to specific entities but only the mechanisms for querying them and parsing the responses. 
The BF is, therefore, independent from/agnostic to any specific Model. It can be leveraged to describe models from other domains like proteomics, imaging, biobanking, etc.

A **Beacon instance** is just an implementation of a Beacon Model that follows the rules stated by the Beacon Framework.

If you are a Beacon implementer, then, you don't need to clone this (Framework) repo, you only need to **copy** (*or clone*) the Beacon Model and modify it to your specific instance. You will find plenty of references to the Framework in the Model copy, and you will use the Json schemas in the Framework to validate that both the structure of your requests and responses are compliant with the Beacon Framework. The [Beacon verifier](https://github.com/ga4gh-beacon/beacon-verifier) tool would help in such validation.

The Framework repo includes the elements that are common to all Beacons:

1. The configuration files
2. The Json schemas for the requests, the responses, and its respective sections
3. The files of every Beacon root
4. Examples of all the above (using a fake and simple Model)


### Coding and nanimg conventions
For historical reasons, in the names of entities, parameters and URLs we are following the conventions:
* Entity names: `PascalCase` 
* parameters: `camelCase` 
* URI path elements: `snake_case` 
The only exception is: `service-info` which is a required GA4GH standard and has a different word separation convention.


## Folder structure in this repo
The above listed elements are organized in several folders (*in alphabetical order*):

* **common:** Json schemas and examples of the components used in other parts of the specification.
* **configuration:** Json schemas and examples for the configuration files that every Beacon MUST implement.
* **requests:** Json schemas and examples for the different sections of a request.
* **responses:** Json schemas and examples for the different types of responses and response sections.
* ***root* folder:** It only includes the definition of the Beacon root endpoints.

### The *root* folder and the Beacon root endpoints
The *root* folder only contains the endpoints.json document, an OpenAPI 3.0.2 description of the endpoints that every Beacon instance MUST implement.
The endpoints are:
* the *root* (`/`) and `/info` that MUST return information (metadata) about the Beacon service and the organization supporting it.
* the `/service-info` endpoint that returns the Beacon metadata in the GA4GH Service Info schema.
* the `/configuration` endpoint that returns some configuration aspects and the definition of the entry types (e.g. *genomic variants*, *biosamples*, *cohorts*) implemented in that specific Beacon server or instance.
* the `/entry_types` endpoints that only return the section of the configuration that describes the entry types in that Beacon.
* the `/map` endpoint that returns a map (like a web *sitemap*) of the different endpoints implemented in that Beacon instance.
* the `/filtering_terms` endpoint that returns a list of the filtering terms accepted by that Beacon instance.

Most of these endpoints simply return the configuration files that are in the Beacon configuration folder. Of course, every Beacon instance would have their particular instance of such documents, including the configuration of such instance.

*Note:* It could be argued that the Beacon configuration files are different for every Beacon instance and, hence, they should be part of the Model. However, the configuration files MUST be used, exactly with the same schema, by *any* model, independently if that Beacon follows the Beacon v2 Model or any other. Additionally, these endpoints and configuration files are *critical* for a Beacon client to be able to understand and use a Beacon instance. Therefore, we have considered it to be an essential part of the Framework and belonging to it.

### The Configuration 
Contains the Json schema files that describe the Beacon configuration, its contents are described in the section above, as they have almost a 1-to-1 relationship with such endpoints. Further details about the specific content of each file could be find in the corresponding sections below.

### The Requests 
Contains the following Json schemas:
* **beaconRequestBody.json:** Schema for the whole Beacon request. It is named `RequestBody` to keep the same nomenclature used by OpenAPI v3, but it actually contains the definition of the whole HTTP POST request payload.
* **beaconRequestMeta.json:** Meta section of the Beacon request. It includes request context details relevant for the Beacon server when processing the request, like the Beacon API version used to format the request or the schemas expected for the entry types in the response.
* **filteringTerms.json:** defines the schema for the filters included in the request.
* **requestParameters.json** defines the, very free, schema of the parameters included in the request.
* **examples-fullDocuments folder:** includes examples of "actual" requests. The example labelled with `MIN` in the name shows the minimal required attributes for the request to be compliant. The example labelled with `MAX` in the name includes a richer case with all the sections filled in.
* **examples-sections folder:** includes examples of "actual" sections of the requests. It is included to allow specification designers and Beacon implementers to check the compliance with a single section instead of having to implement a whole request. Such way, We aim to facilitate an "incremental" implementation of an instance.

#### Differences between FilteringTerms and RequestParameters
Both, the filters (*filteringTerms*) and the parameters (*requestParameters*), are used to refine the query. The availability of two mechanisms to refine the queries could sound initially confusing, but that separation is  taylored to facilitate the interpretation of the request by the Beacon server.

An basic difference is that, in HTTP GET requests, each parameters is named (e.g. 'id', 'skip','limit') while filters go under the same named parameter 'filters'. For HTTP POST requests, the difference relays on paramaters having each one a separate definition (e.g. `id` is a `string`, while `skip` is an `integer`), while all filters follow the schema described in `/requests/filteringTerms.json'.

An unrestricted query like `/datasets` should return the list of all datasets in a Beacon instance. That query could be refined by adding a generic condition like: "return only datasets which could be used for 'general research'" or "return only the first 10 datasets". The former belong to the filter category, the latter to the parameters. If you are a beacon implementer, a rule of thumb could be:
* anything that requires its own schema would be a request parameter 
* anything that could be represented by an ontology term would go into the filters section.
* anything else would probably be a request parameter.

### The Responses
The Beacon concept includes several types of responses: some informative or informational and some with actual data payloads, and the error one. 

#### The Informational responses
A Beacon is able to return information, details, about itself. Many of the schema responses included in the `responses` folder have a 1-to-1 relationship with the corresponding configuration documents and their equivalent root endpoints, e.g. the `beaconEntryTypeResponse.json` is the schema of a response that wraps the `beaconConfiguration.json` document, and is then used as the payload of the `/entry_types` root endpoint. Schematically:
* *configuration/an_schema.json*: describes the schema of the configuration file itself.
* *responses/an_schema_response.json*: describes the format of the response that returns these configuration information.
* *root/endpoints.json*: describes the API endpoints to be called and parameters to be used to retrieve such responses.

The following schemas refer to informational responses: *beaconConfigurationResponse*, *beaconEntryTypeResponse*, *beaconFilteringTermsResponse*, ând *beaconMapResponse*.
 
### The results responses
A Beacon could return responses at different granularity levels:

* **boolean response:** only returns `exists: true` ('Yes') or `exists: false` ('No') to a given query.
* **count response:** returns `Yes`/`No` and the number of matching results.
* **resultset response:** returns `Yes`/`No`, the number of matching results and details of them per every collection (e.g. every dataset or cohort) and, if granted, details on every record that matches the query.

Each of these granularity levels has an equivalent response schema: 
* boolean > *beaconBooleanResponse*
* count > *beaconCountResponse*
* resultset (with or w/o record details) > *beaconResultSetsResponse*

An additional schema, *beaconCollectionsResponse*, describes such responses that returns details about the collections in a Beacon, but not the collection content themselves. Otherwise said, the response describes a dataset, but not returns the contents of any dataset.

### The common components
Some elements are transerval to the Framework and to any model, e.g. the schema for describing an ontology term or the reference to an external schema (like the reference to GA4GH Phenopackets or GA4GH Service Info schemas). 

### Testing the compliance of an implementation with *testMode*
Given that the flexibility allowed in the implentation of each Beacon instance, and the security restrictions that could apply (e.g. only answering after authentication of the user), a mechanism is required for allowing testing the compliance of a Beacon. A first step in this compliance testing is done by the implementer by checking that received requests are correct and that the generated responses match the provided schemas. However, an external compliance testing is desirable when the Beacon instance plans to be integrated in a network or to engage in dialogs with a diversity of clients. For this second scenario, the *testMode* parameter was included.
A Beacon instance could receive a request with the *testMode* parameter activated (value= *true*) in which case the Beacon MUST respond, with actual or fake contents, using the response format and skipping any user authentication. The fact that a response has been generated for testing purposes is included in the meta section of the response.

## The Beacon Configuration file
The file `/configuration/beaconConfiguration.json` defines the schema (in Json schema draft-07) of the Json file that includes core aspects of a Beacon instance configuration.
The schema includes four sections:
1. **$schema:** that MUST BE a reference to a schema. In the Models, the instances of that file will point to *this file*. Having the schema allows verifying that the document is compliant with it.
2. **maturityAttributes:** Declares the level of maturity of the Beacon instance. Available values are:
  * **DEV:** Service potentially unstable, not using real data, which availability and data should not be used in production setups.
  * **TEST:** The service is expected to be stable, meaning up and available, but does not include real data to be trusted for real world queries.
  * **PROD:** Service stable, at production level standards, containing actual data.
Except when testing, most of the Beacon queries are expected to be answered by 'PROD' Beacons.

3. **securityAttributes:** Configuration of the security aspects of the Beacon. By default, a Beacon that does not declare the configuration settings would return `boolean` (true/false) responses, and only if the user is authenticated and explicitly authorized to access the Beacon resources. Although this is the safest set of settings, it is not recommended unless the Beacon shares very sensitive information. Non sensitive Beacons should preferably opt for a `record` and `PUBLIC` combination.
  * **defaultGranularity:** Default granularity of the responses. Some responses could return higher detail, but this would be the granularity by default.

  Granularity|Description
  -----------|-----------
  `boolean`|returns 'true/false' responses.
  `count`|adds the total number of positive results found.
  `aggregated`|returns summary, aggregated or distribution like responses per collection. 
  `record`|returns details for every row. 

  For those cases where a Beacon prefers to return records with less, not all, attributes, different strategies have been considered, e.g.: keep non-mandatory attributes empty, or Beacon to provide a minimal record definition, but these strategies still need to be tested in real world cases and hence no design decision has been taken yet.
  * **securityLevels:** All access levels supported by the Beacon. Any combination is valid, as every option would apply to different parts of the Beacon. Available options are:
  
  security level | description
  ---------------|------------
  PUBLIC|Any anonymous user can read the data
  REGISTERED|Only known users can read the data
  CONTROLLED|Only specificly granted users can read the data
  
  #### Example:
  
  ```
  "maturityAttributes": {
    "productionStatus": "DEV"
  },
  "securityAttributes": {
    "defaultGranularity": "boolean",
    "securityLevels": ["PUBLIC", "REGISTERED", "CONTROLLED"]
  }
  ```
  The Beacon in the example is in development status, returns boolean answers by default, and has queries available in any of the access levels.

