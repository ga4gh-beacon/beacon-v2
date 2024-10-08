|Term | Description | Type | Properties | Example | Enum|
| ---| ---| ---| ---| ---| --- |
| alternateBases | Alternate bases for this variant (starting from `start`). * Accepted values: IUPAC codes for nucleotides (e.g. `https://www.bioinformatics.org/sms/iupac.html`). * N is a wildcard, that denotes the position of any base, and can be used as  a standalone base of any type or within a partially known sequence.* an *empty value* is used in the case of deletions with the maximally  trimmed, deleted sequence being indicated in `ReferenceBases` | string | NA | T, G, N, AG,  | NA|
