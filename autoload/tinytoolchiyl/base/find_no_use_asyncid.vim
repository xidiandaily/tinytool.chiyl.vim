"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.11.17
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

function! tinytoolchiyl#base#find_no_use_asyncid#doit()
    let s:out=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:prev_win=win_getid()
    silent! execute 'python' . (has('python3') ? '3' : '') . ' find_no_use_asyncid("'.s:out.'")'
    call win_gotoid(s:prev_win)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction

function! tinytoolchiyl#base#find_no_use_asyncid#ssmsgid()
    let s:out=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:prev_win=win_getid()
    silent! execute 'python' . (has('python3') ? '3' : '') . ' find_no_use_ssmsgid("'.s:out.'")'
    call win_gotoid(s:prev_win)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction

function! tinytoolchiyl#base#find_no_use_asyncid#csmsgid()
    let s:out=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:prev_win=win_getid()
    silent! execute 'python' . (has('python3') ? '3' : '') . ' find_no_use_csmsgid("'.s:out.'")'
    call win_gotoid(s:prev_win)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction

