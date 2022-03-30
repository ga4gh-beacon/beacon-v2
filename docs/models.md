# beacon-v2-Models

## Introduction

The GA4GH Beacon specification is composed by two parts:

* the Beacon [Framework](framework.md) {{config.repo_framework_icon}}
* the Beacon [Models](models.md) {{config.repo_models_icon}}

The **Beacon Framework** (in Framework repo {{config.repo_framework_icon}}) is the part that describes the overall structure of the API requests, responses, parameters, the common components, etc. It could also be referred in this document as simply the *Framework*.

**Beacon Models** (in the Models repo {{config.repo_models_icon}}) describes the set of concepts included in a Beacon version (e.g. Beacon v2), like *individual* or *biosample*, and also the relationships between them. It could also be referred in this document as simply the *Model*.

The Framework could be considered the *syntax* and the Model as the *semantics*. 

Refer to the [Framework](framework.md) {{config.repo_framework_icon}} for further information about the Framework and its parts.

A **Beacon instance** is just an implementation of a Beacon Model that follows the rules stated by the Beacon Framework.

If you are a Beacon implementer, then, you don't need to clone the Framework repo, you only need to **copy** (*or clone*) the Beacon Model and modify it to your specific case. You will find plenty of references to the Framework in the Model copy, and you will use the Json schemas there to validate that both the structure of your requests and responses are compliant with the Beacon Framework. The Framewrok is not used to check the schema in the responses payload (e.g. the actual details of a biosample of a cohort). The schemas for that are included in the Model that you should have copied.

The Model repo points to several hosts the default model for Beacon v2:

1. **The TEMPLATE Model:** [repo](https://github.com/ga4gh-beacon/Model-TEMPLATE) is the most basic model. Its purpose is twofold 1) as starting point for any *new* model (so to say, not Beacon v2) and 2) as a learning tool.
2. **The Beacon v2 Model:** (in [Models](https://github.com/ga4gh-beacon/beacon-v2-Models)) represents the complete Beacon v2 _Default_ Model.

``` mermaid
classDiagram

    analyses <-- genomicVariations : 1..n
    runs <-- analyses : 1..n
    biosamples <-- runs : 1..n
    individuals <-- biosamples : 1..n

    runs <.. genomicVariations : 1..n
    biosamples <.. genomicVariations : 1..n
    individuals <.. genomicVariations : 1..n
    biosamples <.. analyses : 1..n
    individuals <.. analyses : 1..n
    individuals <.. runs : 1..n

    cohorts o-- individuals : 1..n
    datasets o-- genomicVariations : 1..n
    datasets o-- runs : 1..n
    datasets o-- analyses : 1..n
    datasets o-- biosamples : 1..n
    datasets o-- individuals : 1..n

    class genomicVariations{
        analysisId
        runId
        biosampleId
        individualId
        variation
        clinicalInterpretations
        caseLevelData
        ...
    }
    class analyses{
        id
        runId
        biosampleId
        individualId
        analysisDate
        pipelineName
        aligner
        ...
    }
    class biosamples{
        id
        individualId
        biosampleStatus
        sampleOriginType
        histologicalDiagnosis
        collectionDate
        ...
    }
    class individuals{
        id
        sex
        diseases
        phenotypicFeatures
        ethnicity
        pedigrees
        ...
    }
    class runs{
        id
        biosampleId
        individualId
        runDate
        librarySource
        libraryStrategy
        platform
        ...
        }
    class datasets{
        id
        name
        description
        dataUseCondition
        info
        updateDateTime
        ...
    }
    class cohorts{
        id
        name
        cohortType
        cohortSize
        cohortDataTypes
        cohortDesign
        ...
    }
```

The above entities are defined as follows;

  * Collections (**Datasets** and **Cohorts**): groupings of variants or individuals that share something in common: e.g., who belong to the same repository (datasets) or study population (cohorts).
  * **Genomic variations**: unique genomic alterations, e.g., position in a genome, sequence alterations, type, etc.
  * **Individuals**: either patients or healthy controls whose details (including phenotypic and clinical) are stored in the repository.
  * **Biosamples**: samples taken from individuals, including details of procedures, dates and times.
  * **Analyses & Runs**: details on (a) procedures used for sequencing a biosample (runs), and (b) bioinformatic procedures to identify variants (analyses)

!!! Important "**Beacon v1 Model:** [Repo](https://github.com/ga4gh-beacon/Model-BEACON-v1)"
    Provided as an example for Beacon v1 implementers that want to update to Beacon v2 but not planning to add any additional entry type to their Beacon.
