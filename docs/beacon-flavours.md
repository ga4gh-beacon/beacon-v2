# Beacon "Flavours"

While the original Beacon v1 only provided Boolean (_i.e._ **YES/NO**) responses
on queries for the existence of specific genomic variants, Beacon v2 is a flexible
protocol that supports differentg usage scenarios - also called "flavours", since
they are more a representation of usage types w/o prescribing their specific details.

Importantly, the Beacon framework separates query options from the response side. In that way
a privacy-protecting[^1] Boolean Beacon still may offer more query features - and therefore better
usability - compared to the first Beacon concept implementations :smile:

For detailed information about the technical implementation of the different logical
scopes please see the [Framework](framework.md) documentation.

## Boolean Response Beacon

A _Boolean_ Beacon is in it's response similar to Beacon v1 - _i.e._ responding
with a _true_ or _false_ value when queried for the existence of some data in a resource.

However, in contrast to earlier versions, in Beacon v1 _in principle_ a "Boolean Beacon"
may implement all types of query options (e.g. combinations of various filters and
genomic query parameters) but still offer a Boolean response, either as sole option or
depending on the user's authentication status.

### Boolean Response

==TBD==

### Beacon Count Response

==TBD==

## Beacons Supporting Data and Information Delivery

==TBD==

### Beacon Data Model

==TBD==

### Alternative Data Models

==TBD==

### Data Handover

==TBD==


[^1]: Privacy protecting as in "reasonably protecting by design but not immune to complex
re-identification attacks".