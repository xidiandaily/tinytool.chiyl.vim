"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.07.13
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

if has('gui_running')
  if &mousemodel =~? 'popup'
    anoremenu <silent> PopUp.T&inytool.sort_uniq
	  \ :'<,'>sort u<CR> :echom "sort u" <CR>
  endif
endif

