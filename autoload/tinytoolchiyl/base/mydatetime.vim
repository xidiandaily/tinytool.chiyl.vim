"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.08.29
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

let s:exe_path=escape(expand('<sfile>:p:h'),'\').'/../../../bin/exe/'

function! tinytoolchiyl#base#mydatetime#timestamp_to_utc8()
    let s:in='.vimtmp.in.timestamp_to_utc8'
    let s:out='.vimtmp.out.timestamp_to_utc8'
    let s:prev_win=win_getid()
    if filereadable(s:in)
        call delete(s:in)
    endif
    if filereadable(s:out)
        call delete(s:out)
    endif
    call ctrlp#mybase#close_win_base_on_filename(s:in)
    call ctrlp#mybase#close_win_base_on_filename(s:out)
    call writefile(split(@*,"\n"),s:in)
    silent! execute '!'.s:exe_path.'/timestamp_to_utc8.exe -i '.s:in.' -o '.s:out
    call win_gotoid(s:prev_win)
    "if filereadable(s:in)
    "    call delete(s:in)
    "endif
    call ctrlp#mybase#ctrlp_open_new_win(s:in,0)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,0)
    "if filereadable(s:in)
    "    call delete(s:in)
    "endif
    "if filereadable(s:out)
    "    call delete(s:out)
    "endif
endfunction

