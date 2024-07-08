"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2024.03.14
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

let s:tlog_path="./bin/luascript/tlog_desc/generate_tdw/apgame_tdw_tlog.xml"

function! tinytoolchiyl#base#tlog_to_json_on_pgamesvr#Doit()
    let s:in=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:out=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:prev_win=win_getid()
    let l:tlog=s:tlog_path
    if filereadable(s:in)
        call delete(s:in)
    endif
    if filereadable(s:out)
        call delete(s:out)
    endif
    call writefile(split(@*,"\n"),s:in)
    if filereadable(l:tlog)
        silent! execute 'python' . (has('python3') ? '3' : '') . ' tlog_to_json_on_pgamesvr("'.s:in.'","'.s:out.'","'.l:tlog.'")'
    else
        call writefile("tlogfile not found:".l:tlog,s:out)
    endif
    call win_gotoid(s:prev_win)
    call ctrlp#mybase#ctrlp_open_new_win(s:in,1)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction

