#!/usr/bin/python
# -*- coding:UTF-8 -*-
import sys
import os
import fnmatch
import tarfile
import pdb
import vim
from datetime import datetime

max_tar_file_num=150
def find_modified_files(path, choice):
    global max_tar_file_num
    ignore_list = ['*/.git*',
                   '*/.svn*',
                   '*/.cache*',
                   '*/resource*',
                   '.*',
                   '*.dat',
                   'cscope.files',
                   'cscope.out',
                   'lgamesvrc.ctrlptags',
                   'lgamesvrc.tags',
                   'lgamexml.ctrlptags',
                   'lgamexml.tags',
                   'tags']
    last_update_file= os.path.join(path,".last_modify_file")
    tarname = os.path.basename(path)
    tarfullname = os.path.realpath(os.path.join(os.path.join(path,'..'),'{}.tar'.format(tarname)))
    if int(choice) == 4:
        if os.path.exists(last_update_file):
            os.remove(last_update_file)
            print("remove {} done".format(last_update_file))
        if os.path.exists(tarfullname):
            os.remove(tarfullname)
            print("remove {} done".format(tarfullname))
        return
    if int(choice) == 3:
        with open(last_update_file,"w") as myfile:
            myfile.write("0")
            myfile.close()
        print("set last file time done")
        return
    elif int(choice) == 2:
        target_file_mtime = datetime.fromtimestamp(0)
    else:
        if os.path.exists(last_update_file):
            target_file_mtime = os.path.getmtime(last_update_file)
            target_file_mtime = datetime.fromtimestamp(target_file_mtime)
        else:
            target_file_mtime = datetime.fromtimestamp(0)
    matches = []
    for root, dirnames, filenames in os.walk(path):
        ignore = False
        if len(matches) > max_tar_file_num:
            break
        for ignore_pattern in ignore_list:
            if fnmatch.fnmatch(root, ignore_pattern):
                ignore = True
                break

        if ignore:
            continue

        for filename in filenames:
            file_path = os.path.join(root, filename)
            file_mtime = os.path.getmtime(file_path)
            file_mtime = datetime.fromtimestamp(file_mtime)

            if file_mtime >= target_file_mtime:
                ignore = False
                for ignore_pattern in ignore_list:
                    if fnmatch.fnmatch(filename, ignore_pattern):
                        ignore = True
                        break

                if not ignore:
                    matches.append(file_path)
    cnt=0
    for filename in matches:
        print("{}.{}".format(cnt,filename))
        cnt+=1
        if cnt >max_tar_file_num:
            print("can't pack more than {} files ,Failed And Exit!!!".format(max_tar_file_num))
            return

    if matches:
        with tarfile.open(tarfullname, "w") as tar:
            for match in matches:
                tar.add(match, arcname=os.path.relpath(match, path))
        print(" ")
        print(" ")
        print("Tar file created with matching files: {}".format(tarfullname))
        with open(last_update_file,"w") as myfile:
            myfile.write("0")
            myfile.close()
        cmd=":let @*='"+tarfullname+"'"
        vim.command(cmd)
    else:
        print("No matching files found.")

#if __name__ == "__main__":
#    import argparse
#    parser = argparse.ArgumentParser()
#    parser.add_argument("path", help="Path to search for files with the same modification time as target file")
#    parser.add_argument("choice", help="Target file to compare modification times")
#
#    args = parser.parse_args()
#
#    find_modified_files(args.path, args.choice)
