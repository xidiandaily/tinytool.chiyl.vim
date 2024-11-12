"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2024.03.07
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

function! tinytoolchiyl#base#mygrep#mygrep(pattern)
  "execute "silent !cmd.exe /c start  ConEmu64 -LoadCfgFile G:/CodeBase.github/vim/vimfiles/bundle/tinytool.chiyl.vim/config/ConEmu_for_mygrep.xml <CR>"
  let l:temp_config=substitute(expand("$VIMPROJ/../vimfiles/bundle/tinytool.chiyl.vim/config/ConEmu_for_mygrep.xml"),"\\","/",'g')
  let l:config=substitute(expand("$VIMPROJ/../vimfiles/bundle/tinytool.chiyl.vim/config/ConEmu_for_mygrep_cur.xml"),"\\","/",'g')
  let l:cmd="ag --nogroup --nocolor --vimgrep -p _agignore ".a:pattern
  let @*=l:cmd
  "echom l:temp_config
  "echom l:config
  "echom l:cmd
  "echom 'python' . (has('python3') ? '3' : '') . ' tinytool_update_conemu_config("'.l:temp_config.'","'.l:config.'","'.l:cmd.'")'
  silent! execute 'python' . (has('python3') ? '3' : '') . ' tinytool_update_conemu_config("'.l:temp_config.'","'.l:config.'","'.l:cmd.'")'
  execute "silent !cmd.exe /c start  ConEmu64 -Title \"".l:cmd."\" -LoadCfgFile " ..l:config
endfunction

function! tinytoolchiyl#base#mygrep#mygrep_select_text()
    let s:select_text = tinytoolchiyl#base#myutil#get_selected_text()
    call tinytoolchiyl#base#mygrep#mygrep(s:select_text)
endfunction

function! tinytoolchiyl#base#mygrep#grep_select_text()
    let s:select_text = tinytoolchiyl#base#myutil#get_selected_text()
    echom "grep ".s:select_text
    execute ':grep '.s:select_text
    :copen
endfunction

function! tinytoolchiyl#base#mygrep#grepadd_select_text()
    let s:select_text = tinytoolchiyl#base#myutil#get_selected_text()
    echom "grepadd ".s:select_text
    execute ':grepadd '.s:select_text
    :copen
endfunction

function! tinytoolchiyl#base#mygrep#help()
    echom "================================================================================"
    echom "快捷键列表:"
    echom "grep当前光标下面的词       nmap <C-@><C-F>      :grep <C-R>=expand(\"<cword>\")<CR><CR>"
    echom "上一个查询结果             nmap <C-@><C-P>      :cp <CR>"
    echom "下一个查询结果             nmap <C-@><C-N>      :cn <CR>"
    echom "列出所有查询结果           nmap <C-@><C-L>      :cl <CR>"
    echom "跳到第一个查询结果         nmap <C-@><C-G><C-G> :cr <CR>"
    echom "跳到最后一个查询结果       nmap <C-@><C-G>      :cla <CR>"
    echom "打开quickfix窗口           nmap <C-@><C-Q>o     :copen <CR>"
    echom "打开quickfix窗口           nmap <C-@><C-Q><C-O> :copen <CR>"
    echom "关闭quickfix窗口           nmap <C-@><C-Q>c     :cclose <CR>"
    echom "查看最近10条查询条件       nmap <C-@><C-Q>l     :chi <CR>"
    echom "查看上一条查询条件的结果   nmap <C-@><C-Q>n     :cnewer <CR>"
    echom "查看下一个查询条件的结果   nmap <C-@><C-Q>p     :colder <CR>"
    echom "跳到最近一条查询条件的结果 nmap <C-@><C-Q>g     :cnewer 99<CR>"
    echom "跳到最后一条查询条件的结果 nmap <C-@><C-Q>gg    :colder 99<CR>"
    echom "查看帮助:                  nmap <C-@><C-Q>h     :call tinytoolchiyl#base#mygrep#help()<CR>"
    echom "查看帮助:                  nmap <C-@><C-H>      :call tinytoolchiyl#base#mygrep#help()<CR>"
    echom " " 
    echom "================================================================================"
    echom ":Mygrep xxx"
    echom "       在conEmu终端中进行grep xxx， 这个grep就不会因为utf8编码问题导致输出中断，会搜出所有的项目中含 xxx 字符串的内容" 
    echom " " 
    echom "================================================================================"
    echom "tinytool->search_select_text->mygrep"
    echom "       在conEmu终端中进行grep 选中的text， 这个grep就不会因为utf8编码问题导致输出中断，会搜出所有的项目中含选中字符的内容" 
    echom " " 
    echom " " 
    echom " " 
    echom "================================================================================"
    echom "tinytool->search_select_text->grep"
    echom "       相当于执行:grep select_text,结果可以在Quickfix列表中显示出来" 
    echom "       默认是显示在右下角窗口，可以使用 CTRL+W+J 将Quickfix窗口置于最下方" 
    echom "       默认是显示在右下角窗口，可以使用 CTRL+W+Q 退出Quickfix窗口" 
    echom "       CTRL+@+n 相当于执行:cn， 跳转到下一个 Quickfix条目" 
    echom "       CTRL+@+p 相当于执行:cp， 跳转到上一个 Quickfix条目" 
    echom " " 
    echom " " 
    echom "================================================================================"
    echom "tinytool->search_select_text->grep_add"
    echom "       相当于执行:grepadd select_text,结果可以在Quickfix列表中显示出来" 
    echom "       默认是显示在右下角窗口，可以使用 CTRL+W+J 将Quickfix窗口置于最下方" 
    echom "       默认是显示在右下角窗口，可以使用 CTRL+W+Q 退出Quickfix窗口" 
    echom "       CTRL+@+n 相当于执行:cn， 跳转到下一个 Quickfix条目" 
    echom "       CTRL+@+p 相当于执行:cp， 跳转到上一个 Quickfix条目" 
    echom " " 
    echom " " 
    echom "================================================================================"
    echom "tinytool->search_select_text->history_search_result"
    echom "       相当于执行:chi 将最近的10条grep结果列出来" 
    echom " " 
    echom "================================================================================"
    echom "tinytool->search_select_text->last_search_result"
    echom "       相当于执行:colder 上一条grep的结果列表" 
    echom " " 
    echom "================================================================================"
    echom "tinytool->search_select_text->next_search_result"
    echom "       相当于执行:cnewer 下一条grep的结果列表" 
    echom " " 
    echom "================================================================================"
    echom "tinytool->search_select_text->newest_search_result"
    echom "       相当于执行:cnewer 99 最新一条grep的结果列表" 
    echom " " 
endfunction

