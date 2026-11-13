|Term | Description | Type | Properties | Example | Enum|
| ---| ---| ---| ---| ---| --- |
| annotation | Annotation catalog used to define feature identifiers in this matrix. source SHOULD use the same identifiers.org-style prefix vocabulary as featureIdentifier.resource (e.g. ensembl, gencode). version is the annotation release; it is not the same as an Ensembl object version suffix (e.g. .18). | object | file, md5Checksum, source, version | NA | NA|
| assayType | Type of RNA-seq assay (e.g. bulk vs single-cell). | object | NA | `[{"id": "OBI:0002631", "label": "single-cell RNA sequencing assay"}, {"id": "OBI:0003090", "label": "bulk RNA-seq assay"}]` | NA|
| assembly | Reference genome assembly used to map reads and define genomic coordinates for features in this matrix. | object | accession, name | `[{"accession": "GCA_000001405.29", "name": "GRCh38.p14"}]` | NA|
| biosampleTypes | Ontology terms for tissue, cell type, or cell line present on biosample columns of this matrix. Prefer UBERON for anatomical tissue, CL for cell type, and CLO or BTO for cell lines. Each listed term MUST appear on a linked biosample (e.g. sampleOriginDetail). Distinct from assayType. | array | NA | `[[{"id": "UBERON:0002190", "label": "subcutaneous adipose tissue"}], [{"id": "UBERON:0000964", "label": "cornea"}, {"id": "UBERON:0001777", "label": "sclera"}], [{"id": "CL:0000236", "label": "B cell"}]]` | NA|
| biotypes | Sequence Ontology biotypes present on genomic feature rows of this matrix (e.g. protein_coding_gene, lncRNA_gene). Distinct from featureTypes (structural class). Each listed term MUST appear as some feature's biotype in this matrix. Values from SO (Sequence Ontology) are recommended. | array | NA | `[[{"id": "SO:0001217", "label": "protein_coding_gene"}], [{"id": "SO:0001217", "label": "protein_coding_gene"}, {"id": "SO:0002127", "label": "lncRNA_gene"}]]` | NA|
| createDateTime | The time the matrix was created (ISO 8601 format). | string | NA | 2017-01-17T20:33:40Z | NA|
| description | Description of the matrix. | string | NA | This matrix provides examples of the actual data in this Beacon instance. | NA|
| dimensions | Number of features (rows) and biosamples (columns) in the matrix. | object | biosamples, features | NA | NA|
| downloadUrl | Optional URL to download the full matrix (RFC 3986). Bulk download is not required when sliced expression values are served via the API. | string | NA | https://example.org/matrices/matrix.csv | NA|
| expressionUnitAndScale | Unit and numeric scale of expression values in this matrix. Applies to all expressionValue.value entries that reference this matrix id. | object | scale, unit | NA | NA|
| expressionValueRange | Global minimum and maximum of expressionValue.value across this matrix. Uses the same unit and scale as expressionUnitAndScale. | object | max, min | NA | NA|
| featureTypes | Sequence Ontology terms for the class(es) of genomic feature rows in this matrix. Homogeneous matrices list one term (e.g. gene or mRNA). Matrices that mix genes and transcripts (or other feature classes) MUST list every class present. Each feature in the matrix MUST have a featureType that appears in this array. Values from SO (Sequence Ontology) are recommended. | array | NA | `[[{"id": "SO:0000704", "label": "gene"}], [{"id": "SO:0000234", "label": "mRNA"}], [{"id": "SO:0000704", "label": "gene"}, {"id": "SO:0000234", "label": "mRNA"}]]` | NA|
| id | Unique identifier of the matrix entry within the Beacon. Referenced as matrixId by expressionValue entries. | string | NA | matrix-gene-expression-001 | NA|
| info | NA | object | NA | NA | NA|
| name | Human-readable name of the matrix. | string | NA | Gene expression matrix | NA|
| reproducible | Whether this Beacon provides enough provenance to regenerate the quantification matrix (annotation source, version and file, assembly, units/scale, and analysis/protocol information). true means that information is available; false means provenance is incomplete and the matrix should not be treated as independently reproducible from Beacon metadata alone. | boolean | NA | True, False | NA|
| source | Origin of the matrix data, i.e. the resource or pipeline the quantification was obtained from. | string | NA | encode, geo, gtex | NA|

## Examples
These are examples extracted directly from the [GitHub repository](https://github.com/ga4gh-beacon/beacon-v2).

=== "encode-MAX"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "annotation": {
	        "file": "https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_24/gencode.v24.annotation.gtf.gz",
	        "md5Checksum": "1bc16dd541cb93a35b821a0587306b30",
	        "source": "gencode",
	        "version": "v24"
	    },
	    "assayType": {
	        "id": "OBI:0003090",
	        "label": "bulk RNA-seq assay"
	    },
	    "assembly": {
	        "accession": "GCA_000001405.15",
	        "name": "GRCh38"
	    },
	    "biosampleTypes": [
	        {
	            "id": "EFO:0030018",
	            "label": "BLaER1"
	        }
	    ],
	    "biotypes": [
	        {
	            "id": "SO:0001217",
	            "label": "protein_coding_gene"
	        }
	    ],
	    "createDateTime": "2026-11-03T09:58:17Z",
	    "description": "Poly A+ RNA-Seq from the cytosolic compartment of untreated BLaER1 cells (Roderic Guigo, CRG). Gene quantifications from ENCFF144BAP (biological replicate 1), GRCh38 / GENCODE V24. Full ENSG set is imported by default.",
	    "dimensions": {
	        "biosamples": 1,
	        "features": 50701
	    },
	    "downloadUrl": "https://www.encodeproject.org/files/ENCFF144BAP/@@download/ENCFF144BAP.tsv",
	    "expressionUnitAndScale": {
	        "scale": "linear",
	        "unit": "TPM"
	    },
	    "expressionValueRange": {
	        "max": 17895.34,
	        "min": 0.0
	    },
	    "featureTypes": [
	        {
	            "id": "SO:0000704",
	            "label": "gene"
	        }
	    ],
	    "id": "ENCSR622FSM",
	    "info": {
	        "encodeFile": "ENCFF144BAP",
	        "format": "encode_rsem_gene_quantifications",
	        "lab": "Roderic Guigo, CRG",
	        "quantFileMd5": "6bcdf429f1361e520cfc06bb1431a0dc",
	        "source": "encode"
	    },
	    "name": "ENCODE Guigo lab BLaER1 cytosolic polyA+ RNA-seq (ENCSR622FSM)",
	    "reproducible": true,
	    "source": "encode"
	}
	```

=== "encode-MIN"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "annotation": {
	        "source": "gencode",
	        "version": "v24"
	    },
	    "assembly": {
	        "accession": "GCA_000001405.15",
	        "name": "GRCh38"
	    },
	    "expressionUnitAndScale": {
	        "scale": "linear",
	        "unit": "TPM"
	    },
	    "featureTypes": [
	        {
	            "id": "SO:0000704",
	            "label": "gene"
	        }
	    ],
	    "id": "ENCSR622FSM",
	    "reproducible": true
	}
	```

=== "geo-MAX"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "annotation": {
	        "file": "https://ftp.ncbi.nlm.nih.gov/genomes/all/annotation_releases/9606/109.20190905/GCF_000001405.39_GRCh38.p13/GCF_000001405.39_GRCh38.p13_genomic.gff.gz",
	        "md5Checksum": "b953137952fad635e668e9b12905a06b",
	        "source": "ncbigene",
	        "version": "109.20190905"
	    },
	    "assayType": {
	        "id": "OBI:0003090",
	        "label": "bulk RNA-seq assay"
	    },
	    "assembly": {
	        "accession": "GCA_000001405.15",
	        "name": "GRCh38.p13"
	    },
	    "biosampleTypes": [
	        {
	            "id": "UBERON:0000964",
	            "label": "cornea"
	        },
	        {
	            "id": "UBERON:0006761",
	            "label": "corneal limbus"
	        },
	        {
	            "id": "UBERON:0001777",
	            "label": "sclera"
	        }
	    ],
	    "biotypes": [
	        {
	            "id": "SO:0001217",
	            "label": "protein_coding_gene"
	        },
	        {
	            "id": "SO:0000336",
	            "label": "pseudogene"
	        }
	    ],
	    "createDateTime": "2026-11-03T09:58:21Z",
	    "description": "NCBI-generated RNA-seq TPM counts for GSE164073 (transcriptional response to SARS-CoV-2 in cornea, limbus and sclera from human donors). Counts come from NCBI's standardized HISAT2 + featureCounts pipeline on GRCh38.p13 (Annotation Release 109.20190905) \u2014 reproducible across GEO human RNA-seq series. Full GeneID \u00d7 GSM matrix is imported by default (~39k genes \u00d7 18 samples).",
	    "dimensions": {
	        "biosamples": 18,
	        "features": 39376
	    },
	    "downloadUrl": "https://www.ncbi.nlm.nih.gov/geo/download/?type=rnaseq_counts&acc=GSE164073&format=file&file=GSE164073_norm_counts_TPM_GRCh38.p13_NCBI.tsv.gz",
	    "expressionUnitAndScale": {
	        "scale": "linear",
	        "unit": "TPM"
	    },
	    "expressionValueRange": {
	        "max": 24650.0,
	        "min": 0.0
	    },
	    "featureTypes": [
	        {
	            "id": "SO:0000336",
	            "label": "pseudogene"
	        },
	        {
	            "id": "SO:0000704",
	            "label": "gene"
	        }
	    ],
	    "id": "GSE164073",
	    "info": {
	        "format": "geo_ncbi_rnaseq_counts",
	        "geoAccession": "GSE164073",
	        "pipeline": "NCBI GEO RNA-seq counts (HISAT2 + featureCounts, GRCh38.p13)",
	        "seriesDesign": "Cornea, limbus and sclera isolated from human donor tissue; infected with SARS-CoV-2 for 24 hours in triplicate vs mock-infected controls.",
	        "source": "geo"
	    },
	    "name": "GEO GSE164073 NCBI TPM (cornea / limbus / sclera \u00b1 SARS-CoV-2)",
	    "reproducible": true,
	    "source": "geo"
	}
	```

=== "geo-MIN"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "annotation": {
	        "source": "ncbigene",
	        "version": "109.20190905"
	    },
	    "assembly": {
	        "accession": "GCA_000001405.15",
	        "name": "GRCh38.p13"
	    },
	    "expressionUnitAndScale": {
	        "scale": "linear",
	        "unit": "TPM"
	    },
	    "featureTypes": [
	        {
	            "id": "SO:0000336",
	            "label": "pseudogene"
	        },
	        {
	            "id": "SO:0000704",
	            "label": "gene"
	        }
	    ],
	    "id": "GSE164073",
	    "reproducible": true
	}
	```

=== "gtex-MAX"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "annotation": {
	        "file": "https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_26/gencode.v26.annotation.gtf.gz",
	        "md5Checksum": "3cfe0c4c63a51a31034accf262cbb76b",
	        "source": "gencode",
	        "version": "v26"
	    },
	    "assayType": {
	        "id": "OBI:0003090",
	        "label": "bulk RNA-seq assay"
	    },
	    "assembly": {
	        "accession": "GCA_000001405.15",
	        "name": "GRCh38"
	    },
	    "biosampleTypes": [
	        {
	            "id": "UBERON:0002190",
	            "label": "Adipose - Subcutaneous"
	        }
	    ],
	    "biotypes": [
	        {
	            "id": "SO:0001217",
	            "label": "protein_coding_gene"
	        }
	    ],
	    "createDateTime": "2026-11-03T10:00:37Z",
	    "description": "GTEx Analysis v8 gene-level TPM matrix for Adipose - Subcutaneous samples. GCT format (#1.3): id, Name (ENSG), Description (symbol), then one column per sample. Full tissue matrix is imported by default (~56k genes \u00d7 ~663 samples).",
	    "dimensions": {
	        "biosamples": 663,
	        "features": 56200
	    },
	    "downloadUrl": "https://storage.googleapis.com/adult-gtex/bulk-gex/v8/rna-seq/tpms-by-tissue/gene_tpm_2017-06-05_v8_adipose_subcutaneous.gct.gz",
	    "expressionUnitAndScale": {
	        "scale": "linear",
	        "unit": "TPM"
	    },
	    "expressionValueRange": {
	        "max": 86050.0,
	        "min": 0.0
	    },
	    "featureTypes": [
	        {
	            "id": "SO:0000704",
	            "label": "gene"
	        }
	    ],
	    "id": "GTEx-v8-Adipose-Subcutaneous",
	    "info": {
	        "format": "gtex_gct",
	        "source": "gtex",
	        "tissue": {
	            "id": "UBERON:0002190",
	            "label": "Adipose - Subcutaneous"
	        }
	    },
	    "name": "GTEx v8 Adipose - Subcutaneous gene TPM",
	    "reproducible": true,
	    "source": "gtex"
	}
	```

=== "gtex-MIN"
	```json
	{
	    "$schema": "https://json-schema.org/draft/2020-12/schema",
	    "annotation": {
	        "source": "gencode",
	        "version": "v26"
	    },
	    "assembly": {
	        "accession": "GCA_000001405.15",
	        "name": "GRCh38"
	    },
	    "expressionUnitAndScale": {
	        "scale": "linear",
	        "unit": "TPM"
	    },
	    "featureTypes": [
	        {
	            "id": "SO:0000704",
	            "label": "gene"
	        }
	    ],
	    "id": "GTEx-v8-Adipose-Subcutaneous",
	    "reproducible": true
	}
	```

