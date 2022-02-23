#!/usr/local/bin/python3

import sys, re, json
from ruamel.yaml import YAML
from os import path as path
from os import scandir as scandir
from os import remove as deleteFile
import argparse
import pathlib
from collections import OrderedDict

here_path = path.dirname( path.abspath(__file__) )
yaml = YAML()
yaml.indent(mapping=2, sequence=4, offset=2)

"""podmd
The script converts yaml <-> json, either a single file or all files of a given
directory. If converting a directory, the input file type has to be specified.

podmd"""

################################################################################
################################################################################
################################################################################

def _get_args():

    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--inpath", help="File or directory to be converted.", required=True)
    parser.add_argument("-o", "--outpath", help="Directory to be saved to.", required=True)
    parser.add_argument("-t", "--filetype", help="File type to convert from; for directory parsing.", required=True)
    parser.add_argument("-x", "--exporttype", help="File type to convert to.", required=True)

    return parser.parse_args()

################################################################################

def main():

    """podmd
    end_podmd"""

    supported = ["json", "yaml"]

    args = _get_args()
    in_path = pathlib.Path(args.inpath)
    out_path = pathlib.Path(args.outpath)
    from_type = args.filetype
    to_type = args.exporttype

    for p in [in_path, out_path]:
        if not p.is_dir():
            print("¡¡¡ WARNING: No directory in {}!!!".format(p))
            exit()

    for t in [from_type, to_type]:
        if t not in supported:
            print("¡¡¡ WARNING: Only {} are supported!!!".format(join(supported)))
            exit()
    
    with open(path.join( here_path, "config.yaml"), 'r') as c_f:
        config = yaml.load( c_f )
        c_f.close()

    convert_dir(in_path, out_path, from_type, to_type, config)

################################################################################

def convert_dir(in_path, out_path, from_type, to_type, config):

    pathlib.Path(out_path).mkdir( parents=True, exist_ok=True )

    fs = [ f.name for f in scandir(in_path) if f.is_file() ]
    fs = [ f for f in fs if f.endswith(from_type) ]
    for f_n in fs:
        if "yaml" in from_type:
            if "yaml" in to_type:
                yaml2yaml(f_n, in_path, out_path, config)
            else:
                yaml2json(f_n, in_path, out_path, config)
        elif "json" in from_type:
            json2yaml(f_n, in_path, out_path, config)

    d_s = [ d.name for d in scandir(in_path) if d.is_dir() ]
    for d in d_s:
        in_d = path.join( in_path, d )
        out_d = path.join( out_path, d )

        convert_dir(in_d, out_d, from_type, to_type, config)

################################################################################

def yaml2json(f_n, in_path, out_path, config):

    in_file = path.join( in_path, f_n)
    o_n = re.sub(r"\.yaml", ".json", f_n)
    out_file = path.join( out_path, o_n)

    with open(in_file, 'r') as in_f:
        i_d = in_f.read()
        in_f.close()
        i_d = text_replace(i_d, config)
        s = yaml.load( i_d )
        par_replace(s, config)
        with open(out_file, 'w') as out_f:
            out_f.write(json.dumps(OrderedDict(s), indent=4, sort_keys=True, default=str))
            out_f.close()

################################################################################

def yaml2yaml(f_n, in_path, out_path, config):

    in_file = path.join( in_path, f_n)
    o_n = f_n
    out_file = path.join( out_path, f_n)

    with open(in_file, 'r') as in_f:
        i_d = in_f.read()
        in_f.close()
        i_d = text_replace(i_d, config)
        s = yaml.load( i_d )
        par_replace(s, config)
        with open(out_file, 'w') as out_f:
            yaml.dump(s, out_f)
            out_f.close()

################################################################################

def json2yaml(f_n, in_path, out_path, config):

    in_file = path.join( in_path, f_n)
    o_n = re.sub(r"\.json", ".yaml", f_n)
    out_file = path.join( out_path, o_n)

    with open(in_file, 'r') as in_f:
        i_d = in_f.read()
        in_f.close()
        i_d = text_replace(i_d, config)
        s = json.loads(i_d)
        par_replace(s, config)
        with open(out_file, 'w') as out_f:
            yaml.dump(s, out_f)
            out_f.close()

################################################################################

def json2json(f_n, in_path, out_path, config):

    in_file = path.join( in_path, f_n)
    o_n = f_n
    out_file = path.join( out_path, o_n)

    with open(in_file, 'r') as in_f:
        i_d = in_f.read()
        in_f.close()
        s = json.loads(i_d)
        par_replace(s, config)
        with open(out_file, 'w') as out_f:
            yaml.dump(s, out_f)
            out_f.close()

################################################################################

def text_replace(text, config):

    for r in config["replace_text"]:
        text = text.replace(r["from"], r["to"])

    return text

################################################################################

def par_replace(schema, config):

    for r, rv in config["replace_vals"].items():
        if r in schema:
            schema.update({r: rv["replaceValue"]})
        else:
            if "add" in r:
                if rv["add"] is True:
                    schema.update({r: rv["replaceValue"]})

    return schema

################################################################################
################################################################################

if __name__ == '__main__':
    main(  )
