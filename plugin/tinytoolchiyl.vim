"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.08.29
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

"if exists('g:tinytoolchiyl')
"    finish
"endif
"let g:tinytoolchiyl = 1

" 加载python配置
let s:plugin_path=escape(expand('<sfile>:p:h'),'\')
let s:filelist=split(glob(s:plugin_path . '/../autoload/python/script/*.py'),'\n')

for _file in s:filelist
    if has('python3')
        execute 'py3file ' ._file
    else
        execute 'pyfile ' ._file
    endif
endfor

"一些默认配置
if has('gui_running')
    if &mousemodel =~? 'popup'
        anoremenu <silent> PopUp.T&inytool.git.pull
                    \ :call ctrlp#mygit#pull()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.git.guilog
                    \ :call ctrlp#mygit#guilog()<CR>

        anoremenu <silent> PopUp.T&inytool.git.guifilelog
                    \ :call ctrlp#mygit#guifilelog()<CR>

        anoremenu <silent> PopUp.T&inytool.git.guiblame
                    \ :call ctrlp#mygit#guiblame()<CR>

        anoremenu <silent> PopUp.T&inytool.git.commit
                    \ :call ctrlp#mygit#guicommit()<CR>

        anoremenu <silent> PopUp.T&inytool.git.show_select_commit
                    \ :call ctrlp#mygit#show_commit_detail()<CR>

        anoremenu <silent> PopUp.T&inytool.tarfile.modify
                    \ :call tinytoolchiyl#base#find_modified_files#tarfiles(substitute(getcwd(),'\\','\\\\','g'),1,0)<CR>

        anoremenu <silent> PopUp.T&inytool.tarfile.All
                    \ :call tinytoolchiyl#base#find_modified_files#tarfiles(substitute(getcwd(),'\\','\\\\','g'),2,0)<CR>

        anoremenu <silent> PopUp.T&inytool.tarfile.ZIPAll
                    \ :call tinytoolchiyl#base#find_modified_files#tarfiles(substitute(getcwd(),'\\','\\\\','g'),2,1)<CR>

        anoremenu <silent> PopUp.T&inytool.tarfile.SetTstamp
                    \ :call tinytoolchiyl#base#find_modified_files#tarfiles(substitute(getcwd(),'\\','\\\\','g'),3,0)<CR>

        anoremenu <silent> PopUp.T&inytool.tarfile.P4opened
                    \ :call tinytoolchiyl#base#find_modified_files#tar_p4_opened_files()<CR>

        anoremenu <silent> PopUp.T&inytool.tarfile.Clean
                    \ :call tinytoolchiyl#base#find_modified_files#tarfiles(substitute(getcwd(),'\\','\\\\','g'),4,0)<CR>

        anoremenu <silent> PopUp.T&inytool.open.Notepad++
                    \ :silent !cmd.exe /c start  "notepad++" "%" <CR>

        anoremenu <silent> PopUp.T&inytool.open.FileDir
                    \ :silent !cmd.exe /c start  "" "%:p:h" <CR>

        anoremenu <silent> PopUp.T&inytool.open.ConEmu
                    \ :silent !cmd.exe /c start  ConEmu64 -Dir "%:p:h" <CR>

        anoremenu <silent> PopUp.T&inytool.open.Cygwin
                    \ :call tinytoolchiyl#base#openwith#Cygwin()<CR>

        anoremenu <silent> PopUp.T&inytool.open.git-bash
                    \ :silent !cmd.exe /c start  git-bash<CR>

        anoremenu <silent> PopUp.T&inytool.time.timestamp_to_utc8
                    \ :call tinytoolchiyl#base#mydatetime#timestamp_to_utc8()<CR>

        anoremenu <silent> PopUp.T&inytool.time.copy_timestamp
                    \ :call tinytoolchiyl#base#mydatetime#copy_timestamp()<CR>

        anoremenu <silent> PopUp.T&inytool.time.copy_1_hour_ago_timestamp
                    \ :call tinytoolchiyl#base#mydatetime#copy_1_hour_agotimestamp()<CR>

        anoremenu <silent> PopUp.T&inytool.time.copy_1_day_ago_timestamp
                    \ :call tinytoolchiyl#base#mydatetime#copy_1_day_agotimestamp()<CR>

        anoremenu <silent> PopUp.T&inytool.time.copy_1_week_ago_timestamp
                    \ :call tinytoolchiyl#base#mydatetime#copy_1_week_agotimestamp()<CR>

        anoremenu <silent> PopUp.T&inytool.time.copy_1_month_ago_timestamp
                    \ :call tinytoolchiyl#base#mydatetime#copy_1_month_agotimestamp()<CR>

        anoremenu <silent> PopUp.T&inytool.time.copy_str_time
                    \ :call tinytoolchiyl#base#mydatetime#copy_str_time()<CR>

        anoremenu <silent> PopUp.T&inytool.env.pgamesvr_lsp_setting
                    \ : call tinytoolchiyl#base#lsp_setting#pgamesvr()<CR>

        anoremenu <silent> PopUp.T&inytool.env.add_ag_search_ignored_filelist
                    \ : call tinytoolchiyl#base#myutil#add_ag_search_ignore_files()<CR>

        anoremenu <silent> PopUp.T&inytool.pgame.busid_parse
                    \ : call tinytoolchiyl#base#pgameinfo#busid_parse()<CR>

        anoremenu <silent> PopUp.T&inytool.pgame.add_debugline
                    \ : call tinytoolchiyl#base#pgameinfo#add_debugline()<CR>

        anoremenu <silent> PopUp.T&inytool.pgame.tlog_to_json
                    \ : call tinytoolchiyl#base#tlog_to_json_on_pgamesvr#Doit()<CR>

        anoremenu <silent> PopUp.T&inytool.pgame.log_to_json_{a=hello}_to_{"a":"hello"}
                    \ : call tinytoolchiyl#base#pgame_log_convert_to_json#Doit()<CR>

        anoremenu <silent> PopUp.T&inytool.fuzzy_match.select_left_text_for_match
                    \ : call tinytoolchiyl#base#fuzzy_match#select_left_text_for_match()<CR>

        anoremenu <silent> PopUp.T&inytool.fuzzy_match.do_match_select_right_text
                    \ : call tinytoolchiyl#base#fuzzy_match#match_right_text()<CR>

        anoremenu <silent> PopUp.T&inytool.fuzzy_match.help
                    \ : call tinytoolchiyl#base#fuzzy_match#help()<CR>

        anoremenu <silent> PopUp.T&inytool.marks.list_all_marks
                    \ : marks<CR>

        anoremenu <silent> PopUp.T&inytool.marks.list_all_marks_with_content
                    \ : call tinytoolchiyl#base#my_marks#list_all_global_marks()<CR>

        anoremenu <silent> PopUp.T&inytool.marks.output_all_global_marks_to_file
                    \ : call tinytoolchiyl#base#my_marks#output_all_global_marks_to_file()<CR>

        anoremenu <silent> PopUp.T&inytool.marks.clear_all_supercase_marks
                    \ : delmarks A-Z \| marks <CR>

        anoremenu <silent> PopUp.T&inytool.marks.save_all_supercase_to_file
                    \ : call tinytoolchiyl#base#my_marks#azmarks_save() <CR>

        anoremenu <silent> PopUp.T&inytool.marks.load_all_supercase_from_file
                    \ : call tinytoolchiyl#base#my_marks#azmarks_load() <CR>

        anoremenu <silent> PopUp.T&inytool.marks.show_save_history_file
                    \ : call tinytoolchiyl#base#my_marks#show_history() <CR>

        anoremenu <silent> PopUp.T&inytool.markdown.select_xml_struct_to_markdowtable.run
                    \ :call tinytoolchiyl#base#xml2markdowntable#pgame()<CR>

        anoremenu <silent> PopUp.T&inytool.markdown.select_xml_struct_to_markdowtable.help
                    \ :call tinytoolchiyl#base#xml2markdowntable#help()<CR>

        anoremenu <silent> PopUp.T&inytool.markdown.select_lua_val_to_table.run
                    \ :call tinytoolchiyl#base#lua_value_to_markdown_table#pgame()<CR>

        anoremenu <silent> PopUp.T&inytool.markdown.select_lua_val_to_table.help
                    \ :call tinytoolchiyl#base#lua_value_to_markdown_table#help()<CR>

        anoremenu <silent> PopUp.T&inytool.markdown.emmylua_class_to_table.run
                    \ :call tinytoolchiyl#base#lua_value_to_markdown_table#emmylua_class_to_markdown_table()<CR>

        anoremenu <silent> PopUp.T&inytool.markdown.emmylua_class_to_table.help
                    \ :call tinytoolchiyl#base#lua_value_to_markdown_table#emmylua_class_to_markdown_table_help()<CR>

        anoremenu <silent> PopUp.T&inytool.markdown.image_paste.run
                    \ :call mdip#MarkdownClipboardImage()<CR>

        anoremenu <silent> PopUp.T&inytool.markdown.image_paste.help
                    \ :echom "查看 bundle/img-paste.vim/README.md"<CR>

        anoremenu <silent> PopUp.T&inytool.search_select_text.Mygrep
                    \ :call tinytoolchiyl#base#mygrep#mygrep_select_text()<CR>

        anoremenu <silent> PopUp.T&inytool.search_select_text.grep
                    \ :call tinytoolchiyl#base#mygrep#grep_select_text()<CR>

        anoremenu <silent> PopUp.T&inytool.search_select_text.grep_add
                    \ :call tinytoolchiyl#base#mygrep#grepadd_select_text()<CR>

        anoremenu <silent> PopUp.T&inytool.search_select_text.history_search_result
                    \ :chi<CR>

        anoremenu <silent> PopUp.T&inytool.search_select_text.last_search_result
                    \ :colder<CR>

        anoremenu <silent> PopUp.T&inytool.search_select_text.next_search_result
                    \ :cnewer<CR>

        anoremenu <silent> PopUp.T&inytool.search_select_text.newest_search_result
                    \ :cnewer 99<CR>

        anoremenu <silent> PopUp.T&inytool.search_select_text.help
                    \ :call tinytoolchiyl#base#mygrep#help()<CR>

        anoremenu <silent> PopUp.T&inytool.jump_edit.prev
                    \ :call tinytoolchiyl#base#goto_marks_switch_win#GotoPrevEdit()<CR>
        
        anoremenu <silent> PopUp.T&inytool.jump_edit.next
                    \ :call tinytoolchiyl#base#goto_marks_switch_win#GotoNextEdit()<CR>

        anoremenu <silent> PopUp.T&inytool.jump_edit.show
                    \ :call tinytoolchiyl#base#goto_marks_switch_win#ShowEditPositions()<CR>

        anoremenu <silent> PopUp.T&inytool.jump_edit.help
                    \ :call tinytoolchiyl#base#goto_marks_switch_win#ShowHelp()<CR> 

        anoremenu <silent> PopUp.T&inytool.flomo.upload
                    \ :call tinytoolchiyl#base#flomo#flomo_upload()<CR>

        anoremenu <silent> PopUp.T&inytool.flomo.edit_config
                    \ :call tinytoolchiyl#base#flomo#edit_config()<CR>

        anoremenu <silent> PopUp.T&inytool.flomo.help
                    \ :call tinytoolchiyl#base#flomo#help()<CR>

        anoremenu <silent> PopUp.T&inytool.python.ruff_format
                    \ :call tinytoolchiyl#base#mypython#ruff_format()<CR>

        anoremenu <silent> PopUp.T&inytool.python.ruff_check_fix
                    \ :call tinytoolchiyl#base#mypython#ruff_check_fix()<CR>

        anoremenu <silent> PopUp.T&inytool.select_hex_to_dec
                    \ :call tinytoolchiyl#base#hexToDec#SelectHexToDec()<CR>

        "anoremenu <silent> PopUp.T&inytool.touch_files_in_clipboard
        "            \ :call tinytoolchiyl#base#touch_files_in_clipboard#doit()<CR>
        
        anoremenu <silent> PopUp.T&inytool.clean_all_vimtmpfile
                    \ : call tinytoolchiyl#base#gettmploopfilename#clean_all_vimtmpfile()<CR>

        anoremenu <silent> PopUp.T&inytool.mygrep
                    \ : call confirm("执行自定义命令:Mygrep xxx 即可")<CR>

        anoremenu <silent> PopUp.T&inytool.sort_uniq
                    \ :'<,'>sort u<CR> :echom "sort u" <CR>

        anoremenu <silent> PopUp.T&inytool.sort_by_datetimestr
                    \ :call tinytoolchiyl#base#myutil#sort_by_datetimestr()<CR>

        anoremenu <silent> PopUp.T&inytool.lgame.p4.edit_all_protocol_files
                    \ :call ctrlp#myp4#P4Protocol()<CR><CR>:call ctrlp#myp4#P4Opened()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.lgame.p4.edit_all_lua_doc_files
                    \ :call tinytoolchiyl#base#p4#P4EditAllLuaDocFiles()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.lgame.p4.edit_all_idip_protocol_files
                    \ :call tinytoolchiyl#base#p4#P4EditAllIdipFiles()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.lgame.p4.targz_all_idip_protocol_files
                    \ :call tinytoolchiyl#base#p4#tar_gz_all_idip_protocol_files()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.lgame.p4.revert_all_files
                    \ :call ctrlp#myp4#P4RevertAll()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.lgame.p4.xml2header
                    \ :call ctrlp#mycmd#Xml2Header()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.lgame.p4.cleanxmlheader
                    \ :call ctrlp#mycmd#DelProCfiles()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.lgame.log.zone_deal_tconnd_pkg_to_cmd
                    \ : call tinytoolchiyl#base#zone_deal_tconnd_pkg_to_cmd#doit()<CR>

        anoremenu <silent> PopUp.T&inytool.lgame.log.zone_send_to_client_cs_msg
                    \ : call tinytoolchiyl#base#zone_send_to_client_cs_msg#doit()<CR>

        anoremenu <silent> PopUp.T&inytool.lgame.tlog.csv_to_json_on_lgamesvr
                  \ :call tinytoolchiyl#base#csv_to_json_on_lgamesvr#SelectStructToPandasDtype()<CR>

        anoremenu <silent> PopUp.T&inytool.lgame.tlog.tlog_struct_to_pandas_dtype
                    \ :call tinytoolchiyl#base#tlog_struct_to_pandas_dtype#SelectStructToPandasDtype()<CR>

        anoremenu <silent> PopUp.T&inytool.lgame.tlog.tlog_to_json_on_lgamesvr
                    \ :call tinytoolchiyl#base#tlog_to_json_on_lgamesvr#Doit()<CR>

        anoremenu <silent> PopUp.T&inytool.lgame.parseinfo.tbus_info_intid
                    \ :call tinytoolchiyl#base#businfo#intid()<CR>

        anoremenu <silent> PopUp.T&inytool.lgame.parseinfo.tbus_info_strid
                    \ :call tinytoolchiyl#base#businfo#strid()<CR>

        anoremenu <silent> PopUp.T&inytool.lgame.parseinfo.tbus_info_typeid
                    \ :call tinytoolchiyl#base#businfo#typeid()<CR>

        anoremenu <silent> PopUp.T&inytool.lgame.parseinfo.asyncid_to_info
                    \ : call tinytoolchiyl#base#asyncid_to_info#doit()<CR>

        anoremenu <silent> PopUp.T&inytool.lgame.parseinfo.asyncstr_to_info
                    \ : call tinytoolchiyl#base#asyncstr_to_info#doit()<CR>

        anoremenu <silent> PopUp.T&inytool.lgame.parseinfo.uin_info
                    \ : call tinytoolchiyl#base#uin_info#doit()<CR>

        anoremenu <silent> PopUp.T&inytool.lgame.env.lgamesvr_compile_commands_for_lsp
                    \ : call tinytoolchiyl#base#lsp_setting#lgamesvr()<CR>

        anoremenu <silent> PopUp.T&inytool.lgame.env.find_no_use_asyncid
                    \ :call tinytoolchiyl#base#find_no_use_asyncid#doit()<CR>
          
        anoremenu <silent> PopUp.T&inytool.lgame.env.find_no_use_csmsgid
                    \ :call tinytoolchiyl#base#find_no_use_asyncid#csmsgid()<CR>

        anoremenu <silent> PopUp.T&inytool.lgame.env.find_no_use_ssmsgid
                    \ :call tinytoolchiyl#base#find_no_use_asyncid#ssmsgid()<CR>
        anoremenu <silent> PopUp.T&inytool.lgame.env.update_xml_to_lua
                    \ :!start cmd.exe /c "cd /d D:/GitBase/myLGameTools/proto2lua/dist/ && proto2lua.exe -i G:/CodeBase.p4/main.testclient.Server_proj/protocol -o G:/CodeBase.p4/main.testclient.Server_proj/tools/testclient/script/doc"<CR>
        anoremenu <silent> PopUp.T&inytool.dnf.tlog.tlog_to_json
                    \ :call tinytoolchiyl#base#tlog_to_json_on_dnf_idip2svr#Doit()<CR>
    endif
endif

"创建自定义命令
command! -nargs=1 Mygrep call tinytoolchiyl#base#mygrep#mygrep(<f-args>)

" 添加自定义按钮
:amenu ToolBar.-TinyToolOpen- :
:amenu icon=tinytool_open_conemu.bmp ToolBar.Tinytool_Open_conemu :silent !cmd.exe /c start  ConEmu64 -Dir "%:p:h" <CR>
:tmenu ToolBar.Tinytool_Open_conemu  打开ConEmu.exe并跳转至当前文件所在目录
:amenu icon=tinytool_open_cygwin.bmp ToolBar.Tinytool_Open_cygwin :call tinytoolchiyl#base#openwith#Cygwin()<CR>
:tmenu ToolBar.Tinytool_Open_cygwin  打开Cygwin.exe并跳转至当前文件所在目录
:amenu icon=tinytool_open_folder.bmp ToolBar.Tinytool_Open_folder :silent !cmd.exe /c start  "" "%:p:h" <CR>
:tmenu ToolBar.Tinytool_Open_folder  打开当前文件所在目录
:amenu icon=tinytool_open_notepadplusplus.bmp ToolBar.Tinytool_Open_notepadplusplus :silent !cmd.exe /c start  "notepad++" "%" <CR>
:tmenu ToolBar.Tinytool_Open_notepadplusplus  使用notepad++打开当前文件
:amenu icon=tinytool_open_gitbash.bmp ToolBar.Tinytool_Open_gitbash :silent !cmd.exe /c start  git-bash<CR>
:tmenu ToolBar.Tinytool_Open_gitbash  在当前目录打开Git-Bash
:amenu ToolBar.-TinyToolOther- :
:amenu icon=tinytool_addline.bmp ToolBar.Tinytool_Addline :call tinytoolchiyl#base#pgameinfo#add_debugline()<CR>
:tmenu ToolBar.Tinytool_Addline 给当前添加一个调试语句 log_info("chiyl debuginfo")
:amenu icon=tinytool_logtree.bmp ToolBar.Tinytool_Logtree :call tinytoolchiyl#base#pgameinfo#add_log_tree()<CR>
:tmenu ToolBar.Tinytool_Logtree 给当前添加一个调试语句 log_tree_info("chiyl debuginfo:")


" 设置自动命令以保存编辑位置和更新位置信息
augroup EditPositionTracking
    autocmd!
    autocmd TextChanged,TextChangedI * call tinytoolchiyl#base#goto_marks_switch_win#SaveEditPosition()
augroup END
"在普通模式下跳转到上一个/下一个编辑位置
nmap <silent> <Leader>ep :call tinytoolchiyl#base#goto_marks_switch_win#GotoPrevEdit()<CR>
nmap <silent> <Leader>en :call tinytoolchiyl#base#goto_marks_switch_win#GotoNextEdit()<CR>
nmap <silent> <Leader>es :call tinytoolchiyl#base#goto_marks_switch_win#ShowEditPositions()<CR>
nmap <silent> <Leader>eh :call tinytoolchiyl#base#goto_marks_switch_win#ShowHelp()<CR>

