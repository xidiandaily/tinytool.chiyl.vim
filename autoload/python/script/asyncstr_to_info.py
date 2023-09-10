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

#[20230909 21:43:33.557727][337]<DEBUG> [81294792183997312] (zone_send_to_client_cs_msg:332) [623_2_1_131283-0] enter cmd=844 eno=0.[01020005df36fb78][010002013b732604][0000000000000000]
#[20230909 21:43:33.679089][339]<DEBUG> [81294792183997312] (zone_send_to_client_cs_msg:332) [623_2_1_131284-0] enter cmd=844 eno=0.[01020005df45fb79][010002013dd41188][0000000000000000]
#[20230909 21:43:33.679134][342]<DEBUG> [81294792183997312] (zone_send_to_client_cs_msg:332) [623_2_1_131285-0] enter cmd=844 eno=0.[01020005df45fb7a][0100020143b42cc1][0000000000000000]
#[20230909 21:43:35.519350][358]<DEBUG> [81294792183997312] (zone_send_to_client_cs_msg:332) [623_2_1_131290-0] enter cmd=844 eno=0.[01020005e02bfb80][0100020147b0a785][0000000000000000]
def asyncstr_to_info(_in,_out):
    out={}
    desc={}
    out['lines']=[]
    for line in fileinput.FileInput(_in):
        line=line.strip()
        match = re.search('(\d+)_(\d+)_(\d+)_(\d+)(-(.*?))?',line)
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

#asyncstr_to_info('G:/CodeBase.p4/release_4.4.0.Server_proj/.vimtmp.in.asyncstr_to_info',
#                 'G:/CodeBase.p4/release_4.4.0.Server_proj/.vimtmp.out.asyncstr_to_info')
