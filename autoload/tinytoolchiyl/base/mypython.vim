"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2025.06.19
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

" 
function! tinytoolchiyl#base#mypython#ruff_format()
  " 获取当前文件名和扩展名
  let l:filename = expand('%:p')
  let l:ext = expand('%:e')

  " 判断扩展名是否是 py
  if l:ext !=# 'py'
    echohl ErrorMsg
    echo "当前文件不是 Python 文件，不能执行 ruff 格式化命令"
    echohl None
    return
  endif

  " 执行 ruff format 命令
  execute '!ruff format ' . shellescape(l:filename)
endfunction

function! tinytoolchiyl#base#mypython#ruff_check_fix()
  " 获取当前文件名和扩展名
  let l:filename = expand('%:p')
  let l:ext = expand('%:e')

  " 判断扩展名是否是 py
  if l:ext !=# 'py'
    echohl ErrorMsg
    echo "当前文件不是 Python 文件，不能执行 ruff 格式化命令"
    echohl None
    return
  endif

  " 执行 ruff check fix 命令
  execute '!ruff check ' . shellescape(l:filename) . ' --fix'
endfunction

