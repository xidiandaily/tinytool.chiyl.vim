# -*- coding:UTF-8 -*-
import os
import sys
import re
import xml.etree.ElementTree as ET
import pdb
import fileinput
import json
import zipfile
import os

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

def busid_to_info(busid):
    ret = {'name':'NONE','desc':'未知命令','busid':busid}
    try:
        macro_xml='protocol/star_macro.xml'
        #macro_xml='G:/CodeBase.p4/trunkmain.Server_proj/protocol/star_macro.xml'
        root = ET.parse(macro_xml).getroot()
        e = root.find(".//macrosgroup[@name='ENUM_FUNC']").find("./macro[@value='{}']".format(busid))
        if e is None:
            return ret

        ret['name']=e.get('name')
        ret['desc']=e.get('desc')
        return ret
    except:
        return ret

def find_no_use_asyncid(filename):
    ret = []
    try:
        filepath='framework/async_type_def.h'

        asyncidlist=[]
        with open(filepath,mode='r',encoding='utf-8') as fileObj:
            for line in fileObj:
                line=line.strip()
                pattern = r'#define\s+([A-Z0-9_]+)\s+(\d+)\s*(\/\/\s*(.*))?'
                match = re.search(pattern,line)
                if match:
                    myid=int(match.group(2))
                    asyncidlist.append(myid)

        #ASYNC_TYPE_MAX (2000)
        for i in range(1,2000):
            if i not in asyncidlist:
                ret.append("{}".format(i))
    except:
        pass

    sorted(ret)
    for i in ret:
        print(i)
    with open(filename,'w') as fileObj:
        fileObj.write('\n'.join(ret))

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

def find_no_use_csmsgid(filename):
    ret = []
    try:
        cscmd_xml='protocol/star_cs.xml'
        root = ET.parse(cscmd_xml).getroot()

        e = root.find(".//macrosgroup[@name='ENUM_CS_CMD_TYPE']").find("./macro[@name='CS_CMD_CSMSG_MAX']")
        maxvalue=int(e.get('value'))

        csmsgidlist=[]
        for e in root.find(".//macrosgroup[@name='ENUM_CS_CMD_TYPE']").findall('./macro'):
            csmsgidlist.append(int(e.get('value')))

        for i in range(20,maxvalue):
            if i not in csmsgidlist:
                ret.append("{}".format(i))
    except:
        pass

    sorted(ret)
    for i in ret:
        print(i)
    with open(filename,'w') as fileObj:
        fileObj.write('\n'.join(ret))

def find_no_use_ssmsgid(filename):
    ret = []
    try:
        sscmd_xml='protocol/star_ss.xml'
        #sscmd_xml='G:/CodeBase.p4/release_4.4.0.Server_proj/protocol/star_ss.xml'
        root = ET.parse(sscmd_xml).getroot()

        e = root.find(".//macrosgroup[@name='ENUM_SS_CMD']").find("./macro[@name='SS_CMD_MAX']")
        maxvalue=int(e.get('value'))

        ssmsgidlist=[]
        for e in root.find(".//macrosgroup[@name='ENUM_SS_CMD']").findall('./macro'):
            ssmsgidlist.append(int(e.get('value')))

        for i in range(20,maxvalue):
            if i not in ssmsgidlist:
                ret.append("{}".format(i))
    except:
        pass

    sorted(ret)
    for i in ret:
        print(i)
    with open(filename,'w') as fileObj:
        fileObj.write('\n'.join(ret))

def compress_files(file_list, output_zip_file):
    with zipfile.ZipFile(output_zip_file, 'w', zipfile.ZIP_DEFLATED) as zipf:
        for file in file_list:
            if os.path.isfile(file):
                zipf.write(file, os.path.basename(file))
            else:
                print(f"{file} is not a file, skipping...")
