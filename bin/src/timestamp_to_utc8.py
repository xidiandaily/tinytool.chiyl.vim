#!/usr/bin/python
# -*- coding:UTF-8 -*-
import os
import sys
import logging
import re
import configparser
import subprocess
import argparse
import pdb
import datetime
import pytz
import fileinput
import chardet
import json

sys.path.append("../pythonlib")

def run_cmds(cmds,cwd=os.getcwd(),ignored=False):
    try:
        logger.info(os.environ)
        output=subprocess.check_call(cmds,cwd=cwd,env=os.environ)
        logger.debug("run cmds success! cmds:{} cwd:{} ignored={}".format(cmds,cwd,ignored))
    except subprocess.CalledProcessError as e:
        logger.error("run cmds failed!  cmds:{} cwd:{} ignored={}".format(cmds,cwd,ignored))
        if ignored:
            pass
        raise

def write_file(strName,strCon):
    with open(strName,'w') as fileObj:
        fileObj.write(strCon)
        fileObj.close()

def read_file(strFileName):
    strCon=''
    with open(strFileName,'r') as fileObj:
        strCon=fileObj.read()
    return strCon

def open_file(filename,mode):
    with open(filename,mode+'b') as f:
        rawdata=f.read()
        result=chardet.detect(rawdata)
        encoding=result['encoding']
        return open(filename,mode,encoding=encoding)

def timestamp_to_utc8(_in,_out):
    all_out=[]
    for line in fileinput.FileInput(files=_in,openhook=open_file):
        line=line.replace('\n','')
        out=[]
        for num in re.split(r'[^0-9]',line):
            if len(num) not in [10,13]:
                continue
            if not re.search(r'^1[5-9]',num):
                continue
            try:
                tstamp=int(num[:10])
                str_utc8 = datetime.datetime.fromtimestamp(tstamp).replace(tzinfo=pytz.timezone('Asia/Shanghai')).isoformat().replace('T',' ').replace('+',' +')
                out.append("{}: {}".format(num,str_utc8))
            except:
                out.append("{}: null".format(num,str_utc8))
        if len(out):
            all_out.append('{}   ###timestamp:{}'.format(line,json.dumps(out)))
        else:
            all_out.append(line)

    with open(_out,'w') as fileObj:
        fileObj.write('\n'.join(all_out))

_VER="1.0.0"
logfilename=os.path.splitext(sys.argv[0])[0]+".log"

parser=argparse.ArgumentParser()
parser.add_argument('-l',dest="enable_debug_log",action='store_true',help='timestamp to utc0 string')
parser.add_argument('-f',dest="enable_log_file",action='store_true',help='if this argument has been set,output log to logfile:{}'.format(logfilename))
parser.add_argument('-i',dest="infile",action='store',help='store input file')
parser.add_argument('-o',dest="outfile",action='store',help='store input file')
parser.add_argument('--version',action='version',version=_VER)
args=parser.parse_args()

logger = logging.getLogger()
#simpleformatter = logging.Formatter('%(message)s')
detailformatter = logging.Formatter('%(asctime)s - %(funcName)s:%(lineno)d - %(levelname)s - %(message)s')
logger.setLevel(logging.INFO)
# create console handler with stdout output
stdout = logging.StreamHandler(stream=sys.stdout)
logger.addHandler(stdout)

#log file
if args.enable_log_file or args.enable_debug_log:
    logfile=logging.FileHandler(logfilename)
    logfile.setFormatter(detailformatter)
    logger.addHandler(logfile)

if args.enable_debug_log:
    logger.setLevel(logging.DEBUG)
    stdout.setFormatter(detailformatter)
    logger.debug("if enable_debug_log, you will see this log")

if not args.infile or not args.outfile:
    parser.print_help()
    sys.exit()

timestamp_to_utc8(args.infile,args.outfile)
#in_path="G:/CodeBase.p4/release_4.4.0.Server_proj/.vimtmp.in.timestamp_to_utc8"
#out_path="G:/CodeBase.p4/release_4.4.0.Server_proj/.vimtmp.out.timestamp_to_utc8"
#timestamp_to_utc8(in_path,out_path)

