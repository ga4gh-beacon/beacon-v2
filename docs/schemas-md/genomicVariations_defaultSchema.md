|Term | Description | Type | Properties | Example | Enum|
| ---| ---| ---| ---| ---| --- |
| [caseLevelData](./obj/caseLevelData.md) | caseLevelData reports about the variation instances observed in individual analyses. | array | [alleleOrigin](./obj/alleleOrigin.md), [analysisId](./obj/analysisId.md), [biosampleId](./obj/biosampleId.md), [clinicalInterpretations](./obj/clinicalInterpretations.md), [id](./obj/id.md), [individualId](./obj/individualId.md), [phenotypicEffects](./obj/phenotypicEffects.md), [runId](./obj/runId.md), [zygosity](./obj/zygosity.md) | NA | NA|
| [frequencyInPopulations](./obj/frequencyInPopulations.md) | NA | array | [frequencies](./obj/frequencies.md), [source](./obj/source.md), [sourceReference](./obj/sourceReference.md), [version](./obj/version.md) | NA | NA|
| [identifiers](./obj/identifiers.md) | NA | object | [clinvarVariantId](./obj/clinvarVariantId.md), [genomicHGVSId](./obj/genomicHGVSId.md), [proteinHGVSIds](./obj/proteinHGVSIds.md), [transcriptHGVSIds](./obj/transcriptHGVSIds.md), [variantAlternativeIds](./obj/variantAlternativeIds.md) | NA | NA|
| [molecularAttributes](./obj/molecularAttributes.md) | NA | object | [aminoacidChanges](./obj/aminoacidChanges.md), [geneIds](./obj/geneIds.md), [genomicFeatures](./obj/genomicFeatures.md), [molecularEffects](./obj/molecularEffects.md) | NA | NA|
| [variantInternalId](./obj/variantInternalId.md) | Reference to the **internal** variant ID. This represents the primary key/identifier of that variant **inside** a given Beacon instance. Different Beacon instances may use identical id values, referring to unrelated variants. Public identifiers such as the GA4GH Variant Representation Id (VRSid) MUST be returned in the `identifiers` section. A Beacon instance can, of course, use the VRSid as their own internal id but still MUST represent this then in the `identifiers` section. | string | NA | var00001, v110112 | NA|
| [variantLevelData](./obj/variantLevelData.md) | NA | object | [clinicalInterpretations](./obj/clinicalInterpretations.md), [phenotypicEffects](./obj/phenotypicEffects.md) | NA | NA|
| [variation](./obj/variation.md) | NA | oneOf | [LegacyVariation](./obj/LegacyVariation.md), [MolecularVariation](./obj/MolecularVariation.md), [SystemicVariation](./obj/SystemicVariation.md) | NA | NA|

## Examples
These are examples extracted directly from the [GitHub repository](https://github.com/ga4gh-beacon/beacon-v2-Models).

=== "MIN"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "variantInternalId": "GRCh37-1-55505652-G-A",
	    "variation": {
	        "alternateBases": "A",
	        "location": {
	            "interval": {
	                "end": {
	                    "type": "Number",
	                    "value": 5505653
	                },
	                "start": {
	                    "type": "Number",
	                    "value": 5505652
	                },
	                "type": "SequenceInterval"
	            },
	            "sequence_id": "refseq:NC_000001.10",
	            "type": "SequenceLocation"
	        },
	        "variantType": "SNP"
	    }
	}
	```

=== "MIN"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "variantInternalId": "GRCh37-1-55505652-G-A",
	    "variation": {
	        "location": {
	            "interval": {
	                "end": {
	                    "type": "Number",
	                    "value": 5505653
	                },
	                "start": {
	                    "type": "Number",
	                    "value": 5505652
	                },
	                "type": "SequenceInterval"
	            },
	            "sequence_id": "refseq:NC_000001.10",
	            "type": "SequenceLocation"
	        },
	        "state": {
	            "sequence": "A",
	            "type": "SequenceState"
	        },
	        "type": "Allele"
	    }
	}
	```

=== "MID"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "frequencyInPopulations": [
	        {
	            "frequencies": [
	                {
	                    "alleleFrequency": 2.939e-05,
	                    "population": "European (non-Finish)"
	                },
	                {
	                    "alleleFrequency": 0,
	                    "population": "Other"
	                }
	            ],
	            "source": "gnomaD Genomes",
	            "sourceReference": "https://gnomad.broadinstitute.org/",
	            "version": "v3.1.1"
	        },
	        {
	            "frequencies": [
	                {
	                    "alleleFrequency": 9e-05,
	                    "population": "Total"
	                },
	                {
	                    "alleleFrequency": 6e-05,
	                    "population": "European"
	                },
	                {
	                    "alleleFrequency": 0,
	                    "population": "African"
	                }
	            ],
	            "source": "ALFA",
	            "sourceReference": "https://www.ncbi.nlm.nih.gov/snp/docs/gsr/alfa/",
	            "version": "20201027095038"
	        }
	    ],
	    "identifiers": {
	        "clinVarIds": [
	            "434136",
	            "VCV000440707.6"
	        ],
	        "genomicHGVSId": "NC_000001.11:g.55039979G>A",
	        "proteinHGVSIds": [
	            "NP_777596.2:p.Glu48Lys"
	        ],
	        "transcriptHGVSIds": [
	            "NM_174936.4:c.142G>A"
	        ],
	        "variantAlternativeIds": [
	            "dbSNP:rs3975092470",
	            "ClinGen: CA340482854"
	        ]
	    },
	    "molecularAttributes": {
	        "aminoacidChanges": [
	            "E48K"
	        ],
	        "geneIds": [
	            "PCSK9",
	            "LRG_275"
	        ],
	        "molecularEffects": [
	            {
	                "id": "ENSGLOSSARY:0000150",
	                "label": "Missense variant"
	            }
	        ]
	    },
	    "variantInternalId": "var123",
	    "variantLevelData": {
	        "clinicalInterpretations": [
	            {
	                "category": {
	                    "id": "MONDO:0000001",
	                    "label": "disease or disorder"
	                },
	                "clinicalRelevance": "pathogenic",
	                "conditionId": "famchol1",
	                "effect": {
	                    "id": "MONDO:0007750",
	                    "label": "Familial hypercholesterolemia 1"
	                }
	            },
	            {
	                "category": {
	                    "id": "MONDO:0000001",
	                    "label": "disease or disorder"
	                },
	                "clinicalRelevance": "uncertain significance",
	                "conditionId": "famchol3",
	                "effect": {
	                    "id": "MONDO:0011369",
	                    "label": "hypercholesterolemia, autosomal dominant, 3"
	                }
	            }
	        ]
	    },
	    "variation": {
	        "alternateBases": "A",
	        "location": {
	            "interval": {
	                "end": {
	                    "type": "Number",
	                    "value": 55039980
	                },
	                "start": {
	                    "type": "Number",
	                    "value": 55039979
	                },
	                "type": "SequenceInterval"
	            },
	            "sequence_id": "refseq:NC_000001.11",
	            "type": "SequenceLocation"
	        },
	        "referenceBases": "G",
	        "variantType": "SNP"
	    }
	}
	```

