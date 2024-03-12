#!/usr/bin/python
# -*- coding:UTF-8 -*-

import xml.etree.ElementTree as ET
import pdb

def xml2markdowntable(input_file, output_file):
    try:
        # 从文件中读取XML数据
        tree = ET.parse(input_file)
        root = tree.getroot()

        table_title = root.attrib.get('name', '')

        # 提取表格标题和内容
        headers = ['type','name', 'desc']
        rows = []

        for entry in root.findall('entry'):
            row = {
                'type': entry.attrib.get('type', ''),
                'name': entry.attrib.get('name', ''),
                'desc': entry.attrib.get('desc', '')
            }
            rows.append(row)

        # 生成Markdown表格
        #table = "| " + " | ".join(headers) + " |\n"
        table = "| | "+root.attrib.get('name','') + " |\n"
        table += "| " + " | ".join(['---' for _ in headers]) + " |\n"

        for row in rows:
            table += "| " + " | ".join([row[header] for header in headers]) + " |\n"

        # 将结果写入Markdown文件
        with open(output_file, 'w') as file:
            file.write(table)
    except ET.ParseError as e:
        # 将结果写入Markdown文件
        with open(output_file, 'w') as file:
            file.write('parse failed!')
        pass

## 调用函数
#xml2markdowntable('G:/CodeBase.pgame/pserver/.vimtmp.filename.16.txt', 'G:/CodeBase.pgame/pserver/.vimtmp.filename.17.txt')

#def xml2markdowntable(input_file, output_file):
#    # 从文件中读取XML数据
#    root = ET.parse(input_file)
#
#    # 初始化输出字符串
#    output = ""
#
#    # 遍历所有struct
#    for struct in root.findall('struct'):
#        struct_name = struct.attrib.get('name', '')
#
#        # 提取表格标题和内容
#        headers = ['name', 'type', 'desc']
#        rows = []
#
#        for entry in struct.findall('entry'):
#            row = {
#                'name': entry.attrib.get('name', ''),
#                'type': entry.attrib.get('type', ''),
#                'desc': entry.attrib.get('desc', '')
#            }
#            rows.append(row)
#
#        # 生成Markdown表格
#        table = f"### {struct_name}\n\n"
#        table += "| " + " | ".join(headers) + " |\n"
#        table += "| " + " | ".join(['---' for _ in headers]) + " |\n"
#
#        for row in rows:
#            table += "| " + " | ".join([row[header] for header in headers]) + " |\n"
#
#        # 将表格添加到输出字符串
#        output += table + "\n\n"
#
#    # 将结果写入Markdown文件
#    with open(output_file, 'w') as file:
#        file.write(output)
#
## 调用函数
#xml2markdowntable('G:/CodeBase.pgame/pserver/.vimtmp.filename.14.txt', 'G:/CodeBase.pgame/pserver/.vimtmp.filename.15.txt')
