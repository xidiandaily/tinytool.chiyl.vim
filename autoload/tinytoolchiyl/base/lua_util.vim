"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2024.03.22
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

function! tinytoolchiyl#base#lua_util#get_lua_function()
    " 获取当前行号
    let current_line = line('.')
    
    " 从当前行向上搜索，直到第一行
    let start_line = current_line
    while start_line > 0
        " 检查行是否匹配正则表达式
        let line_text = getline(start_line)
        if line_text =~ '^.*function\s\+\([a-zA-Z0-9_\.]\+\)('
            " 匹配到的内容
            let outline = substitute(line_text, '^.*function\s\+\([a-zA-Z0-9_\.]\+\)(.*', '\1', '')
            echomsg outline
            return outline
        endif

        " 继续向上搜索
        let start_line -= 1
    endwhile
    echomsg "No matching line found."
    return ''
endfunction

