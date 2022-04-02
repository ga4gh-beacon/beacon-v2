|Term | Description | Type | Properties | Example | Enum|
| ---| ---| ---| ---| ---| --- |
| members | List of members of the pedigree. If the current pedigree definition is attached to the proband, it contains the whole list of pedigree members, including the proband. If the definition is attached to an individual different than the proband, it only contains two entries: one that describes that member, e.g. the proband mother or father, and one that points to the proband. | array | [affected](./affected.md), [memberId](./memberId.md), [role](./role.md) | NA | NA|
