#!/usr/bin/python
# -*- coding:UTF-8 -*-
import os
import sys
import re
import xml.etree.ElementTree as ET
import pdb
import fileinput
import json
import chardet

#def open_file(filename, mode):
#    return open(filename, mode, encoding='utf-8')

def open_file(filename, mode):
    with open(filename, mode + 'b') as f:
        rawdata = f.read()
        result = chardet.detect(rawdata)
        encoding = result['encoding']
    return open(filename, mode, encoding=encoding)

def tlog_to_json_on_pgamesvr(_in,_out,tlog_path):
    root = ET.parse(tlog_path).getroot()

    out={}
    desc={}
    out['lines']=[]
    for line in fileinput.FileInput(files=_in,openhook=open_file):
        line_seq=line.strip().split('|')
        if not len(line_seq):
            continue

        #table name 
        cur_dict={}
        header_seq=re.split('[^a-zA-Z0-9]',line_seq[0])
        tablename=header_seq[-1]
        cur_dict['struct_name']=tablename

        cur_struct=root.find('./struct[@name="{}"]'.format(tablename))
        if not cur_struct:
            cur_dict['errormsg']='table not found!'
            out['lines'].append(cur_dict)
            continue

        if tablename not in desc.keys():
            desc[tablename]={}
            desc[tablename][tablename]=cur_struct.get('desc')
            for entry in cur_struct.iterfind('entry'):
                if len(entry.get('desc',''))!=0:
                    desc[tablename][entry.get('name')]=entry.get('desc')
                else:
                    desc[tablename][entry.get('name')]=entry.get('name')
        idx=1
        try:
            for entry in cur_struct.iterfind('entry'):
                if idx < len(line_seq):
                    cur_dict["{}".format(entry.get('name'))]=line_seq[idx]
                idx+=1
        except:
            out['parser_failed'].append(line)
            continue
        out['lines'].append(cur_dict)

    out['table']=desc
    with open(_out,'w',encoding="utf-8") as fileObj:
        json.dump(out,fileObj,indent=4,ensure_ascii=False)

#tlog_path='G:/CodeBase.pgame/pserver/bin/luascript/tlog_desc/generate_tdw/apgame_tdw_tlog.xml'
#in_path="G:/CodeBase.pgame/pserver/.vimtmp.filename.32.txt"
#out_path="G:/CodeBase.pgame/pserver/.vimtmp.filename.33.txt"
#
#tlog_to_json_on_pgamesvr(in_path,out_path,tlog_path)
