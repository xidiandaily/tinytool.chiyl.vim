# -*- coding:UTF-8 -*-
import os
import sys
import re
import xml.etree.ElementTree as ET
import pdb
import fileinput
import json
lgamesvr_header_dirs_realpath=set([
    #"G:/CodeBase.github/vim/VIMPROJ/vimlib/linux/include",
    "\"C:/Program Files (x86)/Microsoft Visual Studio/2017/Professional/Common7/IDE/VC/Linux/include/usr/include\"",
    "\"C:/Program Files (x86)/Microsoft Visual Studio/2017/Professional/Common7/IDE/VC/Linux/include/usr/include/x86_64-linux-gnu\"",
    ])

lgamesvr_header_dirs=set([
    "./",
    "./battlemgr",
    "./comm",
    "./csserver",
    "./csserver/api",
    "./dep/3rd/include",
    "./dep/apollo/include",
    "./dep/apollo_lwip_linux/include",
    "./dep/apollo_lwip_linux_client/include",
    "./dep/emock/include",
    "./dep/googlemock/include",
    "./dep/googletest/include",
    "./dep/gperftools-2.4.91/include",
    "./dep/lua/include",
    "./dep/msgpack/include",
    "./dep/mysql/include",
    "./dep/polaris/include",
    "./dep/qcos/include",
    "./dep/redis/include",
    "./dep/tbase/include",
    "./dep/tbuspp/include",
    "./dep/tcaplus/include",
    "./dep/tcaplus_manager/deps/TSF4G_BASE-2.7.12.114938_X86_64_Release/release/x86_64/include",
    "./dep/tcaplus_manager/deps/TcaplusServiceApi3.13.0.122072.x86_64_release_20160624/release/x86_64/include",
    "./dep/tcm/include",
    "./dep/tconnd/apps",
    "./dep/tconnd/apps/tconnd/include",
    "./dep/tconnd/apps/tconnd/include/apps",
    "./dep/tconnd/apps/tconnd/libtconn/include",
    "./dep/tglogapi/include",
    "./dep/tglogapi/third_party/include",
    "./dep/tqos/include",
    "./dep/tresloader/include",
    "./dep/tss/include",
    "./dep/uv/include",
    "./dep/zstd/include",
    "./framework",
    "./framework/script",
    "./funcsvr",
    "./funcsvr/abtest",
    "./funcsvr/antiicon",
    "./funcsvr/apexkingrank",
    "./funcsvr/apollo",
    "./funcsvr/artistmgr",
    "./funcsvr/broadcast",
    "./funcsvr/build",
    "./funcsvr/changeshard",
    "./funcsvr/consistencyfile",
    "./funcsvr/duplicate",
    "./funcsvr/es",
    "./funcsvr/facedetect",
    "./funcsvr/firebasenotify",
    "./funcsvr/frameworks",
    "./funcsvr/gamecenter",
    "./funcsvr/guild",
    "./funcsvr/loadbalance",
    "./funcsvr/lobbychat",
    "./funcsvr/mass",
    "./funcsvr/matchroom",
    "./funcsvr/mlbridge",
    "./funcsvr/mldatamgr",
    "./funcsvr/mlmgr",
    "./funcsvr/mlmiscmgr",
    "./funcsvr/mysql",
    "./funcsvr/rankcache",
    "./funcsvr/rankupload",
    "./funcsvr/recomd",
    "./funcsvr/redenvelope",
    "./funcsvr/redis",
    "./funcsvr/reporttrial",
    "./funcsvr/roomframesave",
    "./funcsvr/roomrecoverymgr",
    "./funcsvr/rowfriend",
    "./funcsvr/rpgproxy",
    "./funcsvr/runeequip",
    "./funcsvr/saevalution",
    "./funcsvr/simulateai",
    "./funcsvr/slmgr",
    "./funcsvr/social",
    "./funcsvr/statistics",
    "./funcsvr/statusmgr",
    "./funcsvr/syncoss",
    "./funcsvr/tcaplusproxy",
    "./funcsvr/tcaplustraverse",
    "./funcsvr/team",
    "./funcsvr/teamrecruit",
    "./funcsvr/test",
    "./funcsvr/timer",
    "./funcsvr/trial",
    "./funcsvr/video",
    "./funcsvr/watchproxy",
    "./funcsvr/webproxy",
    "./funcsvr/winpredictmgr",
    "./gameidipsvr",
    "./logagent",
    "./matchmgr",
    "./matchsvr",
    "./matchworker",
    "./mlsvr",
    "./mlsvr/build",
    "./objdir",
    "./online",
    "./preloginsvr",
    "./protocol",
    "./protocol/old",
    "./resource",
    "./riot",
    "./riot-deploy",
    "./riot/conf",
    "./riot/include",
    "./riot/script",
    "./riot/src",
    "./riot/test",
    "./roomsvr",
    "./router",
    "./script",
    "./shm",
    "./zonesvr",
    "./zonesvr/abtest",
    "./zonesvr/achievement",
    "./zonesvr/activity",
    "./zonesvr/aram",
    "./zonesvr/around_battlefield",
    "./zonesvr/champ",
    "./zonesvr/changeshard",
    "./zonesvr/chat",
    "./zonesvr/cherry",
    "./zonesvr/chooseloc",
    "./zonesvr/collection",
    "./zonesvr/commercialize",
    "./zonesvr/container_management",
    "./zonesvr/counter",
    "./zonesvr/credit",
    "./zonesvr/elo",
    "./zonesvr/exclusive_business",
    "./zonesvr/ext_data",
    "./zonesvr/framework",
    "./zonesvr/friend",
    "./zonesvr/game_status",
    "./zonesvr/gameannouncement",
    "./zonesvr/grade",
    "./zonesvr/growth",
    "./zonesvr/guild",
    "./zonesvr/hero",
    "./zonesvr/include",
    "./zonesvr/include/framework",
    "./zonesvr/item",
    "./zonesvr/itemcard",
    "./zonesvr/kol_video",
    "./zonesvr/livebroadcast",
    "./zonesvr/login",
    "./zonesvr/mail",
    "./zonesvr/match",
    "./zonesvr/matchroom",
    "./zonesvr/module_register",
    "./zonesvr/name",
    "./zonesvr/noviceguide",
    "./zonesvr/oss",
    "./zonesvr/others",
    "./zonesvr/pay",
    "./zonesvr/pet",
    "./zonesvr/platform",
    "./zonesvr/prepare",
    "./zonesvr/privilege",
    "./zonesvr/rank",
    "./zonesvr/recall",
    "./zonesvr/recruit",
    "./zonesvr/redenvelope",
    "./zonesvr/resourcekey",
    "./zonesvr/role_basic",
    "./zonesvr/role_data",
    "./zonesvr/role_profile",
    "./zonesvr/role_simple",
    "./zonesvr/room",
    "./zonesvr/season",
    "./zonesvr/season_data",
    "./zonesvr/security",
    "./zonesvr/settlement",
    "./zonesvr/shopmall",
    "./zonesvr/simulateai",
    "./zonesvr/social",
    "./zonesvr/special_sale",
    "./zonesvr/switch",
    "./zonesvr/task",
    "./zonesvr/team",
    "./zonesvr/track",
    "./zonesvr/ugc",
    "./zonesvr/user_label",
    "./zonesvr/warmround",
    "./zonesvr/watch",
    "./zonesvr/xdata",
    "./zonesvr/zk",
    "./zonesvr/zone_sc"])


compile_flags=set([
    "-Wno-incompatible-pointer-types-discards-qualifiers",
    "-Wno-implicit-function-declaration",
    "-Wno-reserved-user-defined-literal"
    ])

#{
#  "directory": "G:/CodeBase.p4/trunkmain.Server_proj",
#  "command": "/usr/lib64/ccache/cc   -IG:/CodeBase.p4/trunkmain.Server_proj/.. -IG:/CodeBase.p4/trunkmain.Server_proj/../comm -IG:/CodeBase.p4/trunkmain.Server_proj/../dep/tbase/include -IG:/CodeBase.p4/trunkmain.Server_proj/../dep/tresloader/include -IG:/CodeBase.p4/trunkmain.Server_proj/../dep/tconnd/apps/tconnd/include/apps -IG:/CodeBase.p4/trunkmain.Server_proj/../protocol    -o CMakeFiles/my_executable.dir/credit/frustration_appease_rule.c.o   -c G:/CodeBase.p4/trunkmain.Server_proj/credit/frustration_appease_rule.c",
#  "file": "G:/CodeBase.p4/trunkmain.Server_proj/credit/frustration_appease_rule.c"
#},

def directory_to_compile_commands_file_all(dir_path,_out):
    header_ext=['.h','.hpp','.hxx']
    source_ext=['.c','.cpp','.cxx']
    header_dirs=set([])
    header_dirs.add("./")
    source_files=[]
    for dirpath,dirnames,filenames in os.walk(dir_path):
        header_dirs.add(dirpath)
        for name in filenames:
            ext = os.path.splitext(name)
            if ext[-1] in header_ext:
                header_dirs.add(dirpath)
                continue
            if ext[-1] in source_ext:
                source_files.append(os.path.relpath(os.path.realpath(os.path.join(dirpath,name)),dir_path))
    str_include=""
    for dirname in header_dirs:
        str_include+=" -I{}".format(dirname)

    out=[]
    for filename in source_files:
        basename=os.path.splitext(filename)[0]
        item={}
        item['directory'] = dir_path
        item['command'] = "gcc {} -o {}.o -c {}".format(str_include,basename,filename)
        item['file'] = filename
        out.append(item)

    with open(_out,mode='w',encoding="utf-8") as fileObj:
        json.dump(out,fileObj,indent=4,ensure_ascii=False)

def directory_to_compile_commands_file(dir_path,_out):
    global lgamesvr_header_dirs
    global compile_flags

    source_ext=['.c','.cpp','.cxx']
    source_files=[]
    for dirpath,dirnames,filenames in os.walk(dir_path):
        for name in filenames:
            ext = os.path.splitext(name)
            if ext[-1] in source_ext:
                source_files.append(os.path.relpath(os.path.realpath(os.path.join(dirpath,name)),dir_path).replace('\\','/'))
    str_include=""
    for dirname in lgamesvr_header_dirs_realpath:
        str_include+=" -I{}".format(dirname)

    for dirname in lgamesvr_header_dirs:
        str_include+=" -I{}".format(os.path.realpath(os.path.join(dir_path,dirname)).replace("\\","/"))

    str_flags=""
    for flag in compile_flags:
        str_flags+=" {}".format(flag)

    out=[]
    for filename in source_files:
        basename=os.path.splitext(filename)[0]
        item={}
        item['directory'] = dir_path
        item['command'] = "gcc {} {} -o {}.o -c {}".format(str_flags,str_include,basename,filename)
        item['file'] = filename
        out.append(item)

    with open(_out,mode='w',encoding="utf-8") as fileObj:
        json.dump(out,fileObj,indent=4,ensure_ascii=False)


#directory_to_compile_commands_file("G:/CodeBase.p4/trunkmain.Server_proj","compile_commands.json")

