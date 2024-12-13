#!/usr/bin/env python3
#
#   Script to dereference JSON $ref in Beacon v2 Models schemas
#
#    ------------ DEPRECATED ------------
#   *******************************************************
#   * JsonRef !!!!!! Warning !!!!!!
#   * $ref is using siblings "Description"
#   * but with JSON schema 2020/12 it should be allowed 
#   * to have parent's "Description"
#   * https://json-schema.org/draft/2019-09/json-schema-core.html#rfc.section.7.7.1.1
#   *******************************************************
# {
#   "$comment": "version: ga4gh-beacon-cohort-v2.0.0",
#   "$schema": "https://json-schema.org/draft/2020-12/schema",
#   "additionalProperties": true,
#   "$defs": {
#     "CohortCriteria": {
#       "description": "THIS IS NOT OK",
#       "properties": {
#         "ageRange": {
#           "description": "Individual age range in cohort inclusion criteria"
#         }
#       },
#       "type": "object"
#     }
#   },
#   "description": "A cohort available in the beacon.",
#   "properties": {
#     "inclusionCriteria": {
#       "description": "THIS IS OK",
#       "type": "object",
#       "$ref": "#/$defs/CohortCriteria"
#     }
#   }
# }
#
#   Last Modified: Sep/01/2021
#
#   Version 2.0.0
#
#   Copyright (C) 2021-2022 Manuel Rueda (manuel.rueda@crg.eu)
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 3 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, see <https://www.gnu.org/licenses/>.
#
#   If this program helps you in your research, please cite.

import sys
import json
#from pprint import pprint
from jsonref import JsonRef

def main():
    # Opening JSON file
    json_in = open(sys.argv[1], 'r', encoding="utf-8")
  
    # Procesing JSON file
    data = json.load(json_in)
    #pprint(JsonRef.replace_refs(data))
    json_out = JsonRef.replace_refs(data)

    # Print to STDOUT
    json.dump(json_out, sys.stdout, indent=4)

if __name__ == "__main__":
    main()
