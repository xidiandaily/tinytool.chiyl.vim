"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2024.03.06
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

function! tinytoolchiyl#base#lua_value_to_markdown_table#pgame()
    let l:xml= tinytoolchiyl#base#myutil#get_selected_text()
    let s:in=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:out=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:prev_win=win_getid()
    call writefile(split(l:xml,"\n"),s:in)
    silent! execute 'python' . (has('python3') ? '3' : '') . ' lua_val_to_markdown_table("'.s:in.'","'.s:out.'")'
    call win_gotoid(s:prev_win)
    call ctrlp#mybase#ctrlp_open_new_win(s:in,1)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction

function! tinytoolchiyl#base#lua_value_to_markdown_table#help()
    echom " 选中xml结构，鼠标右键选择: Tinytool->markdown->select_lua_val_to_table->run"
    echom "================================================================================ "
    echom "    activity_8307 = 5907,      -- xxx8307"
    echom "    activity_8308 = 5908,      -- xxx8308"
    echom "    activity_8309 = 5909,      -- xxx8309"
    echom "    activity_8310 = 5910,      -- xxx8310"
    echom "    activity_8311 = 5911,      -- xxx8311"
    echom "    activity_8312 = 5912,      -- xxx8312"
    echom "    activity_8313 = 5913,      -- xxx8313"
    echom "    activity_8315 = 5914,      -- xxx8315"
    echom "    activity_8316 = 5915,      -- xxx8316"
    echom " "
    echom "================================================================================"
    echom ""
    echom "| 类型 | 取值 | 说明 |"
    echom "| --- | --- | --- |"
    echom "| activity_8307 | 5907 |  xxx8307 |"
    echom "| activity_8308 | 5908 |  xxx8308 |"
    echom "| activity_8309 | 5909 |  xxx8309 |"
    echom "| activity_8310 | 5910 |  xxx8310 |"
    echom "| activity_8311 | 5911 |  xxx8311 |"
    echom "| activity_8312 | 5912 |  xxx8312 |"
    echom "| activity_8313 | 5913 |  xxx8313 |"
    echom "| activity_8315 | 5914 |  xxx8315 |"
    echom "| activity_8316 | 5915 |  xxx8316 |"
    echom "  "
endfunction

function! tinytoolchiyl#base#lua_value_to_markdown_table#emmylua_class_to_markdown_table()
    let l:xml= tinytoolchiyl#base#myutil#get_selected_text()
    let s:in=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:out=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:prev_win=win_getid()
    call writefile(split(l:xml,"\n"),s:in)
    silent! execute 'python' . (has('python3') ? '3' : '') . ' emmylua_class_to_markdown_table("'.s:in.'","'.s:out.'")'
    call win_gotoid(s:prev_win)
    call ctrlp#mybase#ctrlp_open_new_win(s:in,1)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction

function! tinytoolchiyl#base#lua_value_to_markdown_table#emmylua_class_to_markdown_table_help()
    echom "选中xml结构，鼠标右键选择: Tinytool->markdown->emmylua_class_to_table->run"
    echom "================================================================================"
    echom "---test"
    echom "---@class testforexample"
    echom "---@field f1 number @字段1"
    echom "---@field f2 string @字段2"
    echom "---@field f3 tale   @字段3"
    echom "---@field f4 any"
    echom " "
    echom " "
    echom "================================================================================"
    echom "| | testforexample |"
    echom "| --- | --- | --- |"
    echom "| f1 | number | @字段1 |"
    echom "| f2 | string | @字段2 |"
    echom "| f3 | tale | @字段3 |"
    echom "| f4 | any |  |"
    echom " "
    echom " "
endfunction

