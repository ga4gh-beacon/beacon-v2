#!/usr/bin/env perl
#
#   Script to convert Beacon v2 Model schemas to Markdown
#
#   Last Modified: Jan/13/2022
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
    my $schema_dir   = '../schemas';
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

    my $schema_obj_dir   = catdir( $schema_dir,   $obj );
    my $markdown_obj_dir = catdir( $markdown_dir, $obj );
    my $raa_header       = [qw(Field Description Type Properties Example Enum)];

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
use Path::Tiny;
use Data::Dumper;
use File::Spec::Functions qw(catdir catfile);

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

    # Instead of working directly with recursive hash slices, for xD we create
    # one YAML file for each property and then re-use code from the 'main' schema

    for my $property (@$ra_properties) {

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
                dump_yaml( $property, $yaml_properties_3d->{$property},
                    $yo_dir );
            }
        }

    }
    return ( $yaml_properties, $ra_properties );
}

sub table_content {

    my ( $yaml_properties, $ra_properties, $headers, $obj, $link ) = @_;
    my $out_str = '';
    for my $property ( sort @$ra_properties ) {
        my @refs = ();
        for my $value ( $yaml_properties->{$property} ) {

            for my $header (@$headers) {
                next if $header eq 'Field';
                $header = lc($header);
                my $value_header = $value->{$header};

                # Check presence of plural 'examples'
                $value_header =
                  exists $value->{examples}
                  ? $value->{examples}
                  : $value->{$header}
                  if $header eq 'example';

                # Slice differentely if $value->{type} eq 'array'
                $value_header = $value->{items}{properties} if ( $header eq 'properties' && $value->{type} eq 'array' );

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
    # We can have ARRAY, HASH and STRING
    if ( ref $data eq 'ARRAY' ) {

        # Options found: A, AoH, AoHoH
        my $array_type = ref $data->[0];

        # AoH
        if ( $array_type eq 'HASH' ) {
            my @tmp;
            for my $i ( 0 .. $#{$data} ) {
                my $r_data_i = $data->[$i];
                push @tmp, join ', ',
                  map { $_ = "$_:$r_data_i->{$_}" } sort keys %$r_data_i; # Note ', ' to allow HTML column rendering
            }
            $out_str = join '<br />', @tmp;
        }

        # A
        else {
            # We can have strings or array references (end.md, start.md)
            if ( ref $data->[0] eq 'ARRAY' ) {
                my @tmp;
                for my $i ( 0 .. $#{$data} ) {
                    my $tmp_str = join ',', @{ $data->[$i] };
                    push @tmp, "[$tmp_str]";
                }
                $out_str = join '<br />', @tmp;
            }
            else {
                $out_str = defined $data->[0] ? join ', ', @$data : 'NA'; # Note ', ' to allow HTML column rendering
            }
        }
    }

    elsif ( ref $data eq 'HASH' ) {

        #print Dumper $data;
        my $tmp_str = $link ? "./$obj" : '.';
        $out_str = join ', ',
          map { $_ = "[$_]($tmp_str/$_.md)" } sort keys %$data; # Note ', ' to allow HTML column rendering
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
    - url: http://www.ensembl.org/vep
  type: object
EOF

    my %yaml = (
        'duoDataUse.yaml'     => $str_duoDataUse,
        'toolName.yaml'       => $str_toolName,
        'toolReferences.yaml' => $str_toolreferences
    );
    return $yaml{$file};
}

1;

=head1 NAME

beacon_yaml2md: Script to convert Beacon v2 Model schemas to Markdown


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

beacon_yaml2md: Script to convert Beacon v2 Model schemas to Markdown

B<NOTE:> This script is B<UNDER CONSTRUCTION> and improvements are added often.

=head1 MOTIVATION

Prior to the creation of this script (i.e.,June-2021), the Beacon documentation for the schemas was first created in a text-type document (e.g., Word) and then MANUALLY transformed into
YAMLs schemas. Each time the original MS Word document was edited, someone had to manually edit the YAML.

This script inverts the process, i.e., B<it enforces modifying the schema specification directly at the YAML/JSON level>.

Editing the schemas directly at the YAML/JSON leven has two advantages, the first is that (because we follow L<OpenAPI|https://swagger.io/specification/> specifications) the endpoints documentation can be directly displayed with L<SWAGGER UI|https://ga4gh-approval-service-registry.ega-archive.org>. The second is that the YAML/JSON files can be converted to Markdown tables in order to create L<Read The Docs|https://beacon-schema-2.readthedocs.io/en/latest/> documentation. This script B<transforms YAML/JSON to Markdown tables>, including their nested objects up to a third degree of hierarchy.

The B<Markdown> format can be directly rendered as tables at the L<GitHub repository|https://github.com/mrueda/beacon-schema-2/tree/main/docs/schemas-md>, and it can be used  with L<MkDocs|https://www.mkdocs.org/> to create  L<Read The Docs|https://beacon-schema-2.readthedocs.io/en/latest/> documentation. 

Everytime a C<git push> is performed to the L<repo|https://github.com/mrueda/beacon-schema-2> the documentation at L<Read The Docs|https://beacon-schema-2.readthedocs.io/en/latest/> gets updated. Note that only content under directory C<docs/> will make it to L<Read The Docs|https://beacon-schema-2.readthedocs.io/en/latest/>.

Before creating this tool, the author made an exhaustive search on what had been dveloped by the I<community> to automatically convert YAML/JSON to Markdown tables and found that there were many ways to go from YAML/JSON to HTML (e.g., CPAN, Python, Node.js), but not much from YAML/JSON to Markdown. Obviously, even in the case we had found something, some major tweaking will be needed in order to display things the way we want.

In the Beacon context, I<mbaudis> has developed a nice framework for L<schemablocks|https://github.com/ga4gh-schemablocks/schemablocks-tools> which creates HTML from YAML schemas to be used with L<Yekyll|https://jekyllrb.com/>. However, personalizing his tools to work in our scenario will still not solve the initial objective of creating Markdown tables from the YAML/JSON.

All of the above lead to the creation of this tool, which was written in L<Perl|https://www.perl.org> language.


=head1 HOW TO RUN BEACON_YAML2MD

The script is written in Perl and runs on Linux (tested on Debian-based distribution). Perl 5 is installed by default on Linux, 
but you might need to manually install the below CPAN module(s).

    * YAML::XS
    * JSON::XS
    * Path::Tiny

First we install cpanminus (with sudo privileges):

   $ sudo apt-get install cpanminus

Then the module(s):

   $ cpanm --sudo YAML::XS JSON::XS Path::Tiny

The script takes YAMLs as input file and when no arguments is used it will read them from C<../schemas/> directory.

B<NB:> We recommend running the script with the provided bash file C<transform_yaml2md.sh> (B<see ADDENDUM: How to update Read The Docs documentation>).

B<Example 1:>

   $ ./beacon_yaml2md.pl 

If the script is run directly at C<bin/> directory (default) and with no arguments, then it will create contents in:

    * YAMLs at ../schemas/
    * Markdowns at ../docs/schemas-md/


B<Example 2:>

Here we are providind arguments for --schema-dir and for markdown-dir.

   $ $path/beacon_yaml2md.pl --schema-dir ../schemas --markdown-dir ../docs/schemas-md --D


I<NB:> if the YAML is not well defined (e.g., wrong indentation, etc.) the script will complain about it. Thus, it indirectly serves as a YAML validator.

B<Notes:>

The argument C<-D|delete> deletes all C<../schemas/obj/*yaml> files prior to doing anything else. It's harmless so you may want to use it you're unsure of who created those files.

See the directory tree below:

C<
```
 beacon-schema-2/
 |-- bin
 |-- docs
 |   |-- img
 |   `-- schemas-md
 |       `-- obj
 `-- schemas
     `-- obj
```
>

I<NB:> The script was built to work with the Beacon v2 Model schemas and the author deliberately chose to hard-code some variables (e.g., the I<schemas>) to avoid extra arguments or a config.file. However, this may change in future versions depending on user's adoption/feedback.

I<NB:> The decission to take YAMLs (and not JSON) as an input is deliberate and made by the author.


=head2 ADDENDUM: How to update Read The Docs documentation

There are several steps that need to be peformed to update readthedocs:

   1 - Clone or download:

     a ) Beacon v2 Models from L<Github|https://github.com/ga4gh-beacon/beacon-v2-Models>.

     b ) Beacon framework v2 from L<Github|https://github.com/ga4gh-beacon/beacon-framework-v2>.

   2 - Install C<jsonref> and C<jq>.

      $ sudo pip3 install jsonref #  Python 2 => sudo pip install jsonref

      The reason for installing this tool is that we need it to convert JSON files with JSON references ($ref) to JSON files with no references (i.e., all references will be embeded in the file).

      $ sudo apt-get install jq

      Tool needed to parse JSON files.

   3 - Modify the two variables 'mod_dir' and 'fw_dir' inside transform_json2md.sh according to the paths from Step 1:
       
   4 - Inside 'bin' directory run:

     $ ./transform_json2md.sh

     $ cd ..
     
     $ git add schemas docs 

   5 - Finally you need to push beacon-schema-2 repo to GitHub.

   6 - Readthedocs should be updated.


=head1 AUTHOR 

Written by Manuel Rueda, PhD. Info about EGA can be found at L<https://ega-archive.org/>.


=head1 REPORTING BUGS

Report bugs or comments to <manuel.rueda@crg.eu>.


=head1 COPYRIGHT

This PERL file is copyrighted. See the LICENSE file included in this distribution.

=cut
