#!/usr/bin/python
# -*- coding:UTF-8 -*-
import re
import json
import fileinput
import chardet
import pdb

def open_file(filename, mode):
    with open(filename, mode + 'b') as f:
        rawdata = f.read()
        result = chardet.detect(rawdata)
        encoding = result['encoding']
    return open(filename, mode, encoding=encoding)

def split_line(line):
    return re.split(r'[^a-zA-Z_]',line)

def fuzzy_math_per_line(_left,_right):
    bFound = False
    for left_word in split_line(_left):
        for right_word in split_line(_right):
            if left_word == right_word and len(left_word) > 4:
                print("_left:{} right_line:{} word:{}".format(_left,_right,left_word))
                bFound = True
    return bFound

def fuzzy_match(_left,_right,_out):
    left_lines = []
    for line in fileinput.FileInput(files=_left,openhook=open_file):
        left_lines.append(line.strip("\n"))

    right_lines = []
    for line in fileinput.FileInput(files=_right,openhook=open_file):
        right_lines.append(line.strip("\n"))

    str_out=""
    for line in left_lines:
        result = []
        for right_line in right_lines:
            if fuzzy_math_per_line(line,right_line):
                result.append(right_line)
        if len(result) == 1:
            str_out+="{}  ### {}\n".format(line,result[0])
        elif  len(result) != 0:
            str_out+="{}  ### {}\n".format(line,json.dumps(result,ensure_ascii=False))
        else:
            str_out+="{}\n".format(line)
    with open(_out,'w',encoding="utf-8") as fileObj:
        fileObj.write(str_out)

#fuzzy_match("H:/CodeBase.pgame/pserver/.vimtmp.filename.46.txt",
#            "H:/CodeBase.pgame/pserver/.vimtmp.filename.47.txt",
#            "H:/CodeBase.pgame/pserver/.vimtmp.filename.48.txt")
#
#
