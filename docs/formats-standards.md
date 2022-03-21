# Formats, Standards and Integrations

## Data Formats and Standards

### Coding and naming conventions

For historical reasons, in the names of entities, parameters and URLs we are following these conventions:

* Entity names: `PascalCase` 
* parameters: `camelCase` 
* URI path elements: `snake_case` 

The only exception is: `service-info` which is a required GA4GH standard and has a different word separation convention.

### Schema Language and Conventions

==JSON Schema, YAML/JSON, camelCasing and others ...==

### Genome Coordinates

==0-based interbase etc., see schemablocks.org==

### Dates and Times

<a href="https://xkcd.com/1179/" target="_blank"><img src="https://imgs.xkcd.com/comics/iso_8601.png"  align="right" style="margin 20px 0px 30px 20px; width: 200px; clear:none;" /></a>

Date and time formats are specified as [ISO8601](https://www.w3.org/TR/NOTE-datetime)
compatible strings, both for time points as well as for durations. Some of the ISO8601
compatible formats have not (yet) been used in the Beacon v2 default model.

#### Examples

* time stamp in milliseconds in YYYY-MM-DDTHH:MM:SS.SSS
    - *2015-02-10T00:03:42.123Z*
    	* schema specification in JSON Schema is `"type": "string", format": "date-time"`
    	* Timepoints with millisecond granularity are typical use cases for timing computer generated entries, e.g. the time of a record's update ("updateTime").
* age in years and months in PnYnM
    - *P43Y08M*

##### LINK: W3C [ISO8601](https://www.w3.org/TR/NOTE-datetime)
##### LINK: ISO8601 documentation at [GA4GH SchemaBlocks](https://schemablocks.org/standards/dates-times.html)

## Integration with External Standards

The development of the Beacon v2 framework and default model closely follows
and widely adopts concepts and schemas from approved GA4GH products such as
Phenopackets and the Variant Representation Standard (VRS).

### Variant Representation Standard (VRS)

==(TBD)==

##### LINK: [VRS Documentation](https://vrs.ga4gh.org/en/stable/)

### Phenopackets

==(TBD)==

##### LINK: [Phenopackets Documentation](https://phenopacket-schema.readthedocs.io/en/latest/index.html)

