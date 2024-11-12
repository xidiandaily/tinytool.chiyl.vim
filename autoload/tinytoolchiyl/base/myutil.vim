"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2024.02.22
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

function! tinytoolchiyl#base#myutil#get_user_input_num(tip,default_val)
    let s:num=input(a:tip.' (default:'.a:default_val.'):')
    if str2nr(s:num,10) == 0
      let s:num=a:default_val
    endif
    return s:num
endfunction

function! tinytoolchiyl#base#myutil#get_user_input_text(tip,default_val)
    let s:text=input(a:tip.' (default:'.a:default_val.'):')
    return s:text
endfunction

function! tinytoolchiyl#base#myutil#get_selected_text() abort
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    if len(lines) == 0
        return ''
    elseif len(lines) == 1
        return lines[0][col1 - 1 : col2 - 1]
    else
        let lines[0] = lines[0][col1 - 1 :]
        let lines[-1] = lines[-1][: col2 - 1]
    endif
    return join(lines, "\n")
endfunction

function! tinytoolchiyl#base#myutil#add_ag_search_ignore_files()
    let s:out='_agignore'
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction

function! tinytoolchiyl#base#myutil#sort_by_datetimestr()
    let s:in=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:out=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:prev_win=win_getid()
    call writefile(split(@*,"\n"),s:in)
    silent! execute 'python' . (has('python3') ? '3' : '') . ' sort_by_datetimestr("'.s:in.'","'.s:out.'")'
    call win_gotoid(s:prev_win)
    call ctrlp#mybase#ctrlp_open_new_win(s:in,1)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction

