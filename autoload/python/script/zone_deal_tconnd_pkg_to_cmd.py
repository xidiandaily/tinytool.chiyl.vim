#!/usr/bin/python
# -*- coding:UTF-8 -*-
import os
import sys
import re
import xml.etree.ElementTree as ET
import pdb
import fileinput
import json
import inspect

current_file = inspect.getfile(inspect.currentframe())
current_folder = os.path.dirname(os.path.abspath(current_file))
if current_folder not in sys.path:
    sys.path.append(current_folder)
import myutil

def open_file(filename, mode):
    with open(filename, mode + 'b') as f:
        rawdata = f.read()
        result = chardet.detect(rawdata)
        encoding = result['encoding']
    return open(filename, mode, encoding=encoding)

#current_folder = os.path.dirname(os.path.abspath(__file__))
#if current_folder not in sys.path:
#    sys.path.append(current_folder)
#import myutil

def zone_deal_tconnd_pkg_to_cmd(_in,_out,cscmd_xml):
    out={}
    desc={}
    out['lines']=[]
    for line in fileinput.FileInput(files=_in,openhook=open_file):
        line=line.strip()
        match = re.search(r'Cmd\[(\d+)\]',line)
        if not match:
            out['lines'].append(line)
            continue

        Cmd = int(match.group(1))
        Cmdinfo = myutil.cmd_to_cmd_info(Cmd)
        new_line="{}  {}".format(line,Cmdinfo)
        out['lines'].append(new_line)

    out['table']=desc
    with open(_out,'w',encoding="utf-8") as fileObj:
        fileObj.write('\n'.join(out['lines']))

#zone_deal_tconnd_pkg_to_cmd('G:/CodeBase.p4/release_4.4.0.Server_proj/.vimtmp.in.zone_deal_tconnd_pkg_to_cmd',
#                            'G:/CodeBase.p4/release_4.4.0.Server_proj/.vimtmp.out.zone_deal_tconnd_pkg_to_cmd',
#                            'G:/CodeBase.p4/release_4.4.0.Server_proj/protocol/star_cs.xml')
