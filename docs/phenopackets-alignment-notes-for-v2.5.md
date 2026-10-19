# Phenopackets Alignment Notes for v2.5

* Changed `ComplexValue.TypedQuantity.quantityType` to PXF aligned to `ComplexValue.TypedQuantity.type` in v2.5 proposal
* Changed `ExternalReference.notes` to PXF aligned to `ExternalReference.description` in v2.5 proposal
* `Measurement`
    - `assayCode` => `assay`
    - `observationMoment` => `timeObserved`
    - `notes` => `description`
* `TimeElement`
    - There was a difference in the representation compared to Phenopackets. In
      PXF the `timeElement` property references one of the classes but as a named
      property (e.g. `timeElement.timestamp`) wherease in Beacon so far it was
      `oneOf` the direct class definitions which would resolve to a direct
      `timeElement` property having any of the possible values (e.g. a timestamp
      or an ISO range). This has now been changed to a `oneOf` named properties.
* `PhenotypicFeature`:
    - `featureType` => `type`
    - `notes` => `description`
    - fixed list type in `modifiers.examples`
* `Procedure`
    - `procedureCode` => `code`
    - `ageAtProcedure` => `performed`
    - `dateOfProcedure` so far left; `performed` is meant to express age or time ...
      etc. (TimeElement) but not both options. Ist this necessary to keep?
* `Treatment`
    - `treatmentCode` => `agent`
    - new: `drugType` & definition in `common`
* `Disease`
    - `diseaseCode` => `term`
        * TODO: Mondo example
    - `ageOfOnset` => `onset`
    - `stage` => `diseaseStage`
    - `clinicalTNMfinding` added
    - `primarySite` added
    - `laterality` added
    - TODO: `phenotypicFeature` is in Beacon but not in PXF - there it is only part
      of `phenotypicFeature`. So far in schema but should be discussed.
    - TODO: `familyHistory` is in Beacon but not in PXF. So far in schema but
      should be discussed.
* `Pedigree`
    - non-breaking change `$defs.pedigreeMember` => `$defs.PedigreeMember`
    - adding PXF derived `persons` and `$defs.Person` and notes about provenance
* `Sex`
    - The current Phenopackets v2 uses an ENUM representation of Sex in the sense
      of "typical phenotypic sex, as would be determined by a midwife or physician at birth".
      With some experience now from Beacon implementations and the irregular use
      identifiers it seems beneficial to change the Beacon model to the same approach
      (_i.e._ providing a generic conceptual representation and leave the resolution
      to the implementations). This is also in line with the previously documented
      NCIT terms.

