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
        anoremenu <silent> PopUp.T&inytool.p4.edit_all_protocol_files
                    \ :call ctrlp#myp4#P4Protocol()<CR><CR>:call ctrlp#myp4#P4Opened()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.p4.edit_all_lua_doc_files
                    \ :call tinytoolchiyl#base#p4#P4EditAllLuaDocFiles()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.p4.edit_all_idip_protocol_files
                    \ :call tinytoolchiyl#base#p4#P4EditAllIdipFiles()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.p4.targz_all_idip_protocol_files
                    \ :call tinytoolchiyl#base#p4#tar_gz_all_idip_protocol_files()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.p4.revert_all_files
                    \ :call ctrlp#myp4#P4RevertAll()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.log.zone_deal_tconnd_pkg_to_cmd
                    \ : call tinytoolchiyl#base#zone_deal_tconnd_pkg_to_cmd#doit()<CR>

        anoremenu <silent> PopUp.T&inytool.log.zone_send_to_client_cs_msg
                    \ : call tinytoolchiyl#base#zone_send_to_client_cs_msg#doit()<CR>

        anoremenu <silent> PopUp.T&inytool.log.asyncstr_to_info
                    \ : call tinytoolchiyl#base#asyncstr_to_info#doit()<CR>

        anoremenu <silent> PopUp.T&inytool.log.asyncid_to_info
                    \ : call tinytoolchiyl#base#asyncid_to_info#doit()<CR>

        anoremenu <silent> PopUp.T&inytool.tlog.csv_to_json_on_lgamesvr
                  \ :call tinytoolchiyl#base#csv_to_json_on_lgamesvr#SelectStructToPandasDtype()<CR>

        anoremenu <silent> PopUp.T&inytool.tlog.tlog_struct_to_pandas_dtype
                    \ :call tinytoolchiyl#base#tlog_struct_to_pandas_dtype#SelectStructToPandasDtype()<CR>

        anoremenu <silent> PopUp.T&inytool.tlog.tlog_to_json_on_lgamesvr
                    \ :call tinytoolchiyl#base#tlog_to_json_on_lgamesvr#Doit()<CR>

        anoremenu <silent> PopUp.T&inytool.tarfile.modify
                    \ :call tinytoolchiyl#base#find_modified_files#tarfiles(substitute(getcwd(),'\\','\\\\','g'),1)<CR>

        anoremenu <silent> PopUp.T&inytool.tarfile.All
                    \ :call tinytoolchiyl#base#find_modified_files#tarfiles(substitute(getcwd(),'\\','\\\\','g'),2)<CR>

        anoremenu <silent> PopUp.T&inytool.tarfile.SetTstamp
                    \ :call tinytoolchiyl#base#find_modified_files#tarfiles(substitute(getcwd(),'\\','\\\\','g'),3)<CR>

        anoremenu <silent> PopUp.T&inytool.tarfile.Clean
                    \ :call tinytoolchiyl#base#find_modified_files#tarfiles(substitute(getcwd(),'\\','\\\\','g'),4)<CR>

        anoremenu <silent> PopUp.T&inytool.open.Notepad++
                    \ :silent !cmd.exe /c start  "notepad++" "%" <CR>

        anoremenu <silent> PopUp.T&inytool.open.FileDir
                    \ :silent !cmd.exe /c start  "" "%:p:h" <CR>

        anoremenu <silent> PopUp.T&inytool.open.ConEmu
                    \ :silent !cmd.exe /c start  ConEmu64 -Dir "%:p:h" <CR>

        anoremenu <silent> PopUp.T&inytool.select_hex_to_dec
                    \ :call tinytoolchiyl#base#hexToDec#SelectHexToDec()<CR>

        anoremenu <silent> PopUp.T&inytool.touch_files_in_clipboard
                    \ :call tinytoolchiyl#base#touch_files_in_clipboard#doit()<CR>
          
        anoremenu <silent> PopUp.T&inytool.lgamesvr_compile_commands_for_lsp
                    \ : call tinytoolchiyl#base#lgamesvr_compile_commands_for_lsp#doit()<CR>

        anoremenu <silent> PopUp.T&inytool.clean_all_vimtmpfile
                    \ : call tinytoolchiyl#base#gettmploopfilename#clean_all_vimtmpfile()<CR>

        anoremenu <silent> PopUp.T&inytool.timestamp_to_utc8
                    \ :call tinytoolchiyl#base#mydatetime#timestamp_to_utc8()<CR>

        anoremenu <silent> PopUp.T&inytool.uin_info
                    \ :call tinytoolchiyl#base#uin_info#doit()<CR>

        anoremenu <silent> PopUp.T&inytool.sort_uniq
                    \ :'<,'>sort u<CR> :echom "sort u" <CR>
    endif
endif

"窗口间快速跳转标记位置
command! -nargs=1 WinGotoMark call tinytoolchiyl#base#goto_marks_switch_win#doit(<q-args>)
for mark in ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
    execute "nnoremap <Leader>W" . mark . " :WinGotoMark " . mark . "<CR>"
endfor

" 初始化全局变量
let g:tinytool_chiyl_last_postion = [0, 0, 0, 0]
" 创建自动命令组
augroup TinyToolUpdateLastPosition
    " 清除可能已存在的自动命令
    autocmd!

    " 每次光标移动时，将当前位置存储在 g:last_position 变量中
    autocmd InsertLeave * let curpos = getpos('.') | let curbufnr=bufnr('%') | let g:tinytool_chiyl_last_postion=[curbufnr]+curpos[1:]
augroup END

nnoremap <Leader>WW :call tinytoolchiyl#base#goto_marks_switch_win#last_edit_pos()<CR>
