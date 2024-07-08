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

def zone_send_to_client_cs_msg(_in,_out):
    out={}
    desc={}
    out['lines']=[]
    for line in fileinput.FileInput(files=_in,openhook=open_file):
        line=line.strip()
        match = re.search('cmd=(\d+) eno=(\d+)\.',line)
        if not match:
            out['lines'].append(line)
            continue

        Cmd = int(match.group(1))
        Cmdinfo = myutil.cmd_to_cmd_info(Cmd)
        Errinfo = myutil.errno_to_errno_info(match.group(2))

        new_line="{}  {} {}".format(line,Cmdinfo,Errinfo)
        out['lines'].append(new_line)

    out['table']=desc
    with open(_out,'w',encoding='utf-8') as fileObj:
        fileObj.write('\n'.join(out['lines']))

#zone_send_to_client_cs_msg('G:/CodeBase.p4/release_4.3.0.Server_proj/.vimtmp.in.zone_send_to_client_cs_msg',
#                            'G:/CodeBase.p4/release_4.3.0.Server_proj/.vimtmp.out.zone_send_to_client_cs_msg')
