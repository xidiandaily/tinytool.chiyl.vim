#!/usr/bin/python
# -*- coding:UTF-8 -*-

import os
import sys
import fileinput
import re
import socket
import chardet
import pdb
import myutil

def open_file(filename, mode):
    with open(filename, mode + 'b') as f:
        rawdata = f.read()
        result = chardet.detect(rawdata)
        encoding = result['encoding']
    return open(filename, mode, encoding=encoding)

def tinytool_update_conemu_config(_in,_out,_my_conemu_startup_cmd):
    out=[]
    for line in fileinput.FileInput(files=_in,openhook=open_file):
        line=line.strip('\n')
        new_line=line.replace("MY_CONEMU_START_UP_CMD",_my_conemu_startup_cmd)
        out.append(new_line)

    with open(_out,'w',encoding="utf-8") as fileObj:
        fileObj.write('\n'.join(out))

#tinytool_update_conemu_config("G:/CodeBase.github/vim/vimfiles/bundle/tinytool.chiyl.vim/config/ConEmu_for_mygrep.xml","G:/CodeBase.github/vim/vimfiles/bundle/tinytool.chiyl.vim/config/ConEmu_for_mygrep_cur.xml","ag --nogroup --nocolor -p .agignore \"PlayerDisconnectFlow woejwfiej\"")
