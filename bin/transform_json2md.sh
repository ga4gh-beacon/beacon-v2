#!/usr/bin/env bash
#
#   Script to convert Beacon v2 Models to Markdown
#
#   Last Modified: Mar/26/2022
#
#   Version 2.0.0
#
#   Copyright (C) 2021-2024 Manuel Rueda (manuel.rueda@cnag.eu)
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

set -eu
mod_dir=../models/json/beacon-v2-default-model
fwk_dir=../framework/json
#adhoc_url='https://raw.githubusercontent.com/g4gh-beacon/beacon-v2/main/bin/adhoc'
adhoc_url='https://raw.githubusercontent.com/mrueda/beacon-v2/main/bin/adhoc'
out_dir=./deref_schemas
jsonref='node ./jsonref2json.js'
yaml2md=./beacon_yaml2md.pl
yaml2json='perl -MYAML::XS -MJSON::XS -0777 -wnl -e'

mkdir -p $out_dir/obj

cat<<EOT
=====================
Fixing errors in JSON
=====================

EOT

# For mysteriorous reasons ontologyTerm.json (within CURIE) only works (jsonref2json.js) with $ref: url
sed -i "s#\./beaconCommonComponents.json\#/$defs/CURIE#$adhoc_url/beaconCommonComponents.json\#/$defs/CURIE#" $fwk_dir/common/ontologyTerm.json

cat<<EOT
====================================
Dereferencing and converting to JSON
====================================

EOT

for schema in analyses biosamples cohorts datasets genomicVariations individuals runs
#for schema in genomicVariations
do
 mkdir -p $out_dir/$schema

 # Problem: Beacon v2 schemas use JSON references ($ref) and this COMPLICATES A LOT the markdown creation
 # Solution: Dereference JSON Pointers
 #  Options found (08/31/21):
 #   A: NodeJS => https://apitools.dev/json-schema-ref-parser/docs <======== CHOSEN
 #   B: Python => https://pypi.org/project/jsonref/#description 
 #      NB1: It does not work with $ref: url
 #      NB2: <jsonref> needs FULL_PATH for external files (file:)
 #      The Python one displays siblings $ref (e.g.,"Description") in parents 
 #      
 # NB: Dereferencing performed only at the schema-level
 echo "Fixing relative paths in YAML $schema ..."
 sed -e "s#\.\./common#../../$mod_dir\/common#" \
     -e "s#https://raw.githubusercontent.com/ga4gh-beacon/beacon-v2/main/framework/json/common/ontologyTerm.json#$adhoc_url/ontologyTerm.json#" $mod_dir/$schema/defaultSchema.json > $out_dir/$schema/defaultSchema.mod.json

 echo "Dereferencing \$ref in YAML $schema ..."
 $jsonref $out_dir/$schema/defaultSchema.mod.json > $out_dir/$schema/defaultSchema.json
 rm $out_dir/$schema/defaultSchema.mod.json

 echo "Transforming $schema JSON to YAML ..."
 $yaml2json 'print YAML::XS::Dump(decode_json($_))' $out_dir/$schema/defaultSchema.json  | perl -pe 's/ \*(\d+)$/ $1/' >  $out_dir/$schema/defaultSchema.yaml

 echo "---"
done

cat<<EOT

================================
Transforming Schemas to Markdown
================================

EOT

# Running $yaml2md with option -D (delete previous objects)
$yaml2md --D

# Cleaning tmp_files
#echo "Deleting $out_dir/ files"
#rm -fr $out_dir/ 

cat<<EOT

=========
All Good!
=========

EOT
