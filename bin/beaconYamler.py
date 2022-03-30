#!/usr/local/bin/python3

import sys, re, json
import pathlib
import argparse
from ruamel.yaml import YAML
from os import path as path
from os import scandir as scandir
from os import remove as deleteFile
from collections import OrderedDict

here_path = path.dirname( path.abspath(__file__) )
this_script = re.sub(".py", ".yaml", path.basename( __file__ ) )
yaml = YAML()
yaml.indent(mapping=2, sequence=4, offset=2)
with open(path.join( here_path, "config", this_script), 'r') as c_f:
    config = yaml.load( c_f )

"""podmd
The script converts files in directories between yaml <-> json
It requires the specification of input and output directories and file formats.
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
    parser.add_argument("-v", "--verbose", help="Show conversion details.", default=False)

    return parser.parse_args()

################################################################################

def main():

    args = _get_args()
    in_path = pathlib.Path(args.inpath)
    out_path = pathlib.Path(args.outpath)
    from_type = args.filetype
    to_type = args.exporttype

    config.update({ "args": args, "from_type": from_type, "to_type": to_type} )

    for p in [in_path, out_path]:
        if not p.is_dir():
            print("¡¡¡ WARNING: No directory in {}!!!".format(p))
            exit()

    for t in [from_type, to_type]:
        if t not in config["supported_types"]:
            print("¡¡¡ WARNING: Only {} are supported!!!".format(join(config["supported_types"])))
            exit()

    convert_dir(in_path, out_path, from_type, to_type, config)

################################################################################

def convert_dir(in_path, out_path, from_type, to_type, config):

    pathlib.Path(out_path).mkdir( exist_ok=True )

    if config["delete_existing_files"] is True:
        for f in scandir(out_path):
            if to_type in pathlib.Path(f).suffix and f.is_file():
                deleteFile(f)

    fs = [ f.name for f in scandir(in_path) if f.is_file() ]
    fs = [ f for f in fs if f.endswith(from_type) ]

    conversion_method = "_{}2{}".format(from_type, to_type)

    for f_n in fs:
        eval(conversion_method)(f_n, in_path, out_path, config)

    d_s = [ d.name for d in scandir(in_path) if d.is_dir() ]
    for d in d_s:
        in_d = path.join( in_path, d )
        out_d = path.join( out_path, d )

        convert_dir(in_d, out_d, from_type, to_type, config)

################################################################################

def _yaml2json(f_n, in_path, out_path, config):

    in_file = path.join( in_path, f_n)
    o_n = re.sub(r"\.yaml", ".json", f_n)
    out_file = path.join( out_path, o_n)

    _file_conversion_message(config, in_file, out_file)
    i_d = _file_read_and_clean(in_file, config)

    try:
        s = yaml.load( i_d )
    except Exception as e:
        print("\n¡¡¡¡¡ ###########################\n{}".format(in_file))
        print(e)
        print("########################### !!!!!\n")
        return()

    _par_replace(s, config)
    with open(out_file, 'w') as out_f:
        out_f.write(json.dumps(OrderedDict(s), indent=4, sort_keys=True, default=str))

################################################################################

def _yaml2yaml(f_n, in_path, out_path, config):

    in_file = path.join( in_path, f_n)
    o_n = f_n
    out_file = path.join( out_path, f_n)

    _file_conversion_message(config, in_file, out_file)
    i_d = _file_read_and_clean(in_file, config)

    try:
        s = yaml.load( i_d )
    except Exception as e:
        _file_conversion_error(e, in_file)
        return

    _par_replace(s, config)
    with open(out_file, 'w') as out_f:
        yaml.dump(s, out_f)

################################################################################

def _json2yaml(f_n, in_path, out_path, config):

    in_file = path.join( in_path, f_n)
    o_n = re.sub(r"\.json", ".yaml", f_n)
    out_file = path.join( out_path, o_n)

    _file_conversion_message(config, in_file, out_file)
    i_d = _file_read_and_clean(in_file, config)

    try:
        s = json.loads(i_d)
    except Exception as e:
        _file_conversion_error(e, in_file)
        return

    _par_replace(s, config)
    with open(out_file, 'w') as out_f:
        yaml.dump(s, out_f)

################################################################################

def _json2json(f_n, in_path, out_path, config):

    in_file = path.join( in_path, f_n)
    o_n = f_n
    out_file = path.join( out_path, o_n)

    _file_conversion_message(config, in_file, out_file)
    i_d = _file_read_and_clean(in_file, config)
    try:
        s = json.loads(i_d)
    except Exception as e:
        _file_conversion_error(e, in_file)
        return

    _par_replace(s, config)
    with open(out_file, 'w') as out_f:
        yaml.dump(s, out_f)

################################################################################

def _file_read_and_clean(in_file, config):

    with open(in_file, 'r') as in_f:
        f_t = in_f.read()
        in_f.close()
    
    f_t = _text_replace(f_t, config)

    return f_t

################################################################################

def _text_replace(text, config):

    for r in config["replace_text"]:
        text = text.replace(r["from"], r["to"])

    return text

################################################################################

def _par_replace(schema, config):

    for r, rv in config["replace_vals"].items():
        if r in schema:
            schema.update({r: rv["replaceValue"]})
        else:
            if "add" in r:
                if rv["add"] is True:
                    schema.update({r: rv["replaceValue"]})

    return schema

################################################################################

def _file_conversion_error(e, f):

    print("\n¡¡¡¡¡ ######################################################\n{}".format(f))
    print(e)
    print("###################################################### !!!!!\n")

    return

################################################################################

def _file_conversion_message(config, in_file, out_file):

    if config["args"].verbose is False:
        return 

    print("converting {}\n        => {}".format(in_file, out_file))
    return

################################################################################
################################################################################
################################################################################

if __name__ == '__main__':
    main(  )
