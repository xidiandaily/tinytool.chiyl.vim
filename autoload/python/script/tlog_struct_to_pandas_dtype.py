#!/usr/bin/python
# -*- coding:UTF-8 -*-
import os
import sys
import re
import xml.etree.ElementTree as ET
import pdb

type_maps={
        "biguint":"numpy.int64",
        "char":"numpy.int8",
        "float":"numpy.int64",
        "int":"numpy.int64",
        "int16":"numpy.int64",
        "int32":"numpy.int64",
        "int64":"numpy.int64",
        "short":"numpy.int64",
        "uchar":"numpy.int8",
        "uint":"numpy.int64",
        "uint16":"numpy.int64",
        "uint32":"numpy.int64",
        "uint64":"numpy.int64",
        "uint8":"numpy.int64",
        "ulonglong":"numpy.int64",
        "datetime":"\"object\"",
        "string":"\"object\"",
        }

def get_type(oldtype):
    global type_maps
    if oldtype in type_maps.keys():
        return type_maps[oldtype]

    return oldtype

def tlog_struct_to_pandas_dtype(file_in,out):
    try:
        root = ET.parse(file_in)
    except:
        print("fuck")
        with open(out,'w') as fileObj:
            fileObj.write("parser error")

    str_datetime=''
    typelist={}
    for entry in root.findall('entry'):
        mytype=entry.get('type')
        myname=entry.get('name').lower()
        str_out="        \"{}\":{}, #{}\n".format(entry.get('name').lower(),get_type(entry.get('type')),mytype)

        if mytype not in typelist.keys():
            typelist[mytype]=[str_out]
        else:
            typelist[mytype].append(str_out)

        if entry.get('type')=='datetime':
            if str_datetime=='':
                str_datetime="\"{}\"".format(entry.get('name').lower())
            else:
                str_datetime=",\"{}\"".format(entry.get('name').lower())

    with open(out,'w') as fileObj:
        fileObj.write("#example\n")
        fileObj.write("#pd.read_csv('your_file.csv', dtype=dtypes, parse_dates=['eventime'])\n\n")
        fileObj.write("dtypes={\n")
        for t,v in typelist.items():
            fileObj.write("".join(v))
        fileObj.write("        }\n")
        if str_datetime!='':
            fileObj.write("\n\n")
            fileObj.write("parser_dates=[{}]".format(str_datetime))

#tlog_struct_to_pandas_dtype("G:/CodeBase.p4/trunkmain.Server_proj/.vimtmp.in.tlog_struct_to_pandas_dtype","fuck.txt")

