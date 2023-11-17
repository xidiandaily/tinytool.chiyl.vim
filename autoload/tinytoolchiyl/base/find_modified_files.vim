"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.11.17
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

function! tinytoolchiyl#base#find_modified_files#tarfiles(root,choice)
    execute 'python' . (has('python3') ? '3' : '') . ' find_modified_files("'.a:root.'","'.a:choice.'")'
endfunction

function! tinytoolchiyl#base#find_modified_files#tar_p4_opened_files()
    execute 'python' . (has('python3') ? '3' : '') . ' tar_p4_opened_files()'
endfunction


function! tinytoolchiyl#base#find_modified_files#doit()
    let choice=confirm("Upload file?", "&modefy\n&All\n&SetTstamp\n&Clean\n&P4Opended\n&Cancel",1)
    if choice == 6
        return
    elseif choice == 5
        call tinytoolchiyl#base#find_modified_files#tar_p4_opened_files()
    else
        call tinytoolchiyl#base#find_modified_files#tarfiles(substitute(getcwd(),'\\','\\\\','g'),choice)
    endif
endfunction

