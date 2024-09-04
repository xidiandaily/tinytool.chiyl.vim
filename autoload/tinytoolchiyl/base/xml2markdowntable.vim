"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2024.03.06
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

function! tinytoolchiyl#base#xml2markdowntable#pgame()
    let l:xml= tinytoolchiyl#base#myutil#get_selected_text()
    let s:in=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:out=tinytoolchiyl#base#gettmploopfilename#getname()
    let s:prev_win=win_getid()
    call writefile(split(l:xml,"\n"),s:in)
    silent! execute 'python' . (has('python3') ? '3' : '') . ' xml2markdowntable("'.s:in.'","'.s:out.'")'
    call win_gotoid(s:prev_win)
    call ctrlp#mybase#ctrlp_open_new_win(s:in,1)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction

function! tinytoolchiyl#base#xml2markdowntable#help()
    echom " 选中xml结构，鼠标右键选择: Tinytool->markdown->select_xml_struct_to_markdowtable->run"
    echom " "
    echom " ================================================================================"
    echom " <struct name='cos_image_upload_rsp' type='rsp' desc='xxx功能'>"
    echom "     <entry name='ret_code'          type='int'    desc='错误码'/>"
    echom "     <entry name='cos_image_id'      type='int'    desc='上传图片的业务ID,取值方位见cs_define.cos_image_id'/>"
    echom "     <entry name='upload_id'         type='string' desc='文件所属id'/>"
    echom "     <entry name='rsp_url_info_list' type='table'  desc='url信息,结构定义rsp_url_info'/>"
    echom " </struct>"
    echom " "
    echom " ================================================================================"
    echom " "
    echom " | | cos_image_upload_rsp |"
    echom " | --- | --- | --- |"
    echom " | int | ret_code | 错误码 |"
    echom " | int | cos_image_id | 上传图片的业务ID,取值方位见cs_define.cos_image_id |"
    echom " | string | upload_id | 文件所属id |"
    echom " | table | rsp_url_info_list | url信息,结构定义rsp_url_info |"
    echom " "
    echom " "
    echom " "
    echom " ================================================================================"
    echom "     <macrosgroup name='client_device_type'>"
    echom "         <macro name='mobile' value='0' desc='手机' />"
    echom "         <macro name='simulator' value='1' desc='PC模拟器' />"
    echom "         <macro name='keyboard' value='2' desc='外设键鼠' />"
    echom "         <macro name='handle' value='3' desc='外设手柄' />"
    echom "         <macro name='WinClient' value='4' desc='WinClient端' />"
    echom "     </macrosgroup>"
    echom " "
    echom " "
    echom " ================================================================================"
    echom " | | client_device_type |"
    echom " | --- | --- |"
    echom " | mobile | 手机 |"
    echom " | simulator | PC模拟器 |"
    echom " | keyboard | 外设键鼠 |"
    echom " | handle | 外设手柄 |"
    echom " | WinClient | WinClient端 |"
endfunction

