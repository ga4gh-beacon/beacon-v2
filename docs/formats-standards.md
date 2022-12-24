# Formats, Standards and Integrations

## Data Formats and Standards

### Coding and naming conventions

For historical reasons, in the names of entities, parameters and URLs we are following these conventions:

* Entity names: `PascalCase` 
* parameters: `camelCase` 
* URI path elements: `snake_case` 

The only exception is: `service-info` which is a required GA4GH standard and has a different word separation convention.

### Schema Language and Conventions

The **Beacon v2 API** follows [OpenAPI 3.0.2](https://spec.openapis.org/oas/v3.0.2) specification for the [endpoints](https://github.com/ga4gh-beacon/beacon-v2/blob/main/framework/src/endpoints.yaml), in conjuntion with JSON Schema ([2020-12]( https://json-schema.org/draft/2020-12/schema)) to define the [Framework](framework.md) {{config.repo_framework_icon}} and the [Models](models.md) {{config.repo_models_icon}} components. The specification uses JSON [references](https://json-spec.readthedocs.io/reference.html) (`$ref`) to reference internal (e.g., definitions) or external concepts/terms (e.g., [VRS](https://vrs.ga4gh.org/en/latest/terms_and_model.html)).

The Beacon v2 specification is written in [YAML](https://yaml.org). The original files are located under `src` directory (see below). For technical purposes, we also provide a **copy** of the original YAML in JSON format (see `json` directory below). Changes in the specification must be performed in the YAML version and are then rewritten to the JSON version.

=== "Framework"

        framework
        |-- json
        |   |-- common
        |   |   `-- examples
        |   |-- configuration
        |   |   `-- examples
        |   |-- requests
        |   |   |-- examples-fullDocuments
        |   |   `-- examples-sections
        |   `-- responses
        |       |-- sections
        |       |-- examples-fullDocuments
        |       `-- examples-sections
        `-- src
            |-- common
            |   `-- examples
            |-- configuration
            |   `-- examples
            |-- requests
            |   |-- examples-fullDocuments
            |   `-- examples-sections
            `-- responses
                |-- sections
                |-- examples-fullDocuments
                `-- examples-sections

=== "Models"

        models
        |-- json
        |   `-- beacon-v2-default-model
        |       |-- analyses
        |       |   `-- examples
        |       |-- biosamples
        |       |   `-- examples
        |       |-- cohorts
        |       |   `-- examples
        |       |-- common
        |       |-- datasets
        |       |   `-- examples
        |       |-- genomicVariations
        |       |   `-- examples
        |       |-- individuals
        |       |   `-- examples
        |       `-- runs
        |           `-- examples
        `-- src
            `-- beacon-v2-default-model
                |-- analyses
                |   `-- examples
                |-- biosamples
                |   `-- examples
                |-- cohorts
                |   `-- examples
                |-- common
                |-- datasets
                |   `-- examples
                |-- genomicVariations
                |   `-- examples
                |-- individuals
                |   `-- examples
                `-- runs
                    `-- examples

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
            "sequence_id": "refseq:NC_000017.11",
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
        "relative_copy_class": "partial loss",
        "location": {
            "type": "SequenceLocation",
            "sequence_id": "refseq:NC_000018.10",
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
            "sequence_id": "refseq:NC_000017.11",
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
            "sequence_id": "refseq:NC_000018.10",
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

#### Building block comparisons: Beacon v2 `==` PXF v2

##### `Age`

* [PXF Age](https://phenopacket-schema.readthedocs.io/en/latest/age.html)
* [Beacon v2 Age](https://github.com/ga4gh-beacon/beacon-v2/tree/main/models/src/beacon-v2-default-model/common/age.yaml)

##### `AgeRange`

* [PXF AgeRange](https://phenopacket-schema.readthedocs.io/en/latest/age.html#agerange)
* [Beacon v2 AgeRange](https://github.com/ga4gh-beacon/beacon-v2/tree/main/models/src/beacon-v2-default-model/common/ageRange.yaml)

##### `Evidence`

* [PXF Evidence](https://phenopacket-schema.readthedocs.io/en/latest/evidence.html)
* [Beacon v2 Evidence](https://github.com/ga4gh-beacon/beacon-v2/tree/main/models/src/beacon-v2-default-model/common/evidence.yaml)

##### `KaryotypicSex`

* [PXF](https://github.com/phenopackets/phenopacket-schema/blob/master/docs/karyotypicsex.rst)
* [Beacon](https://github.com/ga4gh-beacon/beacon-v2/tree/main/models/src/beacon-v2-default-model/common/commonDefinitions.yaml)

##### `ReferenceRange`

* [PXF ReferenceRange](https://phenopacket-schema.readthedocs.io/en/latest/reference-range.html)
* [Beacon v2 ReferenceRange](https://github.com/ga4gh-beacon/beacon-v2/tree/main/models/src/beacon-v2-default-model/common/referenceRange.yaml)

While `unit` in Beacon points to a `Unit` definition, this is itself an `OntologyTerm` i.e. structurally the same.

##### `Value`

* [PXF Value](https://phenopacket-schema.readthedocs.io/en/latest/value.html)
* [Beacon v2 Value](https://github.com/ga4gh-beacon/beacon-v2/tree/main/models/src/beacon-v2-default-model/common/value.yaml)



#### Beacon v2 `=~` PXF v2 (e.g. renamed or additional parameters)

##### `ComplexValue `

* [PXF ComplexValue](https://phenopacket-schema.readthedocs.io/en/latest/complex-value.html)
* [Beacon v2 ComplexValue](https://github.com/ga4gh-beacon/beacon-v2/tree/main/models/src/beacon-v2-default-model/common/complexValue.yaml)

Renamed `ComplexValue.TypedQuantity.quantityType` compared to GA4GH Phenopackets v2 `ComplexValue.TypedQuantity.type` due to problematic use of `type` as parameter

##### `ExternalReference`

* [PXF ExternalReference](https://phenopacket-schema.readthedocs.io/en/latest/externalreference.html)
* [Beacon v2 ExternalReference](https://github.com/ga4gh-beacon/beacon-v2/tree/main/models/src/beacon-v2-default-model/common/externalReference.yaml)

Renamed `ExternalReference.notes` compared to GA4GH Phenopackets v2 `ExternalReference.description` due to problematic use of `description` as parameter

##### `Measurement`

* [PXF Measurement](https://phenopacket-schema.readthedocs.io/en/latest/measurement.html)
* [Beacon v2 Measurement](https://github.com/ga4gh-beacon/beacon-v2/tree/main/models/src/beacon-v2-default-model/common/measurement.yaml)

Added `notes` and `date`.

##### `PhenotypicFeature`

* [PXF PhenotypicFeature](https://phenopacket-schema.readthedocs.io/en/latest/phenotype.html)
* [Beacon v2 PhenotypicFeature](https://github.com/ga4gh-beacon/beacon-v2/tree/main/models/src/beacon-v2-default-model/common/phenotypicFeature.yaml)

Beacon | Phenopackets
--------- | ------------
`featureType` | `type`
`severity`  (re-used definition reflecting an ontology term) | `severity` (ontology class)
`notes` | 

##### `Procedure `

* [PXF Procedure](https://phenopacket-schema.readthedocs.io/en/latest/procedure.html)
* [Beacon v2 Procedure](https://github.com/ga4gh-beacon/beacon-v2/tree/main/models/src/beacon-v2-default-model/common/procedure.yaml)

Beacon | Phenopackets
--------- | ------------
`procedureCode` | `code`
`ageAtProcedure`  (TimeElement) | `performed ` (`TimeElement`)
`dateOfProcedure`  (ISO date) | 

##### `TimeElement `

* [PXF TimeElement](https://phenopacket-schema.readthedocs.io/en/latest/time-element.html)
* [Beacon v2 TimeElement](https://github.com/ga4gh-beacon/beacon-v2/tree/main/models/src/beacon-v2-default-model/common/timeElement.yaml)

The specific parameters have been aligned w/ minimal differences in naming or use of general parameters.

| Beacon | Phenopackets
|--------- | ------------
| `ontologyTerm` | `ontology_class `
| `age ` | `age ` (`Age`)
| `ageRange` | `age_range ` (`AgeRange`)
| `gestationalAge`  | `gestational_age ` (`GestationalAge`)
|  `...Timestamp` | `timestamp ` (`TimeStamp`)
|  `timeInterval` | `interval ` (`TimeInterval`)


##### `Treatment `

* [PXF Treatment](https://phenopacket-schema.readthedocs.io/en/latest/treatment.html)
* [Beacon v2 Treatment](https://github.com/ga4gh-beacon/beacon-v2/tree/main/models/src/beacon-v2-default-model/common/treatment.yaml)

Beacon still has an `ageOfOnset` parameter (?). Also, PXF `agent` has been renamed to a more general `treatmentCode`.

#### Beacon v2 `~` PXF v2 (e.g. multiple/complex differences)

##### `Disease`

##### `Pedigree`

While the Beacon & Phenopackets schemas for "pedigree" representation are not aligned, they may become superseded by the [GA4GH pedigree standard](https://github.com/GA4GH-Pedigree-Standard/pedigree) currenty under development.

##### `Sex`

Beacon directly uses the (IMO preferable) [representation through an ontology term](https://github.com/ga4gh-beacon/beacon-v2/tree/main/models/src/beacon-v2-default-model/common/commonDefinitions.yaml), while PXF uses an [ordinal mapping](https://phenopacket-schema.readthedocs.io/en/latest/sex.html)


##### LINK: [Phenopackets Documentation](https://phenopacket-schema.readthedocs.io/en/latest/index.html)

[^1]: Source: [@andrewyatz](https://github.com/@andrewyatz/) at [SchemaBlocks {S}[B]](http://schemablocks.org/standards/genome-coordinates.html)

