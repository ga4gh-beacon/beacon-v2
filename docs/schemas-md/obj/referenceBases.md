|Term | Description | Type | Properties | Example | Enum|
| ---| ---| ---| ---| ---| --- |
| referenceBases | Reference bases for this variant (starting from `start`). * Accepted values: IUPAC codes for nucleotides (e.g. `https://www.bioinformatics.org/sms/iupac.html`). * N is a wildcard, that denotes the position of any base, and can be used  as a standalone base of any type or within a partially known sequence.* an *empty value* is used in the case of insertions with the maximally  trimmed, inserted sequence being indicated in `AlternateBases`. | string | NA | A, T, N, , ACG | NA|
