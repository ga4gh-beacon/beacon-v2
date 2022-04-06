# Beacon "Flavours"

While the original Beacon v1 only provided Boolean (_i.e._ **YES/NO**) responses
on queries for the existence of specific genomic variants, Beacon v2 is a flexible
protocol that supports different usage scenarios - also called "flavours", since
they are more a representation of usage types w/o prescribing their specific details.

Importantly, the Beacon framework separates query options from the response side. In that way
a privacy-protecting[^1] Boolean Beacon still may offer more query features - and therefore better
usability - compared to the first Beacon concept implementations.

!!! Important "Technical Notes"

	For detailed information about the technical implementation of the different logical
	scopes please see the [Framework](framework.md) documentation.

## Aggregate Response Beacons - Boolean and Count

A _Boolean Response_ Beacon is in it's response similar to Beacon v1 - _i.e._ responding
with a _true_ or _false_ value when queried for the existence of some data in a resource. Similarly
a _Count Response_ Beacon only returns aggregate information, _i.e._ the number of matched
entries (e.g. genomic variants), a feature also part of the Beacon v1 protocol.

However, in contrast to earlier versions, in Beacon v2 _in principle_ a beaconized resource
may implement all types of query options (e.g. combinations of various filters and
genomic query parameters) but still only offer a Boolean and optionally Count response.

Also, all Beacons _should_ implement the _Boolean Response_ format as fallback option and
handle extended options depending on the user's authentication status.

=== "Boolean Response in v2"

	```json
	{
	  "meta": {
	    "apiVersion": "v2.0.0",
	    "__other_meta_parameters__": "..."
	    "receivedRequestSummary": {
	      "requestedGranularity": "boolean",
	      "__other_request_parameters__": "..."
	    },
	    "returnedGranularity": "boolean"
	   },
	  "responseSummary": {
	    "exists": true
	  }
	}
	```

=== "Count Response in v2"

	```json
	{
	  "meta": {
	    "apiVersion": "v2.0.0",
	    "__other_meta_parameters__": "..."
	    "receivedRequestSummary": {
	      "requestedGranularity": "count",
	      "__other_request_parameters__": "..."
	    },
	    "returnedGranularity": "count"
	   },
	  "responseSummary": {
	    "exists": true,
	    "numTotalResults": 42
	  }
	}
	```

## Beacons Supporting Data and Information Delivery

!!! Important "Technical Notes"

	For detailed information about the technical implementation of the different logical
	scopes please see the [Models](models.md) documentation.

==TBD==

### Beacon Data Model

==TBD==

### Alternative Data Models

==TBD==

### [H—>O] Beacon Handovers for Data Delivery

While the Beacon v1 response was restricted to aggregate data and Beacon v2 itself provides
schemas for structuring response objects (e.g. henomic variation  or biosample data) 
the protocol can be expanded by providing custom access methods to data elements
matched by a Beacon query. Since November 2018, Beacon v1.n has included support for a "handover" protocol,
in which rich data content can be provided from linked services, initiated through a Beacon query[^2].

Typical examples of `Handover` use include:

* access to restricted data, in which a handover URL points to data behind an authentication service
or Firewall
* delivery of large/binary datasets, e.g. original array data or BAM files for a guiven analysis
* asynchronous calls in which a front-end follows handover URLs for additional data



[^1]: Privacy protecting as in "reasonably protecting by design but not immune to complex
re-identification attacks".

[^2]: An early discussion of the topic can e.g. be found in the Beacon developer area on [Github](https://github.com/ga4gh-beacon/specification/issues/114). As of 2018-11-13, the __handover__ concept had become part of the [code development](https://github.com/ga4gh-beacon/specification/pull/230/files).

