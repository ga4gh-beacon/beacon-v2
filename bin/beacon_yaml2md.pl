#!/usr/bin/env perl
#
#   Script to convert Beacon v2 Models schemas to Markdown tables
#
#   Last Modified: Mar/26/2024
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

use strict;
use warnings;
use autodie;
use feature qw(say);
use Getopt::Long;
use Pod::Usage;
use File::Basename;
use File::Spec::Functions qw(catdir catfile);

my $debug   = 0;
my $verbose = 0;

##### Main #####
beacon_yaml2md();
################
exit;

sub beacon_yaml2md {

    # Defining a few variables
    my $version = '2.0.0';

    # https://github.com/ga4gh-beacon/beacon-v2-Models/tree/main/BEACON-V2-draft3-Model
    my $schema_dir   = './deref_schemas';
    my $markdown_dir = '../docs/schemas-md';
    my $obj          = 'obj';

    # Reading arguments
    GetOptions(
        'schema-dir=s'   => \$schema_dir,                              # string
        'markdown-dir=s' => \$markdown_dir,                            # string
        'delete|D'       => \my $delete,                               # flag
        'help|?'         => \my $help,                                 # flag
        'man'            => \my $man,                                  # flag
        'debug=i'        => \$debug,                                   # integer
        'verbose'        => \$verbose,                                 # flag
        'version|v'      => sub { say "$0 Version $version"; exit; }
    ) or pod2usage(2);
    pod2usage(1)                              if $help;
    pod2usage( -verbose => 2, -exitval => 0 ) if $man;
    pod2usage(
        -message => "Please specify a valid directory for --schema-dir\n",
        -exitval => 1
    ) if ( !-d $schema_dir );
    pod2usage(
        -message => "Please specify a valid directory for --markdown-dir\n",
        -exitval => 1
    ) if ( !-d $markdown_dir );

    # Before anything, $delete will delete previous yaml from nested properties
    my $old_yaml = catfile( $schema_dir, "$obj/*.yaml" );
    say "*** Erasing $old_yaml ***" and unlink glob "$old_yaml" if $delete;

    # Define a few more variables...
    my @schemas =

      qw (analyses biosamples cohorts datasets genomicVariations individuals runs);

    #qw (genomicVariations);

    my $schema_obj_dir   = catdir( $schema_dir,   $obj );
    my $markdown_obj_dir = catdir( $markdown_dir, $obj );
    my $raa_header       = [qw(Term Description Type Properties Example Enum)];

    # Load a hash with schema location
    my %schema = ();
    for my $schema (@schemas) {
        $schema{$schema}{yaml} =
          catfile( $schema_dir, $schema, 'defaultSchema.yaml' );
        $schema{$schema}{md} =
          catfile( $markdown_dir,
            $schema . '_' . basename( $schema{$schema}{yaml} ) );
        $schema{$schema}{md} =~ s/\.yaml/.md/;
    }

    # Load a variable that needs $markdown_dir
    my $beacon_terms = catfile( $markdown_dir, 'beacon_terms.md' );

    #########################
    # START YAML CONVERSION #
    #########################
    my $yaml = YAML2MD->new(
        {
            yaml_obj => $schema_obj_dir,
            md_obj   => $markdown_obj_dir,
            b_terms  => $beacon_terms,
            header   => $raa_header,
            obj      => $obj
        }
    );

    #for my $schema (qw(analyses)) {

    for my $schema (@schemas) {
        say "====================================";
        say "Transforming schema => $schema";
        say "IN  $schema{$schema}{yaml}";
        say "OUT $schema{$schema}{md}";
        $yaml->yaml2md(
            {
                schema => $schema,
                yaml   => $schema{$schema}{yaml},

                #yaml   => './defaultSchema.yaml',
                md => $schema{$schema}{md},
            }
        );
    }
    $yaml->yaml2md_obj();

    #######################
    # END YAML CONVERSION #
    #######################
}

package YAML2MD;

use strict;
use warnings;
use autodie;
use feature qw(say);
use YAML::XS qw(LoadFile DumpFile);
use JSON::XS;
use File::Basename;
use List::MoreUtils qw/any/;
use Path::Tiny;
use Data::Dumper;
use File::Spec::Functions qw(catdir catfile);
use Mojo::JSON::Pointer;

$Data::Dumper::Sortkeys        = 1;
$YAML::XS::QuoteNumericStrings = 0;

sub new {
    my ( $class, $arg ) = @_;
    my $self = {
        yaml_obj => $arg->{yaml_obj},
        md_obj   => $arg->{md_obj},
        b_terms  => $arg->{b_terms},
        header   => $arg->{header},
        obj      => $arg->{obj}
    };
    bless $self, $class;
    return $self;
}

sub yaml2md {

    my $self       = shift;
    my $var        = shift;
    my $yo_dir     = $self->{yaml_obj};
    my $raa_header = $self->{header};
    my $obj        = $self->{obj};
    my $schema     = $var->{schema};
    my $y_file     = $var->{yaml};
    my $m_file     = $var->{md};

    # First we load the main YAML schema
    my $data = load_yaml($y_file);

    # Then we slice it at the properties-level and create YAMLs for each property
    my ( $yaml_properties, $ra_properties ) =
      yaml_slicer( $data, $schema, $yo_dir );
    say 'All properties => ', join ',', @$ra_properties;

    ###############################
    # Processing main YAML schema #
    ###############################

    my $header  = table_header($raa_header);
    my $out_str = $header;
    $out_str .=
      table_content( $yaml_properties, $ra_properties, $raa_header, $obj, 1 );
    $out_str .= add_tabs_with_examples($schema);
    write_file( $m_file, $out_str );
    return 1;
}

sub yaml2md_obj {

    my $self         = shift;
    my $yo_dir       = $self->{yaml_obj};
    my $mo_dir       = $self->{md_obj};
    my $beacon_terms = $self->{b_terms};
    my $raa_header   = $self->{header};
    my $obj          = $self->{obj};

    ######################################
    # Processing properties YAML schemas #
    ######################################

    my $header = table_header($raa_header);
    my @yamls  = ();

    # Ad hoc solution to force creation of <duoDataUse.yaml> (it gives problems with <allOf>)
    # + toolName.yaml, toolReferences (they are too deeply nested)
    for my $yaml ( 'duoDataUse.yaml', 'toolName.yaml', 'toolReferences.yaml' ) {
        write_file( catfile( $yo_dir, $yaml ), create_str_yaml($yaml) );
    }

    # Now process all obj
    foreach my $yaml ( glob("$yo_dir/*.yaml") ) {
        say "*** Processing $yaml file ***" if $debug;
        my $data                 = load_yaml($yaml);
        my $nested_properties    = $data;
        my $nested_ra_properties = [ keys %$data ];
        my $out_str              = $header;
        $out_str .= table_content( $nested_properties, $nested_ra_properties,
            $raa_header, $obj, 0 );

        # We parse $yaml to get paths and more...
        my ( $base, $dir, $ext ) = fileparse( $yaml, '.yaml' );
        $ext =~ s/\.yaml/.md/;

        # Ad hoc fix for two files that have same namex except for uc/lc
        # AgeRange == ageRange  and Value == value on MacOS cwAPFS (Case insensitive)
        $base = $base . '_PXF' if ( $base eq 'AgeRange' || $base eq 'Value' );
        my $file = catfile( $mo_dir, $base . $ext );    # Note -> $base.$ext
        write_file( $file, $out_str );

        # Finally we store values, to be used later (beacon_terms.md)
        push @yamls, $base, "./$obj/$base" . $ext;
    }

    ###############################
    # Creating beacon_terms.md #
    ###############################

    my %yaml = @yamls;
    say "\n*** Creating file => $beacon_terms ***";
    my $b_terms_tmp_str = '';

    # Sort naturally without resorting to Sort::Naturally
    for my $key ( sort { "\L$a" cmp "\L$b" } keys %yaml ) {
        $b_terms_tmp_str .= "* [$key]($yaml{$key})\n";
    }

    # Writing file
    write_file( $beacon_terms, $b_terms_tmp_str );
    return 1;
}

sub yaml_slicer {

    my ( $data, $schema, $yo_dir ) = @_;

    my $yaml_properties = $data->{properties};
    my $ra_properties   = [ keys %$yaml_properties ];
    print "YAML Properties\n", Dumper $yaml_properties if $debug;
    print "All  Properties\n", Dumper $ra_properties   if $debug;

    ###########################
    # Object properties => 1D #
    ###########################

    # Instead of working directly with recursive hash slices, we create
    # one YAML file for each property and then re-use code from the 'main' schema

    ##########################################
    # **** Note about VRS / PXF adoption *** #
    ##########################################

    # The adoption of those standards had technical implications. The script expects objects to have
    #  <key> for the object and then <properties>. VRS/PXF follow JSON schemas that include /oneOf allOf anyOf/
    # plus other complex intructions such as <if:> <else:>.
    # This becomes a real challenge with $ref as, for instance, in <g_v.variation> we can not find the key for
    # 'MolecularVariation', 'SystemicVariation', 'LegacyVariation'
    # TL;DR; WE ARE INTRODUCING A FEW AD HOC CHANGES BELOW....

    for my $property (@$ra_properties) {

        #next unless lc($property) eq 'variation';
        $yaml_properties->{$property} =
          parse_json_keywords( $property, $yaml_properties->{$property} );
        my $yaml_properties_1d = $yaml_properties->{$property};
        dump_yaml( $property, $yaml_properties_1d, $yo_dir );

        ############################################
        # The objects can come from two sources:   #
        #                                          #
        # 1 - Object itself                        #
        # type: object                             #
        # properties: {foo: John, bar: Doe}        #
        #                                          #
        # 2 - Array of objects                     #
        # type: array                              #
        # items: {                                 #
        #        properties: {foo: John, bar: Doe} #
        #        }                                 #
        ############################################
        my $data_type = check_data_type($yaml_properties_1d);

        #################################
        # Object|Array Properties => 2D #
        #################################
        my $yaml_properties_2d =
            $data_type eq 'array'
          ? $yaml_properties_1d->{items}{properties}
          : $yaml_properties_1d->{properties};
        for my $property ( keys %$yaml_properties_2d ) {
            $yaml_properties_2d->{$property} = parse_json_keywords( $property,
                $yaml_properties_2d->{$property} );
            dump_yaml( $property, $yaml_properties_2d->{$property}, $yo_dir );

            #################################
            # Object|Array Properties => 3D #
            #################################
            my $data_type = check_data_type( $yaml_properties_2d->{$property} );
            my $yaml_properties_3d =
                $data_type eq 'array'
              ? $yaml_properties_2d->{$property}{items}{properties}
              : $yaml_properties_2d->{$property}{properties};
            for my $property ( keys %$yaml_properties_3d ) {
                $yaml_properties_3d->{$property} =
                  parse_json_keywords( $property,
                    $yaml_properties_3d->{$property} );

                # Can't bo beyond 3D, using subroutine to add links
                $yaml_properties_3d->{$property} =
                  add_properties_vrs( $property,
                    $yaml_properties_3d->{$property} );
                dump_yaml( $property, $yaml_properties_3d->{$property},
                    $yo_dir );
            }
        }

    }
    return ( $yaml_properties, $ra_properties );
}

sub table_content {

    my ( $yaml_properties, $ra_properties, $headers, $obj, $link ) = @_;
    my @lc_headers = map { lc } @$headers;    # Copy array uc to avoid modifying original $ref
    my $out_str    = '';

    #---------------------------------------------------------|
    # Term (Header 1) | Header 2 | Header 3 | .... | Header N |
    #---------------------------------------------------------|
    # Property        | Value  2 | Value  3 | .... | Value  N |
    #---------------------------------------------------------|

    # Property = identifiers
    for my $property ( sort @$ra_properties ) {

        # @refs will be needed below
        my @refs = ();

        # object ={description,examples,etc...}
        for my $object ( $yaml_properties->{$property} ) {

            # $object has to be defined as an object in the schema, otherwise we skip it
            next unless ref $object eq 'HASH';

            # Now we process all values (matching header terms)
            for my $header (@lc_headers) {

                # Skipping term (not needed)
                next if $header eq 'term';

                # General assignation
                my $value_header = $object->{$header};

                ##################################################
                # Change assignation depending of content/header #
                ##################################################

                # Check presence of plural 'examples'
                $value_header =
                  exists $object->{examples}
                  ? $object->{examples}
                  : $object->{$header}
                  if $header eq 'example';

                # Slice differentely if $object->{type} eq 'array'
                if ( $object->{type} eq 'array' ) {
                    for ( 'description', 'properties' ) {
                        $value_header = $object->{items}{$_} if $header eq $_;
                    }
                }

                # Now convert data structure to string
                say "#### $property => $header  ####" if $debug;
                push @refs, ref2str( $property, $value_header, $obj, $link );
            }
        }

        # Add links to cell values when needed
        my $property_path =
          $link ? "[$property](./$obj/$property.md)" : $property;

        # Accumlate all rows in one big string
        $out_str .= '| ' . ( join ' | ', $property_path, @refs ) . "|\n";
    }
    return $out_str;
}

sub table_header {

    my $headers = shift;
    my $out_str .= '|' . join ' | ', @$headers;
    $out_str .= "|\n" . ( ('| ---') x scalar @$headers ) . " |\n";
    return $out_str;
}

sub ref2str {

    my ( $property, $data, $obj, $link ) = @_;

    # We will append everything into a string ($out_str)
    my $out_str = '';

    # Check data types
    # We can have ARRAY, HASH, STRING and undef
    if ( ref $data eq 'ARRAY' ) {

        # AoH
        if ( ref $data->[0] eq 'HASH' ) {
            $out_str = '`'
              . JSON::XS->new->utf8->space_after->canonical->encode($data)
              . '`';    # ->pretty (encode) does not work inside tables
        }

        # A
        elsif ( ref $data->[0] eq 'ARRAY' ) {
            $out_str = join ',<br />', map {
                '`'
                  . JSON::XS->new->utf8->space_after->canonical->encode(
                    $data->[$_] )
                  . '`'
            } ( 0 .. $#{$data} );
        }

        # string or undef
        else {
            $out_str = defined $data->[0] ? join ', ', @$data : 'NA';    # Note ', ' to allow HTML column rendering
        }
    }
    elsif ( ref $data eq 'HASH' ) {

        my $tmp_str = $link ? "./$obj" : '.';
        $out_str = join ', ',
          map { add_external_links( $tmp_str, $_ ) } sort keys %$data;
        $out_str =~ s/(HASH|ARRAY)\(\w+\)//g;
        $out_str =~ s/,,/,/g;
        $out_str =~ s/,$//;
    }
    else {
        $out_str = defined $data ? $data : 'NA';
    }

    # Finally remove newlines at string level
    $out_str =~ s/\R//g;
    return $out_str;
}

sub add_external_links {

    my ( $tmp_str, $key ) = @_;

    # Note: This is an ad hoc solution to fix errors with deeply-nested data
    my @pxf       = qw( typedQuantities days weeks Quantity high low);
    my @vrs       = qw(_id state type CURIE Location);
    my @framework = ("ontologyTerm");

    return ( any { ( $_ eq $key ) } @pxf )
      ? "[$key](https://phenopacket-schema.readthedocs.io/en/latest/building-blocks.html)"
      : ( any { ( $_ eq $key ) } @vrs )
      ? "[$key](https://vrs.ga4gh.org/en/stable/terms_and_model.html#$key)"
      : ( any { ( $_ eq $key ) } @framework )
      ? "[$key](https://github.com/ga4gh-beacon/beacon-v2/blob/main/framework/src/common/$key.yaml)"

      # NB: Ad hoc solution for properties having equal name (lc)
      : ( $key eq 'AgeRange' || $key eq 'Value' )
      ? "[$key]($tmp_str/${key}_PXF.md)"
      : "[$key]($tmp_str/$key.md)";
}

sub load_yaml {

    my $s_file = shift;
    my $data   = LoadFile($s_file);
    return $data;
}

sub dump_yaml {

    my ( $property, $data, $dir ) = @_;

    ########################
    # IMPORTANT STEP HERE  #
    ########################

    # The slice contains the property values but it does not contain
    # the property name, thus we add it here as the first dimension
    my $yaml = { $property => $data };

    ######################
    # END IMPORTANT STEP #
    ######################

    # Now we simply print the file as YAML
    my $file = catfile( $dir, "$property.yaml" );
    DumpFile( $file, $yaml );
    return 1;
}

sub write_file {

    my ( $file, $str ) = @_;
    path($file)->spew_utf8($str);
    return 1;
}

sub check_data_type {

    my $data = shift;
    return $data->{type} // 'string';
}

sub create_str_yaml {

    # This is an ad hoc solution :-(
    # Changes in the repo won't be reflected here
    my $file           = shift;
    my $str_duoDataUse = <<EOF;
---
duoDataUse:
  description: duoDataUse
  type: array
  examples:
    - id: DUO:0000007
      label: disease specific research
      version: 17-07-2016
  items:
    description: Definition of an ontology term.
    properties:
      id:
        description: A CURIE identifier for an ontology term.
        examples:
          - ga4gh:GA.01234abcde
          - DUO:0000004
          - orcid:0000-0003-3463-0775
          - PMID:15254584
        type: string
      label:
        description: 'The text that describes the term. By default it could be the preferred text of the term, but is it acceptable to customize it for a clearer description and understanding of the term in an specific context.'
        type: string
      modifiers:
        type: array
      version:
        type: string
EOF

    my $str_toolName = <<EOF;
---
toolName:
  description: Name of the tool.
  example: Ensembl Variant Effect Predictor (VEP)
  type: string
EOF

    my $str_toolreferences = <<EOF;
---
toolReferences:
  description: References to the tool
  examples:
    - bio.toolsId: https://bio.tools/vep
    - url: https://www.ensembl.org/vep
  type: object
EOF

## ontologyTerm.yaml is needed due to a bug with jsonref2json.js that overrided "parent" <description> field

    my $str_ontologyTerm = <<EOF;
---
additionalProperties: true
description: Definition of an ontology term.
properties:
  id:
    description: 'A CURIE identifier, e.g. as `id` for an ontology term.'
    examples:
      - ga4gh:GA.01234abcde
      - DUO:0000004
      - orcid:0000-0003-3463-0775
      - PMID:15254584
    pattern: '^\\w[^:]+:.+\$'
    type: string
  label:
    description: 'The text that describes the term. By default it could be the preferred text of the term, but is it acceptable to customize it for a clearer description and understanding of the term in an specific context.'
    type: string
required:
  - id
title: Ontology Term
type: object
EOF

    my %yaml = (
        'duoDataUse.yaml'     => $str_duoDataUse,
        'toolName.yaml'       => $str_toolName,
        'toolReferences.yaml' => $str_toolreferences,
        'ontologyTerm.yaml'   => $str_ontologyTerm
    );
    return $yaml{$file};
}

sub add_tabs_with_examples {

    # This subroutine is quick workaround to embed json links directly in Markdown
    # We dound two alternatives for mkdocs
    # A - https://pypi.org/project/mkdocs-embed-external-markdown/
    #     Suboptimal - Only embed .md (not json) and issues with {{}} syntax
    # B - https://pypi.org/project/mkdocs-include-markdown-plugin/
    #     To be tested (Apr-01-2022)
    my $schema = shift;
    my $dir =
      catdir( '../models/json/beacon-v2-default-model', $schema, 'examples' );
    my $str = <<EOF;

## Examples
These are examples extracted directly from the [GitHub repository](https://github.com/ga4gh-beacon/beacon-v2-Models).

EOF

    #=== "MIN"
    #
    #        ```
    #        {
    #        }
    #        ```

    # Will process al JSON files but only retain those having MAX, MIN or MID
    # ---- biosample-MID-example.json  biosample-MIN-example.json -----
    foreach my $file ( reverse sort glob("$dir/*.json") ) {
        my $filename = basename($file);
        my @tmp      = split /\-/, $filename;
        my $label    = uc( $tmp[1] );
        next unless ( $label eq 'MAX' || $label eq 'MID' || $label eq 'MIN' );
        $str .= "=== \"$label\"\n";
        $str .= "\t```json\n";
        open my $fh, "<", $file;
        while (<$fh>) {
            $str .= "\t$_";
        }
        close $fh;
        $str .= "\n\t```\n\n";
    }
    return $str;
}

sub parse_json_keywords {

    # We'll be using JSON Pointer to facilitate the search
    my ( $property, $data ) = @_;
    my $pointer = Mojo::JSON::Pointer->new($data);

    # Defining some info (for > 1D we should be able to take this info from properties/type/const)
    # but we have sub nested $keywords that complicate a lot the task
    my $terms = {
        'variation' =>
          [ 'MolecularVariation', 'SystemicVariation', 'LegacyVariation' ],
        'SystemicVariation'  => ['CopyNumber'],
        'MolecularVariation' => [ 'Allele',        'Haplotype' ],
        'location'           => [ 'CURIE',         'Location' ],
        'state'              => [ 'SequenceState', 'SequenceExpression' ],
        'Value'              => [ 'Quantity',      'ontologyTerm' ]
    };

    # We'll be checking <oneOf allOf anyOf>
    for my $keyword (qw(oneOf allOf anyOf)) {

        if ( $pointer->contains("/$keyword") ) {

            #say "$property has /$keyword";
            my $tmp_hash;
            $tmp_hash->{type} = $keyword;

            my $count = 0;
            for my $elements ( @{ $data->{$keyword} } ) {

                #if ($pointer->contains("/$keyword/$property/$count/properties/type/const")) {
                #  say "Route pointer const /$keyword/$property/$count/properties/type/const";
                #  my $const = $pointer->get("/$keyword/$property/$count/properties/type/const");
                #   $tmp_hash->{properties}{$const} = $elements;
                #} else{
                my $tmp_term =
                  (      $pointer->contains("/$keyword/$count/title")
                      && $pointer->get("/$keyword/$count/title") ne
                      'Ontology Term' )
                  ? $pointer->get("/$keyword/$count/title")
                  : @{ $terms->{$property} }[$count];
                $tmp_hash->{properties}{$tmp_term} = $elements if $tmp_term;   # Ad-hoc some terms appear duplicated and come empty....
                                                                               #}
                $count++;
            }
            $data = $tmp_hash;                                                 # Adding new reference
        }
    }
    return $data;
}

sub add_properties_vrs {

    my ( $property, $data ) = @_;
    my %url = (
        'SequenceExpression' =>
'https://w3id.org/ga4gh/schema/vrs/1.3/vrs.json#/definitions/',
        'CopyNumber' =>
'https://w3id.org/ga4gh/schema/vrs/1.3/vrs.json#/definitions/'
    );
    if ( exists $url{$property} ) {
        $data->{properties} =
            "[VRS definition for $property]" . '('
          . $url{$property}
          . $property . ')';
    }
    return $data;
}

1;

=head1 NAME

beacon_yaml2md: Script to convert Beacon v2 Models schemas to Markdown tables


=head1 SYNOPSIS


beacon_yaml2md.pl

     Options:
       -schema-dir                    Directory with YAML schemas
       -markdown-dir                  Directory where to write .md
       -D|delete                      Delete schema-dir/obj/*yaml
       -h|help                        Brief help message
       -man                           Full documentation
       -debug                         Print debugging (from 1 to 5, being 5 max)
       -verbose                       Verbosity on


=head1 CITATION

To be defined.

=head1 SUMMARY

beacon_yaml2md: Script to convert Beacon v2 Models schemas to Markdown tables

B<NOTE:> This script is B<UNDER CONSTRUCTION> and improvements are added often.

=head1 MOTIVATION

Prior to the creation of this script (i.e.,June-2021), the Beacon documentation for the schemas was first created in a text-type document (e.g., Word) and then MANUALLY transformed into
YAMLs schemas. Each time the original MS Word document was edited, someone had to manually edit the YAML.

This script inverts the process, i.e., B<it enforces modifying the schema specification directly at the YAML/JSON level>.

Editing the schemas directly at the YAML/JSON level has two advantages, the first is that because we follow L<OpenAPI|https://swagger.io/specification/> specification (along with JSON schema), I<a priori> we could use L<SWAGGER UI|https://swagger.io/docs/open-source-tools/swagger-ui/usage/installation>. The second is that the YAML/JSON files can be converted to Markdown tables in order to create L<Markdown based documentation|https://docs.genomebeacons.org> documentation. This script B<transforms YAML/JSON to Markdown tables>, including their nested objects B<up to a third degree of hierarchy>.

The B<Markdown> format can be directly rendered as tables at the GitHub repository, and it can be used with L<MkDocs|https://www.mkdocs.org/> to create L<HTML|https://docs.genomebeacons.org> documentation. 

Everytime a C<git push> is performed to the L<repo|https://github.com/ga4gh-beacon/beacon-v2> the documentation at L<Github Pages|https://docs.genomebeacons.org> gets updated. Note that only content under directory C<docs/> will make it to L<Github Pages|https://docs.genomebeacons.org>.

Before creating this tool, the author made an exhaustive search on what had been dveloped by the I<community> to automatically convert YAML/JSON to Markdown tables and found that there were many ways to go from YAML/JSON to HTML (e.g., CPAN, Python, Node.js), but not much from YAML/JSON to Markdown. Obviously, even in the case we had found something, some major tweaking will be needed in order to display things the way we want.

In the Beacon context, I<mbaudis> has developed a nice framework for L<schemablocks|https://github.com/ga4gh-schemablocks/schemablocks-tools> which creates HTML from YAML schemas to be used with L<Yekyll|https://jekyllrb.com/>. However, personalizing his tools to work in our scenario will still not solve the initial objective of creating Markdown tables from the YAML/JSON.

All of the above lead to the creation of this tool, which was written in L<Perl|https://www.perl.org> language.

=head2 ADDENDUM: How to update the Documentation

There are several steps that need to be peformed to update the documentation:

   1 - Install C<nodejs>.

      $ sudo apt install nodejs

      The reason for installing JS is that we need it to convert JSON files with JSON references ($ref) to JSON files with no references (i.e., all references will be embeded in the file).

   2 - Now run the script:
    
     $ # cd bin # skip this step if you are already at bin directory

     $ ./transform_json2md.sh

     $ cd ..

     $ git add docs/schemas-md

   3 - Finally you need to push beacon-v2 repo to GitHub.

   4 - Documentation will get automatically updated via GitHub actions.


=head1 HOW TO RUN BEACON_YAML2MD

The script is written in Perl and runs on Linux (tested on Debian-based distribution). Perl 5 is installed by default on Linux, 
but you might need to install some CPAN module(s).

First we install cpanminus (with sudo privileges):

   $ sudo apt-get install cpanminus

Then the module(s):

   $ cpanm --sudo --installdeps .

If you prefer to have the dependencies in a "virtual environment" (i.e., install the CPAN modules in the directory of the application) we recommend using the module C<Carton>.

   $ cpanm --sudo Carton

Then, we can install our dependencies:

   $ carton install

The script takes YAMLs as input file and when no arguments is used it will read them from C<./deref_schemas/> directory.

B<NB:> We recommend running the script with the provided bash file C<transform_yaml2md.sh> (B<see ADDENDUM: How to update Documentation>).

B<Example 1:>

   $ ./beacon_yaml2md.pl 

   $ carton exec -- ./beacon_yaml2md.pl # if using Carton

If the script is run directly at C<bin/> directory (default) and with no arguments, then it will create contents in:

    * Markdowns at ../docs/schemas-md/


B<Example 2:>

Here we are providind arguments for --schema-dir and for markdown-dir.

   $ $path/beacon_yaml2md.pl --schema-dir ./deref_schemas --markdown-dir ../docs/schemas-md --D


I<NB:> if the YAML is not well defined (e.g., wrong indentation, etc.) the script will complain about it. Thus, it indirectly serves as a YAML validator.

B<Notes:>

The argument C<-D|delete> deletes all C<./deref_schemas/obj/*yaml> files prior to doing anything else. It's harmless so you may want to use it you're unsure of who created those files.

See the directory tree below:

C<
```
 beacon-v2/
 |-- bin
 |-- docs
 |   |-- img
 |   `-- schemas-md
 |       `-- obj
```
>

I<NB:> The script was built to work with the Beacon v2 Model schemas and the author deliberately chose to hard-code some variables (e.g., the I<schemas>) to avoid extra arguments or a config.file. However, this may change in future versions depending on user's adoption/feedback.

I<NB:> The decission to take YAMLs (and not JSON) as an input is deliberate and made by the author.

I<NB:> The script only processes the C<Terms> nested B<up to 3 degrees of hierarchy>. Before Adoption of VRS/PXF that limit was OK.

I<NB:> The script also includes the Beacon v2 Models examples from L<beacon-v2 repo|https://github.com/ga4gh-beacon/beacon-v2> in JSON format.

=head1 AUTHOR 

Written by Manuel Rueda, PhD. Info about EGA can be found at L<https://ega-archive.org/>.

=head1 KNOWN ISSUES

    * If two entities share a term/object (e.g., id, label) the text will correspond to the latest one (alphabetical order). "Ideally" all shared-objects should have a common description, shouldn't them? This way we avoid having to create sub-objects for every entity.
    * As of April 2022 we're only processing 3 levels of nesting and adding external URLs for deeper levels.
    * We are not processing <if: then:> statements in JSON Schema.

=head1 REPORTING BUGS

Report bugs or comments to <manuel.rueda@crg.eu>.

=head1 COPYRIGHT

This PERL file is copyrighted. See the LICENSE file included in this distribution.

=cut
