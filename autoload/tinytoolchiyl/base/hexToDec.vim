"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.07.13
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

" 将十六进制数字转成10进制数字
function! tinytoolchiyl#base#hexToDec#SelectHexToDec()
    let sel = tinytoolchiyl#base#myutil#get_selected_text()

    let hex_pattern = '\v0x[0-9a-fA-F]+'
    let hex_string = matchstr(sel, hex_pattern)
    if empty(hex_string)
        echom "select text:". sel." No hex string found"
    endif
    let dec_value = str2nr(hex_string, 16)
    echom "select text:". hex_string." Decimal value: " .dec_value
endfunction

