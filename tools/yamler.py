#!/usr/local/bin/python3

import sys, re, json
from ruamel.yaml import YAML
from os import path as path
from os import scandir as scandir
from os import remove as deleteFile
import argparse
import pathlib
from distutils.dir_util import copy_tree
from collections import OrderedDict

"""podmd
The script converts yaml <-> json, either a single file or all files of a given
directory. If converting a directory, the input file type has to be specified.

* `./yamler.py -i ~/GitHub/ga4gh-beacon/beacon-v2-Models/BEACON-V2-draft4-Model/ --filetype json`
* `./yamler.py -i ~/GitHub/ga4gh-beacon/beacon-v2-Models/TEMPLATE-Model/beaconMap.json`

podmd"""

################################################################################
################################################################################
################################################################################

def _get_args():

    parser = argparse.ArgumentParser()
    parser.add_argument("-i", "--inpath", help="File or directory to be converted.", required=True)
    parser.add_argument("-o", "--outpath", help="Directory to be saved to.")
    parser.add_argument("-t", "--filetype", help="File type to convert from; for directory parsing.")
    parser.add_argument("-x", "--exporttype", help="File type to convert to; overwriting the automatic switch.")

    return parser.parse_args()

################################################################################

def main():

    """podmd
    end_podmd"""

    supported = ["json", "yaml"]

    args = _get_args()
    inpath = pathlib.Path(args.inpath)
    clean = False

    if args.exporttype:
        if args.exporttype in supported:
            e_t = ".{}".format(args.exporttype)
        else:
            e_t = False
            print("¡¡¡ WARNING: The exporttype {} is not supported!!!".format(args.exporttype))
    else:
        e_t = False

    if inpath.is_dir():
        if args.outpath:
            op = pathlib.Path(args.outpath)
            if not op.is_dir():
                print()
                print("¡¡¡ Please create the out dir first at {} !!!".format(op.as_posix()))
                exit()               
            copy_tree(inpath.as_posix(), op.as_posix())
            inpath = op
            clean = True
        convert_dir(inpath, supported, clean, e_t, args)
    elif inpath.is_file():
        convert_file(str(inpath), clean, e_t)

################################################################################

def convert_dir(inpath, supported, clean, e_t, args):

    if not args.filetype in supported:
        print()
        print("¡¡¡ If converting a directory, one has to give a correct '--filetype': {} !!!".format(" or ".join(supported)))
        exit()
    fs = [ f.path for f in scandir(inpath) if f.is_file() ]
    for i_f in fs:
        ext = pathlib.PurePosixPath(i_f).suffix
        ext = re.sub(r'\.', "", ext)
        if ext == args.filetype:
            convert_file(i_f, clean, e_t)
        elif clean is True:
            if ext in supported:
                deleteFile(i_f)

    dp = [ d.path for d in scandir(inpath) if d.is_dir() ]

    for d in dp:
        convert_dir(d, supported, clean, e_t, args)

################################################################################

def convert_file(in_file, clean, e_t):

    f_e = pathlib.PurePosixPath(in_file).suffix
    yaml = YAML()
    yaml.indent(mapping=2, sequence=4, offset=2)

    replace = {
        "$schema": { "replaceValue": 'https://json-schema.org/draft/2020-12/schema', "add": False}
    }

    # try:
        
    with open(in_file, 'r') as in_f:

        print(in_file)

        if f_e == ".json":
            i_d = in_f.read()
            in_f.close()
            s = json.loads(i_d)
            par_replace(s, replace)
            if not e_t:
                e_t = ".yaml"
            o_f = re.sub(r"\.json", e_t, in_file)
            if ".yaml" in e_t:
                with open(o_f, 'w') as f:
                    yaml.dump(s, f)
                    print("Dumped to {}".format(o_f))
                    if clean is True:
                        print("deleting {}".format(in_file))
                        deleteFile(in_file)
            elif ".json" in e_t:
                with open(o_f, 'w') as f:
                    f.write(json.dumps(OrderedDict(s), indent=4, sort_keys=True, default=str))
                f.close()
                print("Dumped to {}".format(o_f))

        elif f_e == ".yaml":
            s = yaml.load( in_f )
            par_replace(s, replace)
            if not e_t:
                e_t = ".json"
            o_f = re.sub(r"\.yaml", e_t, in_file)
            if ".json" in e_t:                   
                with open(o_f, 'w') as f:
                    f.write(json.dumps(OrderedDict(s), indent=4, sort_keys=True, default=str))
                f.close()
                print("Dumped to {}".format(o_f))
                if clean is True:
                    print("deleting {}".format(in_file))
                    deleteFile(in_file)
            elif ".yaml" in e_t:
                with open(o_f, 'w') as f:
                    yaml.dump(s, f)
                    print("Dumped to {}".format(o_f))

    # except Exception as e:
    #     print("Error loading the file ({}): {}".format(in_file, e) )

################################################################################

def par_replace(schema, replace):

    for r, rv in replace.items():
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
