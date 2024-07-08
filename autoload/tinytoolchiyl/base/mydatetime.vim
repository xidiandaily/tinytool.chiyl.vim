"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.08.29
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

let s:exe_path=escape(expand('<sfile>:p:h'),'\').'/../../../bin/exe/'

function! tinytoolchiyl#base#mydatetime#timestamp_to_utc8()
    "let s:in='.vimtmp.in.timestamp_to_utc8'
    "let s:out='.vimtmp.out.timestamp_to_utc8'
    let s:in=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:out=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:prev_win=win_getid()
    "if filereadable(s:in)
    "    call delete(s:in)
    "endif
    "if filereadable(s:out)
    "    call delete(s:out)
    "endif
    "call ctrlp#mybase#close_win_base_on_filename(s:in)
    "call ctrlp#mybase#close_win_base_on_filename(s:out)
    call writefile(split(@*,"\n"),s:in)
    silent! execute '!'.s:exe_path.'/timestamp_to_utc8.exe -i '.s:in.' -o '.s:out
    call win_gotoid(s:prev_win)
    "if filereadable(s:in)
    "    call delete(s:in)
    "endif
    call ctrlp#mybase#ctrlp_open_new_win(s:in,1)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
    "if filereadable(s:in)
    "    call delete(s:in)
    "endif
    "if filereadable(s:out)
    "    call delete(s:out)
    "endif
endfunction

function! tinytoolchiyl#base#mydatetime#do_get_timestamp()
python3 << EOF
import vim
import time

current_timestamp = int(time.time())
vim.command("let @* = {}".format(current_timestamp))
EOF
endfunction

function! tinytoolchiyl#base#mydatetime#copy_timestamp()
    call tinytoolchiyl#base#mydatetime#do_get_timestamp()
    :echom "copy to @*:"@*
endfunction

function! tinytoolchiyl#base#mydatetime#copy_1_hour_agotimestamp()
    call tinytoolchiyl#base#mydatetime#do_get_timestamp()
    let @*=@*-60*60
    :echom "copy to @*:"@*
endfunction

function! tinytoolchiyl#base#mydatetime#copy_1_day_agotimestamp()
    call tinytoolchiyl#base#mydatetime#do_get_timestamp()
    let @*=@*-24*60*60
    :echom "copy to @*:"@*
endfunction

function! tinytoolchiyl#base#mydatetime#copy_1_week_agotimestamp()
    call tinytoolchiyl#base#mydatetime#do_get_timestamp()
    let @*=@*-7*24*60*60
    :echom "copy to @*:"@*
endfunction

function! tinytoolchiyl#base#mydatetime#copy_1_month_agotimestamp()
    call tinytoolchiyl#base#mydatetime#do_get_timestamp()
    let @*=@*-30*24*60*60
    :echom "copy to @*:"@*
endfunction

function! tinytoolchiyl#base#mydatetime#copy_str_time()
    let @*=strftime('%Y_%m_%d_%H_%M_%S')
    :echom "copy to @*:".@*
endfunction

