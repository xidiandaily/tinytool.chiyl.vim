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

sys.path.append("../pythonlib")
import CDateTime
import CMyP4

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


_VER="1.0.0"
logfilename=os.path.splitext(sys.argv[0])[0]+".log"

parser=argparse.ArgumentParser()
parser.add_argument('-l',dest="enable_debug_log",action='store_true',help='enable debug log')
parser.add_argument('-f',dest="enable_log_file",action='store_true',help='if this argument has been set,output log to logfile:{}'.format(logfilename))
parser.add_argument('-a',dest="test_store_true",action='store_true',help='enable or disable')
parser.add_argument('-b',dest="test_store",action='store',help='store input string')
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

configfilepath='config.ini.linux'
if sys.platlibdir=='win32':
    configfilepath='config.ini'

if not os.path.exists(configfilepath):
    logger.error("not found {}".format(configfilepath))
    sys.exit(1)

config=configparser.ConfigParser()
config.read(configfilepath,encoding="utf-8")
logger.debug(config.sections())


#PEP 484作为介绍
#PEP 526用于变量注释 https://peps.python.org/pep-0526/
#PEP 589为TypeDict
#可能还有更多:)
'''
myp4=CMyP4.getMyP4('test')
myp4: CMyP4.CMyP4
myp4.set_init(_p4rootpath, _p4port=None, _p4user=None, _p4passwd=None, _p4client=None, _p4stream=None)
'''

'''
myp4=CMyP4.getMyP4('test')  #type: CMyP4.CMyP4
myp4.set_init()
'''


'''
gc=gspread.oauth(credentials_filename=config['google']['credentials'],authorized_user_filename=config['google']['accounttoken'])
wks = gc.open_by_url(config['google']['sheeturl']).get_worksheet_by_id(int(config['google']['igrnoredfilesheetgid']))
list_of_lists=wks.get_all_values()
'''
