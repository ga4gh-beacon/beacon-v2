|Term | Description | Type | Properties | Example | Enum|
| ---| ---| ---| ---| ---| --- |
| aliases | Human-readable names or symbols commonly used for this feature (gene symbols, transcript names, or other aliases). | array | NA | TP53, BRCA1 | NA|
| biotype | Gene or transcript biotype from Sequence Ontology (e.g. protein_coding_gene). Not the same as featureType (structural class such as gene, mRNA, or exon). Prefer SO CURIEs over annotation-catalog strings such as Ensembl "protein_coding". | object | NA | `[{"id": "SO:0001217", "label": "protein_coding_gene"}, {"id": "SO:0002127", "label": "lncRNA_gene"}, {"id": "SO:0000336", "label": "pseudogene"}]` | NA|
| featureIdentifier | Identifier of the genomic feature as it appears in the expression matrix (native accession), plus the identifier namespace. Gene symbols MUST NOT be stored here; use aliases instead. Annotation release (e.g. Ensembl 109) belongs on the matrix annotation, not on this object. | object | id, resource | `[{"id": "ENSG00000141510.18", "resource": "ensembl"}, {"id": "ENST00000269305.9", "resource": "ensembl"}, {"id": "EXON:00004567", "resource": "local"}]` | NA|
| featureType | Ontology term that describes the type of genomic feature. Values from SO (Sequence Ontology) are recommended. | object | NA | `[{"id": "SO:0000704", "label": "gene"}, {"id": "SO:0000234", "label": "mRNA"}, {"id": "SO:0000147", "label": "exon"}]` | NA|
| genomicInterval | Genomic interval of the genomic feature, uses the VRS schema for the coordinates and adds the strand | object | location, strand | NA | NA|
| id | Internal feature ID. | string | NA | Feature12345 | NA|
| info | NA | object | NA | NA | NA|
| matrixIds | list of matrix ids | array | NA | NA | NA|
| ontologyTerms | Ontology terms for biological functions, molecular effects, and similar annotations (e.g. GO). Biotype MUST use biotype, not this array. | array | NA | `[{"id": "GO:0048856", "label": "anatomical structure development"}]` | NA|
| relationship | Hierarchical relationships of the genomic feature (gene -> transcript -> exon). parent and children MUST use the same native id form as featureIdentifier.id (not CURIEs). | object | children, parent | NA | NA|
| xrefs | Cross-references of the genomic feature. CURIE format is recommended. | array | NA | HGNC:11998, NCBIGene:7157 | NA|

## Examples
These are examples extracted directly from the [GitHub repository](https://github.com/ga4gh-beacon/beacon-v2).

=== "exon-MAX"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "id": "InternalId12345",
	    "featureIdentifier": {
	        "id": "EXON:00004567",
	        "resource": "local"
	    },
	    "genomicInterval": {
	        "location": {
	            "interval": {
	                "end": {
	                    "type": "Number",
	                    "value": 7668421
	                },
	                "start": {
	                    "type": "Number",
	                    "value": 7668534
	                },
	                "type": "SequenceInterval"
	            },
	            "sequence_id": "INSDC:CM000669.2",
	            "type": "SequenceLocation"
	        },
	        "strand": "negative"
	    },
	    "featureType": {
	        "id": "SO:0000147",
	        "label": "exon"
	    },
	    "relationship": {
	        "parent": "ENST00000269305.9"
	    },
	    "matrixIds": [
	        "matrix-gene-expression-001",
	        "matrix-protein-interaction-002",
	        "matrix-variant-frequency-003"
	    ]
	}
	```

=== "exon-MIN"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "id": "InternalId12345",
	    "featureIdentifier": {
	        "id": "EXON:00004567",
	        "resource": "local"
	    },
	    "featureType": {
	        "id": "SO:0000147",
	        "label": "exon"
	    },
	    "matrixIds": [
	        "matrix-gene-expression-001",
	        "matrix-protein-interaction-002",
	        "matrix-variant-frequency-003"
	    ]
	}
	```

=== "gene-MAX"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "id": "InternalId12345",
	    "featureIdentifier": {
	        "id": "ENSG00000141510.18",
	        "resource": "ensembl"
	    },
	    "genomicInterval": {
	        "location": {
	            "interval": {
	                "end": {
	                    "type": "Number",
	                    "value": 7661779
	                },
	                "start": {
	                    "type": "Number",
	                    "value": 7687546
	                },
	                "type": "SequenceInterval"
	            },
	            "sequence_id": "INSDC:CM000669.2",
	            "type": "SequenceLocation"
	        },
	        "strand": "negative"
	    },
	    "aliases": [
	        "TP53",
	        "p53",
	        "LFS1",
	        "TRP53",
	        "P53"
	    ],
	    "featureType": {
	        "id": "SO:0000704",
	        "label": "gene"
	    },
	    "biotype": {
	        "id": "SO:0001217",
	        "label": "protein_coding_gene"
	    },
	    "ontologyTerms": [
	        {
	            "id": "GO:0006915",
	            "label": "apoptotic process"
	        },
	        {
	            "id": "GO:0006281",
	            "label": "DNA repair"
	        },
	        {
	            "id": "GO:0006974",
	            "label": "DNA damage response"
	        },
	        {
	            "id": "GO:0007049",
	            "label": "cell cycle"
	        }
	    ],
	    "xrefs": [
	        "HGNC:11998",
	        "NCBIGene:7157"
	    ],
	    "relationship": {
	        "children": [
	            "ENST00000269305.9",
	            "ENST00000445888.6",
	            "ENST00000503591.2",
	            "ENST00000508793.6",
	            "ENST00000604348.6",
	            "ENST00000620739.4",
	            "ENST00000610292.4",
	            "ENST00000619485.4",
	            "ENST00000455263.6",
	            "ENST00000359597.8",
	            "ENST00000420246.6",
	            "ENST00000610538.4",
	            "ENST00000622645.4",
	            "ENST00000514944.6",
	            "ENST00000413465.6",
	            "ENST00000509690.6",
	            "ENST00000504937.5",
	            "ENST00000619186.4",
	            "ENST00000504290.5",
	            "ENST00000510385.5",
	            "ENST00000610623.4",
	            "ENST00000618944.4",
	            "ENST00000576024.1",
	            "ENST00000635293.1",
	            "ENST00000505014.5",
	            "ENST00000571370.2",
	            "ENST00000574684.1"
	        ]
	    },
	    "matrixIds": [
	        "matrix-gene-expression-001",
	        "matrix-protein-interaction-002",
	        "matrix-variant-frequency-003"
	    ]
	}
	```

=== "gene-MIN"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "id": "InternalId12345",
	    "featureIdentifier": {
	        "id": "ENSG00000141510.18",
	        "resource": "ensembl"
	    },
	    "featureType": {
	        "id": "SO:0000704",
	        "label": "gene"
	    },
	    "matrixIds": [
	        "matrix12345",
	        "matrix67890"
	    ]
	}
	```

=== "transcript-MAX"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "id": "InternalId12345",
	    "featureIdentifier": {
	        "id": "ENST00000269305.9",
	        "resource": "ensembl"
	    },
	    "genomicInterval": {
	        "location": {
	            "interval": {
	                "end": {
	                    "type": "Number",
	                    "value": 7668421
	                },
	                "start": {
	                    "type": "Number",
	                    "value": 7687490
	                },
	                "type": "SequenceInterval"
	            },
	            "sequence_id": "INSDC:CM000669.2",
	            "type": "SequenceLocation"
	        },
	        "strand": "negative"
	    },
	    "featureType": {
	        "id": "SO:0000234",
	        "label": "mRNA"
	    },
	    "biotype": {
	        "id": "SO:0001217",
	        "label": "protein_coding_gene"
	    },
	    "ontologyTerms": [
	        {
	            "id": "GO:0006915",
	            "label": "apoptotic process"
	        },
	        {
	            "id": "GO:0006281",
	            "label": "DNA repair"
	        },
	        {
	            "id": "GO:0006974",
	            "label": "DNA damage response"
	        },
	        {
	            "id": "GO:0007049",
	            "label": "cell cycle"
	        }
	    ],
	    "xrefs": [
	        "NCBI_RefSeq:NM_000546.6"
	    ],
	    "relationship": {
	        "parent": "ENSG00000141510.18"
	    },
	    "matrixIds": [
	        "matrix-gene-expression-001",
	        "matrix-protein-interaction-002",
	        "matrix-variant-frequency-003"
	    ]
	}
	```

=== "transcript-MIN"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "id": "InternalId12345",
	    "featureIdentifier": {
	        "id": "ENST00000269305.9",
	        "resource": "ensembl"
	    },
	    "featureType": {
	        "id": "SO:0000234",
	        "label": "mRNA"
	    },
	    "relationship": {
	        "parent": "ENSG00000141510.18"
	    },
	    "matrixIds": [
	        "matrix-gene-expression-001",
	        "matrix-protein-interaction-002",
	        "matrix-variant-frequency-003"
	    ]
	}
	```

