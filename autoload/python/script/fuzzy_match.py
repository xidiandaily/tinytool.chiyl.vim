#!/usr/bin/python
# -*- coding:UTF-8 -*-
import re
import json
import fileinput
import chardet
import pdb
import unicodedata


def open_file(filename, mode):
    with open(filename, mode + 'b') as f:
        rawdata = f.read()
        result = chardet.detect(rawdata)
        encoding = result['encoding']
    return open(filename, mode, encoding=encoding)

# 计算字符串的显示宽度（考虑中文）
def get_display_width(text):
    width = 0
    for char in text:
        if unicodedata.east_asian_width(char) in ('F', 'W'):
            width += 2  # 中文字符宽度为2
        else:
            width += 1  # 英文字符宽度为1
    return width

# 计算最大宽度
def calculate_max_width(*texts):
    return max(get_display_width(text) for text in texts)

# 填充空格使得对齐
def pad_text(text, width):
    display_width = get_display_width(text)
    padding = width - display_width
    return text + ' ' * padding


def split_line(line):
    return re.split(r'[^a-zA-Z_]',line)

def fuzzy_math_per_line(_left,_right):
    bFound = False
    for left_word in split_line(_left):
        for right_word in split_line(_right):
            if (left_word == right_word and len(left_word) > 4) or (left_word == right_word and left_word in {"UID"}):
                print("_left:{} right_line:{} word:{}".format(_left,_right,left_word))
                bFound = True
    return bFound

def fuzzy_match(_left,_right,_out):
    max_len = 0
    left_lines = []
    for line in fileinput.FileInput(files=_left,openhook=open_file):
        str_line = line.strip("\n")
        max_len = max(len(str_line),max_len)
        left_lines.append(str_line)

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
            str_out+=f"{pad_text(line,max_len)}  ### {result[0]}\n"
        elif  len(result) != 0:
            str_line=json.dumps(result,ensure_ascii=False)
            str_out+=f"{pad_text(line,max_len)}  ### {str_line}\n"
        else:
            str_out+=f"{pad_text(line,max_len)}\n"
    with open(_out,'w',encoding="utf-8") as fileObj:
        fileObj.write(str_out)

#fuzzy_match("H:/CodeBase.pgame/pserver/.vimtmp.filename.4.txt",
#            "H:/CodeBase.pgame/pserver/.vimtmp.filename.5.txt",
#            "H:/CodeBase.pgame/pserver/.vimtmp.filename.6.txt")
#

