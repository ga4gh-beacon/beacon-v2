## Change log for beacon-framework-v2
This document is planned as a manually maintained list of changes to the Beacon Framework version 2 repo.
It should only include changes that affect or could affect implementations, and the log would be updated *after* the corresponding pull request is approved and merged.

#### nextPage navigation - *2021/12/14*
[PR #64](https://github.com/ga4gh-beacon/beacon-framework-v2/pull/64) - 
Adding pagination by page tokens. Previous, current and nextpage tokens are part of pagination in addition to *skip* and *limit*.

#### testMode - *2021/11/19*
[PR #68](https://github.com/ga4gh-beacon/beacon-framework-v2/pull/68) - 
Given that the flexibility allowed in the implentation of each Beacon instance, and the security restrictions that could apply (e.g. only answering after authentication of the user), a mechanism is required for allowing testing the compliance of a Beacon. A first step in this compliance testing is done by the implementer by checking that received requests are correct and that the generated responses match the provided schemas. However, an external compliance testing is desirable when the Beacon instance plans to be integrated in a network or to engage in dialogs with a diversity of clients. For this second scenario, the *testMode* parameter was included.
A Beacon instance could receive a request with the *testMode* parameter activated (value= *true*) in which case the Beacon MUST respond, with actual or fake contents, using the response format and skipping any user authentication. The fact that a response has been generated for testing purposes is included in the meta section of the response.


#### nonFilteredQueriesAllowed - *2021/11/18*
[PR #66](https://github.com/ga4gh-beacon/beacon-framework-v2/pull/66) - 
Adding an optional element both to entryType & configuration for declaring if queries without any filter are allowed. Default value is *true*

#### making *numTotalResults* mandatory for count responses - *2021/11/03*
[PR #62](https://github.com/ga4gh-beacon/beacon-framework-v2/pull/62)

#### Adding declarative granularity in req and response - *2021/10/30*
[PR #59](https://github.com/ga4gh-beacon/beacon-framework-v2/pull/59) - 
Declarative granularity added to request (*requestBody*) and response (*receivedRequestSummary* and *responseMeta*).
The granularity is now a common element and is referenced from requestBody and in receivedRequestSummary and responseMeta.
It is mandatory in *receivedRequestSummary* and *responseMeta*, as they are informative similarly to pagination and other elements.
Current validations for requests and responses will fail.
