"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.10.24
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

"在分割窗口跳转的时候，有时候需要调转N个窗口找到信息并拷贝,这个时候需要跳回原来的
"编辑窗口，需要多次跳转回来，比较麻烦，这个函数采用了一个解决方案：
"1，跳转前，将当前的编辑窗口设置为标记 A(按键:m+A)
"2，跳转多个窗口，到另一个目标窗口拷贝到想要的内容，或者查看到具体内容，此时使用快捷键
"   \W+A 就能跳转回标记为A的位置，非常方便
function! tinytoolchiyl#base#goto_marks_switch_win#doit(mark)
    let l:current_winnr = winnr()
    let l:current_bufnr = bufnr('%')
    let l:found = 0

    for winnr in range(1, winnr('$'))
        let bufnr = winbufnr(winnr)
        let mark_position = getpos("'" . a:mark)
        if mark_position[0] == bufnr && winnr != l:current_winnr
            let l:topline = getwininfo(win_getid(winnr))[0]['topline']
            let l:botline = getwininfo(win_getid(winnr))[0]['botline']
            if mark_position[1] >= l:topline && mark_position[1] <= l:botline
                execute winnr . "wincmd w"
                execute "normal! `" . a:mark
                let l:found = 1
                break
            endif
        endif
    endfor

    if l:found == 0
        echo "HEI Mark not found in any other visible window"
    endif
endfunction

function! tinytoolchiyl#base#goto_marks_switch_win#last_edit_pos()
    let l:current_winnr = winnr()
    let l:current_bufnr = bufnr('%')
    let l:found = 0

    for winnr in range(1, winnr('$'))
        let bufnr = winbufnr(winnr)
        let mark_position = g:tinytool_chiyl_last_postion
        if mark_position[0] == bufnr && winnr != l:current_winnr
            let l:topline = getwininfo(win_getid(winnr))[0]['topline']
            let l:botline = getwininfo(win_getid(winnr))[0]['botline']
            if mark_position[1] >= l:topline && mark_position[1] <= l:botline
                execute winnr . "wincmd w"
                call setpos('.',[0]+mark_position[1:])
                let l:found = 1
                break
            endif
        endif
    endfor

    if l:found == 0
        echo "not found any pos information"
    endif
endfunction


