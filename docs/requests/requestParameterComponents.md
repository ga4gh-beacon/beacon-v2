# Request Parameter Definitions
Component definitions for `requestProfiles`. The definition of each parameter as a component allows for reuse across multiple request patterns but also for e.g. easy referencing in OpenAPI endpoints.

## `AminoacidChange` 

#### Description
Aminoacid alteration of interest. Format 1 letter Origin: Beacon v2.0    

#### Definitions
        
* `type`: `string`    
* `examples`:     
    - `V600E`    
    - `M734V`        


## `Assembly` 

#### Description
Genomic assembly accession and version as RefSqeq assembly accession (e.g. "GCF_000001405.39") or a versioned assembly name or synonym such as UCSC Genome Browser assembly (e.g. "hg38") or Genome Reference Consortium Human (e.g. "GRCh38.p13") names. DEPRECATION NOTE: The use of a assembly specific sequence identifier obviates this parameter. Not part of VRS v2 aligned model versions.    

#### Definitions
    
* `versions`:     
    - `v1`    
    - `v2.0`    
    - `v2.1`        
    
* `type`: `string`    
    
* `example`:     
    - `GCF_000001405.39`    
    - `hg38`    
    - `GRCh38.p13`        


## `GeneId` 

#### Description
    
* A gene identifier     
* It is strongly suggested to use a symbol following
  the HGNC (https://www.genenames.org) nomenclature.
Origin: Beacon v2.0    

#### Definitions
    
* `type`: `string`      
* `examples`:     
    - `BRAF`    
    - `SCN5A`        

## `GenomicAlleleShortForm` 

#### Description
HGVSId descriptor Origin: Beacon v2.0    

#### Definitions
    
* `type`: `string`        
* `examples`:     
    - `NM_004006.2:c.4375C>T`        


## `RefSeqId` 

#### Description
Reference sequence id for genomic reference sequence in which variant coordinates are given, e.g. "refseq:NC_000009.12" for human chromosome 9 in the GRCh38 assembly. The use of the assembly specific RefSeqId is recommended although alternatively names, synonymous or aliases e.g. "chr9" could be used in conjunction with an `Assembly` parameter. DEPRECATION NOTE: To be replaced with the `RefgetAccession` from VRS v2.    

#### Definitions
    
* `type`: `string`    
* `example`:     
    - `refseq:NC_000009.12`    
    - `chr9`    
    - `NC_012920.1`        

## `ReferenceBases` 

#### Description
The reference bases for the variant at the indicated position. It is based on the VCF cocept of having (anchored) reference bases at an indicated genomic location in combination with `alternateBases` to define their replacement. In contrast, standards such as GA4GH VRS only indicate the `sequence` observed at a given base position, including the use of an empty sequence together with `start` + `end` positions with `end - start > 0` to indicate deletions. Origin: VCF derived (optional) use in Beacon v0.3 -> v2.1 Status: LEGACY    

#### Definitions
    
* `$ref`: `#/$defs/Sequence`    

## `AlternateBases` 

#### Description
The bases of a sequence variant at a given position differing from the reference sequence, as defined by the `referenceBases` parameter. Please see `refereenceBases` for further information. Origin: VCF derived use in Beacon v0.3 -> v2.1 Status: LEGACY    

#### Definitions
    
* `$ref`: `#/$defs/Sequence`    


## `Sequence` 

#### Description
DNA bases.    
    
* Accepted values: `[ACGTN]*`         
* N is a wildcard, that denotes the position of any base,
  and can be used as a standalone base of any type or within a partially known
  sequence. As example, a query of `ANNT` the Ns can take take any form of [ACGT]
  and will match `ANNT`, `ACNT`, `ACCT`, `ACGT` ... and so forth.    
Origin: VRS v1.n
TODO: Review use of base characters.    


## `VariantType` 

#### Description
The `variantType` is used to query variants which are not defined through a sequence of one or more bases using the `alternateBases` parameter. This VCF derived parameter is being replaced by the more specific VRS derived parameters such as `copyChange`. (Legacy) Examples here are e.g. structural variants:     
* DUP
  - increased allelic count of material from the genomic region between
    `start` and `end` positions
  - no assumption about the placement of the additional sequences is being
    made (i.e. no _in situ_ requirement as tandem duplications)  
* DEL: deletion of sequence following `start`

In contrast to the updated VRS based v2.n parameters such as `copyChange` the Beacon v1.1 -> v2.1 query model is not prescriptive with regard to the values allowed for `variantType` with use of extended types (e.g. `EFO:0030063`) being permitted. However, a support for the basic CNV types above - where represented in the data - is recommended. Status: LEGACY with potential use in v2.n for non-CNV parameters 


For CNVs it is highly recommenmded to us the EFO terminology which has becomne default
for the VRS data model (v1.3 and v2):

```
* EFO:0030069: complete genomic loss         
* EFO:0020073: high-level loss         
* EFO:0030068: low-level loss         
* EFO:0030067: loss         
* EFO:0030064: regional base ploidy         
* EFO:0030070: gain         
* EFO:0030071: low-level gain         
* EFO:0030072: high-level gain    
```

Endpoints are expected to provide query expansion according to the hierarchy of the terms:

```
- EFO:0030064 - EFO:0030067
    |- EFO:0030068
    \- EFO:0020073
         \- EFO:0030069
- EFO:0030070
    |- EFO:0030071
    \- EFO:0030072
```
      additional parameter (`variantClass`?).    

#### Definitions
    
* `type`: `string`    
* `examples`:     
    - `EFO:0030070`    
    - `DUP`    
    - `DEL`    
    - `EFO:0030069`        

## `Start` 

#### Description
NOTE: This parameter will be _potentially_ replaced by the VRS based definition
      which uses either an integer or a Range (2 integers) in contrast to
      the use of an array with 1 or 2 integers here. The difference lies in 
      the format of "1 integer array" versus "1 integer".
Precise or fuzzy start coordinate position(s), allele locus (0-based, inclusive).
    
* `start` only:
  - for single positions, e.g. the start of a specified sequence
    alteration where the size is given through the specified `alternateBases`
  - typical use are queries for SNV and small InDels
  - the use of `start` without an `end` parameter requires the use of
    `alternateBases` 
* 1 value in both `start` and `end`:
  - for searching any variant falling fully or partially within the range
    between `start` and `end` (a.k.a. "range query")
  - additional use of `variantType` OR `alternateBases` can limit the
    scope of the query
  - by convention, partial overlaps of variants with the indicated genomic
    range are accepted; for specific overlap requirements the 4-parameter
    "Bracket Queries" should be employed  
* 2 values in both `start` and `end` for constructing a "Bracket Query":
  - can be used to match any contiguous genomic interval, e.g. for querying
    imprecise positions
  - identifies all structural variants starting between `start[0]` and `start[1]`,
    and ending between `end[0]` <-> `end[1]`
  - single or double sided precise matches can be achieved by setting
    `start[1]=start[0]+1` and `end[1]=end[0]+1`    

#### Definitions
    
* `type`: `array`    
* `items`:    
    - `type`: `integer`      
    - `format`: `int64`      
    - `minimum`: `0`      
* `minItems`: `1`     
* `maxItems`: `2`    

## `End` 

#### Description

##### Notes
See the `start` parameter for information on the potential replacement of this parameter with the VRS based definition.
Precise or bracketing the end of the variants of interest:
    
* (0-based, exclusive) - see `start`     
* for bracket queries, provide 2 values (e.g. [111,222]).    

#### Definitions
    
* `type`: `array`    
* `items`:    
    - `type`: `integer`      
    - `format`: `int64`      
    - `minimum`: `1`     
* `minItems`: `1`      
* `maxItems`: `2`    

## `MateName` 

#### Description

##### Notes
    
* while the `mateName` parameter was originally defined for Beacon v1.1
  it was never properly documented and is not considered a part of the
  supported Beacon v2.n specification. It is now fully implemented in the
  VRS v2 based `adjacencyAccession` parameter.
Status: DEPRECATED in v2.n    

#### Definitions
    
* `$ref`: `#/$defs/RefSeqId`    

## `MateStart` 

#### Description
genomic start position of fusion partner breakpoint region
Status: DEPRECATED in v2.n (see `mateName`)    

#### Definitions
        
* `type`: `integer`    

## `MateEnd` 

#### Description
genomic end position of fusion partner breakpoint region Status: DEPRECATED in v2.n (see `mateName`)    

#### Definitions
        
* `type`: `integer`    

## `VariantMinLength` 

#### Description
    
* Minimum length in bases of a genomic variant     
* This is an optional parameter without prescribed use. While a length is
  commonly available for structural variants such as copy number variations,
  it is recommended that length based queries should also be supported for
  variants with indicated referenceBases and alternateBases, to enable
  length-specific wildcard queries.
Origin: Beacon v2.0
Status: DEPRECATED in v2.n (see `sequenceLength`)    

#### Definitions
        
* `type`: `integer`    
* `format`: `int64`        
* `minimum`: `0`    

## `VariantMaxLength` 

#### Description
    
* Maximum length in bases of a genomic variant.     
* This is an optional parameter without prescribed use. While a length is
  commonly available for structural variants such as copy number variations,
  it is recommended that length based queries should also be supported for
  variants with indicated referenceBases and alternateBases, to enable
  length-specific wildcard queries.
Status: DEPRECATED in v2.n (see `sequenceLength`)
Origin: Beacon v2.0    

#### Definitions
    
* `type`: `integer`    
* `format`: `int64`    
* `minimum`: `1`    
