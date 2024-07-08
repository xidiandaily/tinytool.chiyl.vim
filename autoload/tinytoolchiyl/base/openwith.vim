"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.11.17
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

function! tinytoolchiyl#base#openwith#Cygwin()
    :let cygwin_path = substitute(substitute(expand('%:p:h'), '\([A-Za-z]\):\\', '/cygdrive/\L\1/', ''),'\\','/','g')
    ":silent !cmd.exe /c start mintty.exe /bin/env CHERE_INVOKING=1 /bin/bash --login -c "exec /bin/bash"
    :let cygwin_path = substitute(expand('%:p:h'), '\([A-Za-z]\):\\', '/cygdrive/\L\1/', '') | execute '!start mintty.exe /bin/env CHERE_INVOKING=1 /bin/bash --login -c "cd ''' . cygwin_path . '''; exec /bin/bash"'
endfunction

