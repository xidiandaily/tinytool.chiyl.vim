"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.09.08
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================
function! tinytoolchiyl#base#zone_send_to_client_cs_msg#doit()
    let s:in='.vimtmp.in.zone_send_to_client_cs_msg'
    let s:out='.vimtmp.out.zone_send_to_client_cs_msg'
    let s:prev_win=win_getid()
    if filereadable(s:in)
        call delete(s:in)
    endif
    if filereadable(s:out)
        call delete(s:out)
    endif
    call writefile(split(@*,"\n"),s:in)
    silent! execute 'python' . (has('python3') ? '3' : '') . ' zone_send_to_client_cs_msg("'.s:in.'","'.s:out.'")'
    call win_gotoid(s:prev_win)
    call ctrlp#mybase#ctrlp_open_new_win(s:in,1)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction

