#!/usr/bin/python
# -*- coding:UTF-8 -*-
import sys
import os
import fnmatch
import tarfile
import pdb
#import vim
import subprocess
import re
from datetime import datetime

max_tar_file_num=150
def tar_git_edited_files():
    global max_tar_file_num
    if not os.path.exists('.git'):
        print("not git project")
        return 

    #p4  -Ztag -F "localfile: \%clientFile\%" opened
    path = os.getcwd()
    out  = subprocess.check_output(['git','status','--porcelain'])
    out  = out.decode('utf-8')
    matches=[]
    for line in out.splitlines():
        line=str(line)
        filename=''
        if line.startswith(' M') or line.startswith('M '):
            filename=line.split()[-1]
        elif line.startswith(' A') or line.startswith('A '):
            filename=line.split()[-1]
        else:
            continue

        if os.path.exists(os.path.join(path,filename)):
            matches.append(filename)
            print(filename)

    if len(matches):
        last_update_file= os.path.join(path,".last_modify_file")
        tarname = os.path.basename(path)
        tarfullname = os.path.realpath(os.path.join(os.path.join(path,'..'),'{}.tar'.format(tarname)))
        with tarfile.open(tarfullname, "w") as tar:
            for match in matches:
                tar.add(match, arcname=os.path.relpath(match, path))
        print("Tar file created with matching files: {}".format(tarfullname))
        with open(last_update_file,"w") as myfile:
            myfile.write("0")
            myfile.close()
        cmd=":let @*='"+tarfullname+"'"
        vim.command(cmd)
    else:
        print("No matching files found.")

#if __name__ == "__main__":
#    tar_git_edited_files()
