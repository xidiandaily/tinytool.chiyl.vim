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


#[20230909 21:43:33.557727][337]<DEBUG> [81294792183997312] (zone_send_to_client_cs_msg:332) [623_2_1_131283-0] enter cmd=844 eno=0.[01020005df36fb78][010002013b732604][0000000000000000]
#[20230909 21:43:33.679089][339]<DEBUG> [81294792183997312] (zone_send_to_client_cs_msg:332) [623_2_1_131284-0] enter cmd=844 eno=0.[01020005df45fb79][010002013dd41188][0000000000000000]
#[20230909 21:43:33.679134][342]<DEBUG> [81294792183997312] (zone_send_to_client_cs_msg:332) [623_2_1_131285-0] enter cmd=844 eno=0.[01020005df45fb7a][0100020143b42cc1][0000000000000000]
#[20230909 21:43:35.519350][358]<DEBUG> [81294792183997312] (zone_send_to_client_cs_msg:332) [623_2_1_131290-0] enter cmd=844 eno=0.[01020005e02bfb80][0100020147b0a785][0000000000000000]
def asyncstr_to_info2(_in,_out):
    out={}
    desc={}
    out['lines']=[]
    for line in fileinput.FileInput(files=_in,openhook=open_file):
        line=line.strip()
        match = re.search(r'(\d+)_(\d+)_(\d+)_(\d+)(-(.*?))?',line)
        if not match:
            out['lines'].append(line)
            continue

        asyncid = int(match.group(1))
        info = myutil.asynid_to_info(asyncid)
        new_line="{}  {}".format(line,info)
        out['lines'].append(new_line)
    out['table']=desc
    with open(_out,'w') as fileObj:
        fileObj.write('\n'.join(out['lines']))

def asyncstr_to_info(_in,_out):
    out={}
    out['lines']=[]
    for line in fileinput.FileInput(files=_in,openhook=open_file):
        line=line.strip()
        ret_lists=re.findall(r'(\d+)_(\d+)_(\d+)_(\d+)(-(.*?))?',line)
        if len(ret_lists)==0:
            out['lines'].append(line)
            continue

        async_infos=[]
        for ret in ret_lists:
            asyncid = int(ret[0])
            info = myutil.asynid_to_info(asyncid)
            info['asyncstr']="{}_{}_{}_{}".format(ret[0],ret[1],ret[2],ret[3])
            info['asyncid']="{}".format(myutil.asyncstr_to_ulong(ret))
            async_infos.append(info)
        if len(async_infos)==1:
            new_line="{}  {}".format(line,async_infos[0])
        else:
            new_line="{}  {}".format(line,async_infos)
        out['lines'].append(new_line)
    with open(_out,'w',encoding='utf-8') as fileObj:
        fileObj.write('\n'.join(out['lines']))

#asyncstr_to_info('G:/CodeBase.p4/release_4.4.0.Server_proj/.vimtmp.in.asyncstr_to_info',
#                 'G:/CodeBase.p4/release_4.4.0.Server_proj/.vimtmp.out.asyncstr_to_info')
