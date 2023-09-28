# -*- coding:UTF-8 -*-
import os
import sys
import re
import xml.etree.ElementTree as ET
import pdb
import fileinput
import json

def cmd_to_cmd_info(cmd):
    ret = {'name':'NONE','desc':'未知命令','ctype':'none','cname':'none','stype':'none','sname':'none'}
    try:
        cscmd_xml='protocol/star_cs.xml'
        root = ET.parse(cscmd_xml).getroot()
        e = root.find(".//macrosgroup[@name='ENUM_CS_CMD_TYPE']").find("./macro[@value='{}']".format(cmd))
        if e is None:
            return ret

        ret['name']=e.get('name')
        ret['desc']=e.get('desc')

        e = root.find(".//union[@name='CSDataC']").find("./entry[@id='{}']".format(ret['name']))
        if e is not None:
            ret['ctype']=e.get('type')
            ret['cname']=e.get('name')

        e = root.find(".//union[@name='CSDataS']").find("./entry[@id='{}']".format(ret['name']))
        if e is not None:
            ret['stype']=e.get('type')
            ret['sname']=e.get('name')
        return ret
    except:
        return ret

def errno_to_errno_info(errno):
    ret = {'name':'NONE','desc':'未知错误码','value':errno}
    try:
        macro_xml='protocol/star_macro.xml'
        root = ET.parse(macro_xml).getroot()
        e = root.find(".//macrosgroup[@name='ENUM_RET_CODE']").find("./macro[@value='{}']".format(errno))
        if e is None:
            return ret

        ret['name']=e.get('name')
        ret['desc']=e.get('desc')
        return ret
    except:
        return ret

def asynid_to_info(asyncid):
    ret = {'name':'NONE','desc':'未知命令','asyncid':asyncid}
    try:
        filepath='framework/async_type_def.h'
        #filepath='G:/CodeBase.p4/release_4.4.0.Server_proj/framework/async_type_def.h'
        with open(filepath,mode='r',encoding='utf-8') as fileObj:
            for line in fileObj:
                line=line.strip()
                pattern = r'#define\s+([A-Z0-9_]+)\s+(\d+)\s*(\/\/\s*(.*))?'
                match = re.search(pattern,line)
                if match:
                    myid=int(match.group(2))
                    if myid == asyncid:
                        ret['name']=match.group(1)
                        ret['desc']=match.group(3)
                        return ret
        return ret
    except:
        return ret

def asyncstr_to_ulong(str_list):
    if len(str_list) >= 4:
        ty = int(str_list[0])
        func = int(str_list[1])
        inst = int(str_list[2])
        seq = int(str_list[3].split('.')[0])
        id = (ty & 0xfff) << 52 | (func & 0xff) << 44 | (inst & 0x3fff) << 30 | (seq & 0x3fffffff)
        return id
    else:
        return 0

def asynid_to_asyncstr(num):
    id = int(num)
    asyncstr="{}_{}_{}_{}".format(((id >> 52) & 0xfff), ((id >> 44) & 0xff), ((id >> 30) & 0x3fff), (id & 0x3fffffff))
    return asyncstr

