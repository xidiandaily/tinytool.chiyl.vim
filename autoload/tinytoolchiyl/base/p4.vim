"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.08.29
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

let s:p4_config=".p4config"

function! tinytoolchiyl#base#p4#P4EditAllIdipFiles()
    execute ':!p4  edit gameidipsvr/lgame_idip_convert10.cpp gameidipsvr/lgame_idip_convert8.cpp gameidipsvr/lgame_idip_convert9.cpp gameidipsvr/lgame_idip_comm.cpp gameidipsvr/lgame_idip_convert1.cpp gameidipsvr/lgame_idip_convert2.cpp gameidipsvr/lgame_idip_convert3.cpp gameidipsvr/lgame_idip_convert4.cpp gameidipsvr/lgame_idip_convert5.cpp gameidipsvr/lgame_idip_convert6.cpp gameidipsvr/lgame_idip_convert7.cpp gameidipsvr/lgame_idip_comm.h gameidipsvr/lgame_idip_convert.h gameidipsvr/lgame_idip_protocol.h'
endfunction

function! tinytoolchiyl#base#p4#P4EditAllLuaDocFiles()
    execute ':!p4 edit script/doc/star_aisvr.lua script/doc/star_comm.lua script/doc/star_cs.lua script/doc/star_def.lua script/doc/star_macro.lua script/doc/star_shm2db.lua script/doc/star_ss.lua script/doc/star_sync.lua'
endfunction

function! tinytoolchiyl#base#p4#tar_gz_all_idip_protocol_files()
    :new
    :put = 'cd gameidipsvr && python jsonbinconvert.py && tar -czf cur_idip_protocol.tar.gz lgame_idip_convert10.cpp lgame_idip_convert8.cpp lgame_idip_convert9.cpp lgame_idip_comm.cpp lgame_idip_convert1.cpp lgame_idip_convert2.cpp lgame_idip_convert3.cpp lgame_idip_convert4.cpp lgame_idip_convert5.cpp lgame_idip_convert6.cpp lgame_idip_convert7.cpp lgame_idip_comm.h lgame_idip_convert.h lgame_idip_protocol.h && ll -th |head && sz cur_idip_protocol.tar.gz'
    :put = "\r\n"
    :put = 'hello'
endfunction


function! tinytoolchiyl#base#p4#P4EditAllIdipFiles()
    execute ':!p4  edit gameidipsvr/lgame_idip_convert10.cpp gameidipsvr/lgame_idip_convert8.cpp gameidipsvr/lgame_idip_convert9.cpp gameidipsvr/lgame_idip_comm.cpp gameidipsvr/lgame_idip_convert1.cpp gameidipsvr/lgame_idip_convert2.cpp gameidipsvr/lgame_idip_convert3.cpp gameidipsvr/lgame_idip_convert4.cpp gameidipsvr/lgame_idip_convert5.cpp gameidipsvr/lgame_idip_convert6.cpp gameidipsvr/lgame_idip_convert7.cpp gameidipsvr/lgame_idip_comm.h gameidipsvr/lgame_idip_convert.h gameidipsvr/lgame_idip_protocol.h'
endfunction

"if has('gui_running')
"  if filereadable(s:p4_config)
"      if &mousemodel =~? 'popup'
"          anoremenu <silent> PopUp.L&aw.p4.edit_all_protocol_files
"                      \ :call ctrlp#myp4#P4Protocol()<CR><CR>:call ctrlp#myp4#P4Opened()<CR><CR>
"
"          anoremenu <silent> PopUp.L&aw.p4.edit_all_idip_protocol_files
"                      \ :call protocol#P4EditAllIdipFiles()<CR><CR>
"
"          anoremenu <silent> PopUp.L&aw.p4.targz_all_idip_protocol_files
"                      \ :call protocol#tar_gz_all_idip_protocol_files()<CR><CR>
"
"          anoremenu <silent> PopUp.L&aw.p4.revert_all_files
"                      \ :call ctrlp#myp4#P4RevertAll()<CR><CR>
"          
"      endif
"  endif
"endif
