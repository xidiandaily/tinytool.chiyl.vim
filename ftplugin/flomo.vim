"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2025.01.05
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================
"

if exists('b:did_ftplugin')
    finish
endif

if !exists('g:flomo_tags')
    let g:flomo_tags = []
endif

if !exists('g:flomo_url')
    let g:flomo_url = ''
endif

let b:did_ftplugin = 1

" 保存原始设置
let b:old_colorscheme = get(g:, 'colors_name', '')
let b:old_guifont = &guifont
let b:old_rnu = &rnu
let b:old_colorcolumn = &colorcolumn
let b:old_wrap = &wrap
let b:old_bg = &bg
let b:old_foldenable = &foldenable

" 应用flomo专用设置
colorscheme pencil
set guifont=Bitstream_Vera_Sans_Mono:h12:cANSI:qDRAFT
set nornu
set colorcolumn=0
set wrap
set bg=light
set nofoldenable
SoftPencil
Goyo

" 设置补全函数
setlocal completefunc=tinytoolchiyl#base#flomo#flomo_tag_complete

" 映射#键自动触发补全
inoremap <buffer> # #<C-x><C-u>

" 上传快捷键
nnoremap <buffer> <F7> :call tinytoolchiyl#base#flomo#flomo_confirm_upload()<CR>

" 在buffer被删除时恢复原来的设置
if !exists('b:undo_ftplugin')
    let b:undo_ftplugin = ''
endif

if !empty(b:undo_ftplugin)
    let b:undo_ftplugin .= ' | '
endif

" 恢复原来的completefunc设置
let b:undo_ftplugin .= 'setlocal completefunc<'
let b:undo_ftplugin .= ' | execute "iunmap <buffer> #"'
let b:undo_ftplugin .= ' | execute "nunmap <buffer> <F7>"' 
let b:undo_ftplugin .= ' | execute "colorscheme " . get(b:, "old_colorscheme", "default")'
let b:undo_ftplugin .= ' | let &guifont = get(b:, "old_guifont", &guifont)'
let b:undo_ftplugin .= ' | let &rnu = get(b:, "old_rnu", &rnu)'
let b:undo_ftplugin .= ' | let &colorcolumn = get(b:, "old_colorcolumn", &colorcolumn)'
let b:undo_ftplugin .= ' | let &wrap = get(b:, "old_wrap", &wrap)'
let b:undo_ftplugin .= ' | let &bg = get(b:, "old_bg", &bg)'
let b:undo_ftplugin .= ' | let &foldenable = get(b:, "old_foldenable", &foldenable)'
let b:undo_ftplugin .= ' | execute "NoPencil"'
