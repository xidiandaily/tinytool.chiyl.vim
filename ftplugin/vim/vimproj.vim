"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2022.10.29
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

if !vimproj#init()
    finish
endif

:set tags=vim.tags,./tags,C:\Vim\vimfiles\bundle\vimcdoc\doc\tags-cn
:map \d :call vimproj#jump_to_cmd()<CR>
:map \g :call vimproj#jump_to_function()<CR>
