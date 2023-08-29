"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.08.29
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

"if exists('g:tinytoolchiyl')
"    finish
"endif
"let g:tinytoolchiyl = 1

" 加载python配置
let s:plugin_path=escape(expand('<sfile>:p:h'),'\')
let s:filelist=glob(s:plugin_path . '/python/script/*.py')

for _file in s:filelist
    if has('python3')
        execute 'py3file ' ._file
    else
        execute 'pyfile ' ._file
    endif
endfor

"一些默认配置
if has('gui_running')
    if &mousemodel =~? 'popup'
        anoremenu <silent> PopUp.T&inytool.timestamp_to_utc8
                    \ :call tinytoolchiyl#base#mydatetime#timestamp_to_utc8()<CR>
    endif
endif
