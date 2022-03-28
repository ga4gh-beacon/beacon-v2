# Formats, Standards and Integrations

## Data Formats and Standards

### Coding and naming conventions

For historical reasons, in the names of entities, parameters and URLs we are following these conventions:

* Entity names: `PascalCase` 
* parameters: `camelCase` 
* URI path elements: `snake_case` 

The only exception is: `service-info` which is a required GA4GH standard and has a different word separation convention.

### Schema Language and Conventions

==TBD: JSON Schema, YAML/JSON and others ...==

### Genome Coordinates

!!! Attention "GA4GH Genome Coordinate Use Recommendation[^1]"

    * We recommends the use of __"0-start, half-open"__ (interbase) coordinate system in all systems
    * __"1-start, fully-closed"__ should be used when displaying coordinates through a GUI or report

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

The GA4GH Variant Representation Standard (VRS) constitutes the reference one should use
when implementing representations of genomic variations. The [current version 1.2](https://vrs.ga4gh.org/en/stable/releases/1.2.html)
has been approved and covers a set of use cases and requirements, especially with respect
to genomic (including cytogenetic or feature based) locations. However, it is not yet
suitable for a number of practical use cases, especially the representation of some structural variations.

The Beacon v2 default model for `GenomicVariation` makes use of the VRS standard to represent
the `variation` part, _i.e._ the location and sequence or copy number changes of the
genomic variation. While a "legacy" alternative is still allowed this one too has been adjusted
to make use of the VRS `Location` format.

#### Examples

The examples are for different forma of the `location` property inside a `genomicVariation`.

=== "Beacon v2 VRS Allele"

    ```json
    "variation": {
        "type": "Allele",
        "state": {
            "sequence": "G",
            "type": "LiteralSequenceExpression"
        },
        "location": {
            "type": "SequenceLocation",
            "sequenceId": "refseq:NC_000017.11",
            "interval": {
                "type": "SequenceInterval",
                "start": {
                    "type": "Number",
                    "value": 7577120
                },
                "end": {
                    "type": "Number",
                    "value": 7577121
                }
            }
        }
    }
    ```

=== "Beacon v2 VRS CNV"

    ```json
    "variation": {
        "type": "RelativeCopyNumber",
        "relativeCopyClass": "partial loss",
        "location": {
            "type": "SequenceLocation",
            "sequenceId": "refseq:NC_000018.10",
            "interval": {
                "start": {
                    "type": "Number",
                    "value": 23029501
                },
                "end": {
                    "type": "Number",
                    "value": 62947165
                }
            }
        }
    }
    ```

=== "Beacon v2 legacy SNV"

    ```json
    "variation": {
        "variantType": "SNP",
        "referenceBases": "C",
        "alternateBases": "G",
        "location": {
            "type": "SequenceLocation",
            "sequenceId": "refseq:NC_000017.11",
            "interval": {
                "type": "SequenceInterval",
                "start": {
                    "type": "Number",
                    "value": 7577120
                },
                "end": {
                    "type": "Number",
                    "value": 7577121
                }
            }
        }
    }
    ```

=== "Beacon v2 legacy CNV"

    ```json
    "variation": {
        "variantType": "DEL",
        "location": {
            "type": "SequenceLocation",
            "sequenceId": "refseq:NC_000018.10",
            "interval": {
                "start": {
                    "type": "Number",
                    "value": 23029501
                },
                "end": {
                    "type": "Number",
                    "value": 62947165
                }
            }
        }
    }
    ```


##### LINK: [VRS Documentation](https://vrs.ga4gh.org/en/stable/)


### Phenopackets

In the Beacon v2 default data model, many schemas are either directly compatible to
[Phenopackets v2 building blocks](https://phenopacket-schema.readthedocs.io/en/latest/building-blocks.html)
or at least reflect them but with some adjustments. While the Beacon v2 default model's schemas do not _per se_ have to reflect
PXF schemas, we target an as-close-as-possible alignment to promote/leverage GA4GH-wide
standardization.

#### Top-level differences

The Phenopackets model is centered around the `Phenopacket`, which is the collector
and integrator of all sub-schemas (with the addition of the external `Family` and
`Cohort` schemas). While `Phenopacket` usually describes information related to a
`subject` -  which is defined in an `Individual` - and the top level elements in
`Phenopacket` relate to a specific `proband` (`measurements` as "Measurements performed
in the proband"), the phenopacket itself does not explicitely _represent_ an individual.

In contrast, the Beacon v2 default model uses a hierarchy in which biosamples
reference individuals directly (if existing). For most purposes one can equate Beacon's
`Individual` with a merge of Phenopacket's core `Phenopacket` and `Individual` parameters. 

==(TBD details/comparisons)==

##### LINK: [Phenopackets Documentation](https://phenopacket-schema.readthedocs.io/en/latest/index.html)

[^1]: Source: [@andrewyatz](https://github.com/@andrewyatz/) at [SchemaBlocks {S}[B]](http://schemablocks.org/standards/genome-coordinates.html)

