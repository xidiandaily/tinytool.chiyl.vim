#!/usr/bin/python
# -*- coding:UTF-8 -*-

import re
import fileinput
import pdb
import inspect
import chardet

def open_file(filename, mode):
    with open(filename, mode + 'b') as f:
        rawdata = f.read()
        result = chardet.detect(rawdata)
        encoding = result['encoding']
    return open(filename, mode, encoding=encoding)

def lua_val_to_markdown_table(_in, output_file):
    pattern = re.compile(r"^\s*([a-zA-Z0-9_\.]+)\s*=\s*([0-9]+)\s*(?:;)?\s*(?:--(.*))?$")
    headers=['name','val','comment']
    rows = []
    for line in fileinput.FileInput(files=_in,openhook=open_file):
        match=pattern.search(line)
        if match:
            row ={
                    'name'    : match.group(1),
                    'val'     : match.group(2),
                    'comment' : match.group(3) or "" }
            rows.append(row)

    # 生成Markdown表格
    table = "| 类型 | 取值 | 说明 |\n"
    table += "| --- | --- | --- |\n"
    for row in rows:
        table += "| " + " | ".join([row[header] for header in headers]) + " |\n"

    # 将结果写入Markdown文件
    with open(output_file, 'w') as file:
        file.write(table)

## 调用函数
#lua_val_to_markdown_table('G:/CodeBase.pgame/pserver/.vimtmp.filename.5.txt', 'G:/CodeBase.pgame/pserver/.vimtmp.filename.6.txt')
