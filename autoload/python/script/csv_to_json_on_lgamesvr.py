#!/usr/bin/python
# -*- coding:UTF-8 -*-
import os
import sys
import re
import pdb
import csv
import json

def csv_to_json_on_lgamesvr(_in,_out):

    with open(_in,newline='',encoding="utf-8") as csvfile:
        reader = csv.DictReader(csvfile)

        data=[]
        for row in reader:
            mydict={}
            for header,value in row.items():
                mydict[header]=value
            data.append(mydict)

    with open(_out,'w',encoding="utf-8") as fileObj:
        json.dump(data,fileObj,indent=4,ensure_ascii=False)

