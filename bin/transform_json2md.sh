#!/usr/bin/env bash
#
#   Script to convert Beacon v2 Models to Markdown
#
#   Last Modified: Jan/01/2021
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

set -eu
mod_dir=/media/mrueda/4TB/CRG_EGA/Project_Beacon/beacon-v2-Models-main/BEACON-V2-draft4-Model
fw_dir=/media/mrueda/4TB/CRG_EGA/Project_Beacon/beacon-framework-v2-main
fw_url=https://raw.githubusercontent.com/ga4gh-beacon/beacon-framework-v2/main
out_dir=../schemas
jsonref=./jsonref2json.py
yaml2md=./beacon_yaml2md.pl
yaml2json='perl -MYAML -MJSON -0777 -wnl -e'

mkdir -p $out_dir/obj

cat<<EOT
=====================
Fixing errors in JSON
=====================

EOT

# Miscellanea errors in 'properties'
sed -i 's#\./Age\.json#./age.json#' $mod_dir/common/ageRange.json

# Errors from 'mkdocs serve'
# 1 - ageGroup is an an ontologyTerm (https://raw.githubusercontent.com/ga4gh-beacon/beacon-framework-v2/main/common/ontologyTerm.json)
# 2 - age.md (and nested 'iso8601duration') are not created (>3rd degree?)
# ** 1 and 2 fixed below:
cat $fw_dir/common/ontologyTerm.json | sed -e '1s#^#{"ageGroup":\n#' -e '$s#$#\n}#' | $yaml2json 'print YAML::Dump(decode_json($_))' | perl -pe 's/ \*(\d+)$/ $1/' > $out_dir/obj/ageGroup.yaml 
sed -e '1s#^#{"age":\n#' -e '$s#$#\n}#' $mod_dir/common/age.json | $yaml2json 'print YAML::Dump(decode_json($_))' | perl -pe 's/ \*(\d+)$/ $1/' > $out_dir/obj/age.yaml
cat $mod_dir/common/age.json | jq .properties | $yaml2json 'print YAML::Dump(decode_json($_))' | perl -pe 's/ \*(\d+)$/ $1/' > $out_dir/obj/iso8601duration.yaml

# Errors in <genomicVariations>
# identifiers/molecularAttributes/variantLevelData were enforced to be type:objects w/ properties
#sed -e 's/"items": "string"/"items": {"type": "string"}/'  \
#    -e 's/"Identifiers": {/"Identifiers": {"type": "object", "properties": {/' \
#    -e '143s/},/}},/' \
#    -e 's/"MolecularAttributes": {/"MolecularAttributes": {"type": "object", "properties": {/' \
#    -e '175s/},/}},/' \
#    -e 's/"VariantLevelData": {/"VariantLevelData": {"type": "object", "properties": {/' \
#    -e '381s/},/}},/' \
#    $mod_dir/genomicVariations/defaultSchema.json  |jq . > $mod_dir/genomicVariations/defaultSchema.json.json
#mv  $mod_dir/genomicVariations/defaultSchema.json.json $mod_dir/genomicVariations/defaultSchema.json

cat<<EOT
============================
Transforming Schemas to YAML
============================

EOT

for schema in analyses biosamples cohorts datasets genomicVariations individuals runs
do
 mkdir -p $out_dir/$schema

 # Problem: Original JSON files use JSON pointers ($ref) and this COMPLICATES A LOT the markdown creation
 # Solution: Dereference JSON Pointers
 #  Options found (08/31/21):
 #   A: NodeJS => https://apitools.dev/json-schema-ref-parser/docs
 #   B: Python => https://pypi.org/project/jsonref/#description   <======== CHOSEN
 # NB: Dereferencing performed only at the schema-level
 echo "Fixing relative paths in JSON $schema ..."
 sed -e "s#$fw_url#file:$fw_dir#" \
     -e 's#mmon/Age#mmon/age#' \
     -e "s#\.\./common#file:$mod_dir/common#" $mod_dir/$schema/defaultSchema.json > $out_dir/$schema/defaultSchema.mod.json

 echo "Dereferencing \$ref in JSON $schema ..."
 $jsonref $out_dir/$schema/defaultSchema.mod.json > $out_dir/$schema/defaultSchema.json
 rm $out_dir/$schema/defaultSchema.mod.json

 echo "Transforming $schema JSON to YAML ..."
 $yaml2json 'print YAML::Dump(decode_json($_))' $out_dir/$schema/defaultSchema.json  | perl -pe 's/ \*(\d+)$/ $1/' >  $out_dir/$schema/defaultSchema.yaml
 echo "---"
done

cat<<EOT

================================
Transforming Schemas to Markdown
================================

EOT

$yaml2md --D

cat<<EOT

=========
All Good!
=========

EOT
