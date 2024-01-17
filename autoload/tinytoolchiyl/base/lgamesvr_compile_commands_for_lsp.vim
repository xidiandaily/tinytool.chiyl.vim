"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.09.11
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

function! tinytoolchiyl#base#lgamesvr_compile_commands_for_lsp#doit()
    let s:out='compile_commands.json'
    let s:in = substitute(getcwd(), '\\', '/', 'g')
    echom s:in
    silent! execute 'python' . (has('python3') ? '3' : '') . ' directory_to_compile_commands_file("'.s:in.'","'.s:out.'")'
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction

function! tinytoolchiyl#base#lgamesvr_compile_commands_for_lsp#grep_ignore_files()
    let s:out='.agignore'
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction
