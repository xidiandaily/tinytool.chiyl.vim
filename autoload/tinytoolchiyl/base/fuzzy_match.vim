"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2024.08.22
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

let g:my_tinytool_chiyl_fuzzy_match_left_content  = ''
let g:my_tinytool_chiyl_fuzzy_match_right_content = ''

function! tinytoolchiyl#base#fuzzy_match#help()
    echom "================================"
    echom "left selet content:"
    echom "[test.logout] = true,"
    echom "[test.server_kick] = true"
    echom " "
    echom " "
    echom " "
    echom "================================"
    echom "right select content:"
    echom "logout = 0, -- 退出"
    echom "xxx = 1 , -- xxx"
    echom "server_kick = 2， --- 踢出"
    echom " "
    echom " "
    echom " "
    echom "================================"
    echom "out:"
    echom ""
    echom "[test.logout] = true,      ### logout = 0, -- 退出"
    echom "[test.server_kick] = true  ### server_kick = 2， --- 踢出"
    echom " "
    echom " "
    echom " "
endfunction

function! tinytoolchiyl#base#fuzzy_match#select_left_text_for_match()
    let g:my_tinytool_chiyl_fuzzy_match_left_content = tinytoolchiyl#base#myutil#get_selected_text()
    echom "select left text for match done"
endfunction

function! tinytoolchiyl#base#fuzzy_match#match_right_text()
    let g:my_tinytool_chiyl_fuzzy_match_right_content = tinytoolchiyl#base#myutil#get_selected_text()

    if len(g:my_tinytool_chiyl_fuzzy_match_left_content) == 0
        echom "select left text for match is empty"
        return
    end

    if len(g:my_tinytool_chiyl_fuzzy_match_right_content) == 0
        echom "select right text for match is empty"
        return
    end

    let s:left=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:right=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:out=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:prev_win=win_getid()
    if filereadable(s:left)
        call delete(s:left)
    endif
    call writefile(split(g:my_tinytool_chiyl_fuzzy_match_left_content,"\n"),s:left)
    
    if filereadable(s:right)
        call delete(s:right)
    endif
    call writefile(split(g:my_tinytool_chiyl_fuzzy_match_right_content,"\n"),s:right)

    if filereadable(s:out)
        call delete(s:out)
    endif
    silent! execute 'python' . (has('python3') ? '3' : '') . ' fuzzy_match("'.s:left.'","'.s:right.'","'.s:out.'")'
    call win_gotoid(s:prev_win)
    call ctrlp#mybase#ctrlp_open_new_win(s:left,1)
    call ctrlp#mybase#ctrlp_open_new_win(s:right,1)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction


