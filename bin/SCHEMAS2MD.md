# NAME

beacon\_yaml2md: Script to convert Beacon v2 Models schemas to Markdown tables

# SYNOPSIS

beacon\_yaml2md.pl

     Options:
       -schema-dir                    Directory with YAML schemas
       -markdown-dir                  Directory where to write .md
       -D|delete                      Delete schema-dir/obj/*yaml
       -h|help                        Brief help message
       -man                           Full documentation
       -debug                         Print debugging (from 1 to 5, being 5 max)
       -verbose                       Verbosity on

# CITATION

To be defined.

# SUMMARY

beacon\_yaml2md: Script to convert Beacon v2 Models schemas to Markdown tables

**NOTE:** This script is **UNDER CONSTRUCTION** and improvements are added often.

# MOTIVATION

Prior to the creation of this script (i.e.,June-2021), the Beacon documentation for the schemas was first created in a text-type document (e.g., Word) and then MANUALLY transformed into
YAMLs schemas. Each time the original MS Word document was edited, someone had to manually edit the YAML.

This script inverts the process, i.e., **it enforces modifying the schema specification directly at the YAML/JSON level**.

Editing the schemas directly at the YAML/JSON level has two advantages, the first is that because we follow [OpenAPI](https://swagger.io/specification/) specification (along with JSON schema), _a priori_ we could use [SWAGGER UI](https://swagger.io/docs/open-source-tools/swagger-ui/usage/installation). The second is that the YAML/JSON files can be converted to Markdown tables in order to create [Markdown based documentation](http://docs.genomebeacons.org) documentation. This script **transforms YAML/JSON to Markdown tables**, including their nested objects **up to a third degree of hierarchy**.

The **Markdown** format can be directly rendered as tables at the GitHub repository, and it can be used with [MkDocs](https://www.mkdocs.org/) to create [HTML](http://docs.genomebeacons.org) documentation. 

Everytime a `git push` is performed to the [repo](https://github.com/ga4gh-beacon/beacon-v2) the documentation at [Github Pages](http://docs.genomebeacons.org) gets updated. Note that only content under directory `docs/` will make it to [Github Pages](http://docs.genomebeacons.org).

Before creating this tool, the author made an exhaustive search on what had been dveloped by the _community_ to automatically convert YAML/JSON to Markdown tables and found that there were many ways to go from YAML/JSON to HTML (e.g., CPAN, Python, Node.js), but not much from YAML/JSON to Markdown. Obviously, even in the case we had found something, some major tweaking will be needed in order to display things the way we want.

In the Beacon context, _mbaudis_ has developed a nice framework for [schemablocks](https://github.com/ga4gh-schemablocks/schemablocks-tools) which creates HTML from YAML schemas to be used with [Yekyll](https://jekyllrb.com/). However, personalizing his tools to work in our scenario will still not solve the initial objective of creating Markdown tables from the YAML/JSON.

All of the above lead to the creation of this tool, which was written in [Perl](https://www.perl.org) language.

## ADDENDUM: How to update Documentation

There are several steps that need to be peformed to update the documentation:

    1 - Install C<jsonref>.

       $ sudo pip3 install jsonref #  Python 2 => sudo pip install jsonref

       The reason for installing this tool is that we need it to convert JSON files with JSON references ($ref) to JSON files with no references (i.e., all references will be embeded in the file).

    2 - Modify the two variables 'mod_dir' and 'fw_dir' inside transform_json2md.sh according to the Models and Framework directories.

    4 - Now run the script:
     
      $ # cd bin # skip this step if you are already at bin directory

      $ ./transform_json2md.sh

      $ cd ..

      $ git add docs/schemas-md

    5 - Finally you need to push beacon-v2 repo to GitHub.

    6 - Documentation will get automatically updated via GitHub actions.

# HOW TO RUN BEACON\_YAML2MD

The script is written in Perl and runs on Linux (tested on Debian-based distribution). Perl 5 is installed by default on Linux, 
but you might need to manually install the below CPAN module(s).

    * YAML::XS
    * JSON::XS
    * Path::Tiny
    * Mojo::JSON::Pointer
    * List::MoreUtils

First we install cpanminus (with sudo privileges):

    $ sudo apt-get install cpanminus

Then the module(s):

    $ cpanm --sudo YAML::XS JSON::XS Path::Tiny Mojo::JSON::Pointer List::MoreUtils

The script takes YAMLs as input file and when no arguments is used it will read them from `./deref_schemas/` directory.

**NB:** We recommend running the script with the provided bash file `transform_yaml2md.sh` (**see ADDENDUM: How to update Documentation**).

**Example 1:**

    $ ./beacon_yaml2md.pl 

If the script is run directly at `bin/` directory (default) and with no arguments, then it will create contents in:

    * Markdowns at ../docs/schemas-md/

**Example 2:**

Here we are providind arguments for --schema-dir and for markdown-dir.

    $ $path/beacon_yaml2md.pl --schema-dir ./deref_schemas --markdown-dir ../docs/schemas-md --D

_NB:_ if the YAML is not well defined (e.g., wrong indentation, etc.) the script will complain about it. Thus, it indirectly serves as a YAML validator.

**Notes:**

The argument `-D|delete` deletes all `./deref_schemas/obj/*yaml` files prior to doing anything else. It's harmless so you may want to use it you're unsure of who created those files.

See the directory tree below:

```` 
```
 beacon-v2/
 |-- bin
 |-- docs
 |   |-- img
 |   `-- schemas-md
 |       `-- obj
```
 ````

_NB:_ The script was built to work with the Beacon v2 Model schemas and the author deliberately chose to hard-code some variables (e.g., the _schemas_) to avoid extra arguments or a config.file. However, this may change in future versions depending on user's adoption/feedback.

_NB:_ The decission to take YAMLs (and not JSON) as an input is deliberate and made by the author.

_NB:_ The script only processes the `Terms` nested **up to 3 degrees of hierarchy**. Before Adoption of VRS/PHX that limit was OK.

_NB:_ The script also includes the Beacon v2 Models examples from [beacon-v2 repo](https://github.com/ga4gh-beacon/beacon-v2) in JSON format.

# AUTHOR 

Written by Manuel Rueda, PhD. Info about EGA can be found at [https://ega-archive.org/](https://ega-archive.org/).

# KNOWN ISSUES

    * If two entities share a term/object (e.g., id, label) the text will correspond to the latest one (alphabetical order). "Ideally" all shared-objects should have a common description, shouldn't them? This way we avoid having to create sub-objects for every entity.
    * As of April 2022 we're only processing 3 levels of nesting and adding external URLs for deeper levels.
    * We are not processing <if: then:> statements in JSON Schema.

# REPORTING BUGS

Report bugs or comments to <manuel.rueda@crg.eu>.

# COPYRIGHT

This PERL file is copyrighted. See the LICENSE file included in this distribution.
