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

def open_file(filename, mode):
    with open(filename, mode + 'b') as f:
        rawdata = f.read()
        result = chardet.detect(rawdata)
        encoding = result['encoding']
    return open(filename, mode, encoding=encoding)

def sort_by_datetimestr(_in,_out):

    #提取时间戳
    timestamps=[]
    for line in fileinput.FileInput(files=_in,openhook=open_file):
        match = re.search(r'\[(\d{8} \d{2}:\d{2}:\d{2}\.\d+)\]', line)
        if match:
            timestamps.append((match.group(1), line.strip()))

    # 根据时间戳排序
    timestamps.sort(key=lambda x: x[0])

    # 输出排序后的结果
    out=["根据每一行的时间字符串进行排序，字符串示例: 20240316 17:11:26.385179","=========================","",""]
    for timestamp, line in timestamps:
        out.append(line)

    with open(_out,'w',encoding="utf-8") as fileObj:
        fileObj.write("\n".join(out))

#in_path="G:/CodeBase.pgame/pserver/.vimtmp.filename.26.txt"
#out_path="G:/CodeBase.pgame/pserver/.vimtmp.filename.27.txt"
#
#sort_by_datetimestr(in_path,out_path)
