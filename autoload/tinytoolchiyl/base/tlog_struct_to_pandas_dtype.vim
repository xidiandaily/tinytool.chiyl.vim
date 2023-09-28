"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.07.13
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

function! s:GetSelectedText(out)
  let [start_row, start_col] = getpos("'<")[1:2]
  let [end_row, end_col] = getpos("'>")[1:2]
  let sel=getline(start_row, end_row)
  echom "select text:". join(getline(start_row, end_row),"\n")
  call writefile(getline(start_row, end_row),a:out)
endfunction

function! tinytoolchiyl#base#tlog_struct_to_pandas_dtype#SelectStructToPandasDtype()
    let s:in=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:out=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:prev_win=win_getid()
    call s:GetSelectedText(s:in)
    silent! execute 'python' . (has('python3') ? '3' : '') . ' tlog_struct_to_pandas_dtype("'.s:in.'","'.s:out.'")'
    call win_gotoid(s:prev_win)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction

