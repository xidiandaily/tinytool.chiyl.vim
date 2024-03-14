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
  let l:cmd="ag --nogroup --nocolor ".a:pattern
  "echom l:temp_config
  "echom l:config
  "echom l:cmd
  "echom 'python' . (has('python3') ? '3' : '') . ' tinytool_update_conemu_config("'.l:temp_config.'","'.l:config.'","'.l:cmd.'")'
  silent! execute 'python' . (has('python3') ? '3' : '') . ' tinytool_update_conemu_config("'.l:temp_config.'","'.l:config.'","'.l:cmd.'")'
  execute "silent !cmd.exe /c start  ConEmu64 -Title \"".l:cmd."\" -LoadCfgFile " ..l:config
endfunction

