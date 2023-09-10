"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.09.09
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

function! tinytoolchiyl#base#asyncstr_to_info#doit()
    let s:in='.vimtmp.in.asyncstr_to_info'
    let s:out='.vimtmp.out.asyncstr_to_info'
    let s:prev_win=win_getid()
    if filereadable(s:in)
        call delete(s:in)
    endif
    if filereadable(s:out)
        call delete(s:out)
    endif
    call writefile(split(@*,"\n"),s:in)
    silent! execute 'python' . (has('python3') ? '3' : '') . ' asyncstr_to_info("'.s:in.'","'.s:out.'")'
    call win_gotoid(s:prev_win)
    call ctrlp#mybase#ctrlp_open_new_win(s:in,1)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction

