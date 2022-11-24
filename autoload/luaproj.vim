"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2022.11.18
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

fu! luaproj#init()
    #let s:map_F12=maparg('<F12>')
    #if exists('g:proj_type') && g:proj_type=='vim'
    #    "echohl WarningMsg | echom "has already define luaproj"| echohl None
    #    "do nothing
    #else
    #    :map <buffer> <F12> :silent execute '!ctags -f vim.tags -R --languages=Vim --c++-kinds=+p --fields=+iaS  .'<CR><CR>
    #endif
    return 0
endfu


fu! luaproj#jump_to_tag()
    let s:word=expand("<cword>")
    let s:target="lrv51-".s:word
    echo s:target
    sil exe ':tag '.s:target
endfu

