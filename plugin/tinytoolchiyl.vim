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

function! protocol#P4EditAllIdipFiles()
    execute ':!p4  edit gameidipsvr/lgame_idip_convert10.cpp gameidipsvr/lgame_idip_convert8.cpp gameidipsvr/lgame_idip_convert9.cpp gameidipsvr/lgame_idip_comm.cpp gameidipsvr/lgame_idip_convert1.cpp gameidipsvr/lgame_idip_convert2.cpp gameidipsvr/lgame_idip_convert3.cpp gameidipsvr/lgame_idip_convert4.cpp gameidipsvr/lgame_idip_convert5.cpp gameidipsvr/lgame_idip_convert6.cpp gameidipsvr/lgame_idip_convert7.cpp gameidipsvr/lgame_idip_comm.h gameidipsvr/lgame_idip_convert.h gameidipsvr/lgame_idip_protocol.h'
endfunction

function! protocol#tar_gz_all_idip_protocol_files()
    :new
    :put = 'cd gameidipsvr && python jsonbinconvert.py && tar -czf cur_idip_protocol.tar.gz lgame_idip_convert10.cpp lgame_idip_convert8.cpp lgame_idip_convert9.cpp lgame_idip_comm.cpp lgame_idip_convert1.cpp lgame_idip_convert2.cpp lgame_idip_convert3.cpp lgame_idip_convert4.cpp lgame_idip_convert5.cpp lgame_idip_convert6.cpp lgame_idip_convert7.cpp lgame_idip_comm.h lgame_idip_convert.h lgame_idip_protocol.h && ll -th |head && sz cur_idip_protocol.tar.gz'
    :put = "\r\n"
    :put = 'hello'
endfunction


"一些默认配置
if has('gui_running')
    if &mousemodel =~? 'popup'
        anoremenu <silent> PopUp.T&inytool.timestamp_to_utc8
                    \ :call tinytoolchiyl#base#mydatetime#timestamp_to_utc8()<CR>

        anoremenu <silent> PopUp.T&inytool.zone_deal_tconnd_pkg_to_cmd
                    \ : call tinytoolchiyl#base#zone_deal_tconnd_pkg_to_cmd#doit()<CR>

        anoremenu <silent> PopUp.T&inytool.zone_send_to_client_cs_msg
                    \ : call tinytoolchiyl#base#zone_send_to_client_cs_msg#doit()<CR>

        anoremenu <silent> PopUp.T&inytool.asyncstr_to_info
                    \ : call tinytoolchiyl#base#asyncstr_to_info#doit()<CR>

        anoremenu <silent> PopUp.T&inytool.touch_files_in_clipboard
                    \ :call tinytoolchiyl#base#touch_files_in_clipboard#doit()<CR>

        anoremenu <silent> PopUp.T&inytool.p4.edit_all_protocol_files
                    \ :call ctrlp#myp4#P4Protocol()<CR><CR>:call ctrlp#myp4#P4Opened()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.p4.edit_all_idip_protocol_files
                    \ :call protocol#P4EditAllIdipFiles()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.p4.targz_all_idip_protocol_files
                    \ :call protocol#tar_gz_all_idip_protocol_files()<CR><CR>

        anoremenu <silent> PopUp.T&inytool.p4.revert_all_files
                    \ :call ctrlp#myp4#P4RevertAll()<CR><CR>
          
    endif
endif
