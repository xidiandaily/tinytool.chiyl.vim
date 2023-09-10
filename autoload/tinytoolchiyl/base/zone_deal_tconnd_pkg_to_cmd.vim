"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.09.08
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================
let s:cscmd_path="./protocol/star_cs.xml"

function! tinytoolchiyl#base#zone_deal_tconnd_pkg_to_cmd#doit()
    let s:in='.vimtmp.in.zone_deal_tconnd_pkg_to_cmd'
    let s:out='.vimtmp.out.zone_deal_tconnd_pkg_to_cmd'
    let s:prev_win=win_getid()
    if filereadable(s:in)
        call delete(s:in)
    endif
    if filereadable(s:out)
        call delete(s:out)
    endif
    call writefile(split(@*,"\n"),s:in)
    silent! execute 'python' . (has('python3') ? '3' : '') . ' zone_deal_tconnd_pkg_to_cmd("'.s:in.'","'.s:out.'","'.s:cscmd_path.'")'
    call win_gotoid(s:prev_win)
    call ctrlp#mybase#ctrlp_open_new_win(s:in,1)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction

