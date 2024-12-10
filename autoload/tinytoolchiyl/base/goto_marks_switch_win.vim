"==============================================================================
" Description: 在任意模式下跳转到上一个/下一个编辑位置
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.10.24
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================
" 功能说明:
" 这是一个用于在vim中跟踪和导航编辑位置的插件。主要功能包括：
" 1. 自动记录用户在不同文件中的编辑位置
" 2. 支持在多窗口环境下跳转到上一个/下一个编辑位置
" 3. 智能处理文件内容变化，自动更新编辑位置
" 4. 提供简单的快捷键操作方式
"
" 设计方案:
" 1. 数据结构：
"    - 使用列表存储编辑位置信息(s:edit_positions)
"    - 每个位置记录包含：光标位置、buffer编号、行内容、行号
"
" 2. 核心功能：
"    - SaveEditPosition(): 保存当前编辑位置
"    - UpdateEditPositions(): 更新位置信息以适应文件变化
"    - GotoPrevEdit()/GotoNextEdit(): 在编辑位置间导航
"
" 3. 自动触发：
"    - 在文本改变时自动更新编辑位置
"==============================================================================

" 保存跳转位置的列表
let s:edit_positions = []
" 当前位置索引
let s:current_position_index = -1

" 保存编辑位置
function! tinytoolchiyl#base#goto_marks_switch_win#SaveEditPosition()
    let pos = getpos('.')
    let bufnr = bufnr('%')
    " 检查文件是否真实存在
    if !filereadable(bufname(bufnr))
        return
    endif
    let line_content = getline(pos[1])
    let new_entry = {'pos': pos, 'bufnr': bufnr, 'line': line_content, 'line_number': pos[1]}
    
    " 检查是否已经存在相同位置的记录
    for i in range(len(s:edit_positions))
        if s:edit_positions[i].line_number == pos[1] && s:edit_positions[i].bufnr == bufnr
            " 如果存在，删除旧记录
            call remove(s:edit_positions, i)
            break
        endif
    endfor
    
    " 添加新记录
    call add(s:edit_positions, new_entry)

    " 更新编辑位置以适应文件的变化
    call tinytoolchiyl#base#goto_marks_switch_win#UpdateEditPositions()

    let s:current_position_index = len(s:edit_positions) - 1

    " 打印 edit_positions 里面的信息，按照顺序输出
    "echom "编辑位置列表:"
    "for pos_info in s:edit_positions
    "    echom "buffer号: " . pos_info.bufnr . ", 行号: " . pos_info.line_number . ", 行内容: " . pos_info.line
    "endfor
endfunction

" 更新编辑位置以适应文件的变化
function! tinytoolchiyl#base#goto_marks_switch_win#UpdateEditPositions()
    let wininfo = getwininfo(win_getid(winnr()))
    let i = 0
    while i < len(s:edit_positions)
        let pos_info = s:edit_positions[i]
        if pos_info.bufnr == wininfo[0].bufnr
            let current_line = getline(pos_info.line_number)
            " 如果行内容不匹配，尝试在附近查找匹配的行
            if current_line !=# pos_info.line
                let found = 0
                for offset in range(-5, 5)
                    if pos_info.line_number + offset > 0 && getline(pos_info.line_number + offset) ==# pos_info.line
                        let pos_info.line_number += offset
                        let found = 1
                        break
                    endif
                endfor
                " 如果没有找到匹配的行，从历史记录中删除
                if !found
                    call remove(s:edit_positions, i)
                    continue
                endif
            endif
        endif
        let i += 1
    endwhile
endfunction

" 跳转到上一个编辑位置
function! tinytoolchiyl#base#goto_marks_switch_win#GotoPrevEdit()
    if empty(s:edit_positions)
        echom "没有找到上一个编辑位置"
        return
    endif
    
    if getpos('.')[1] != s:edit_positions[s:current_position_index].pos[1] || getpos('.')[2] != s:edit_positions[s:current_position_index].pos[2]
        let s:current_position_index -= 1
        let pos_info = s:edit_positions[s:current_position_index]
        let current_win = winnr()
        let found_win = 0
        
        " 遍历所有窗口，查找显示目标位置的窗口
        for win in range(1, winnr('$'))
            let wininfo = getwininfo(win_getid(win))
            "echom "win: " . win . " bufnr: " . wininfo[0].bufnr . " pos_info.bufnr: " . pos_info.bufnr
            if wininfo[0].bufnr == pos_info.bufnr
                " 如果找到窗口，切换到该窗口
                execute win . 'wincmd w'
                call setpos('.', pos_info.pos)
                let found_win = 1
                break
            endif
        endfor
        
        " 如果没有找到合适的窗口，在当前窗口打开buffer
        if !found_win
            " 回到原始窗口
            execute current_win . 'wincmd w'
            " 在当前窗口切换buffer
            execute 'buffer ' . pos_info.bufnr
            call setpos('.', pos_info.pos)
        endif
    else
        echom "已经是最早的编辑位置"
    endif
endfunction

" 跳转到下一个编辑位置
function! tinytoolchiyl#base#goto_marks_switch_win#GotoNextEdit()
    if empty(s:edit_positions)
        echom "没有找到下一个编辑位置"
        return
    endif
    
    if s:current_position_index < len(s:edit_positions) - 1
        let s:current_position_index += 1
        let pos_info = s:edit_positions[s:current_position_index]
        let current_win = winnr()
        let found_win = 0
        
        " 遍历所有窗口，查找显示目标位置的窗口
        for win in range(1, winnr('$'))
            let wininfo = getwininfo(win_getid(win))
            "echom "win: " . win . " bufnr: " . wininfo[0].bufnr . " pos_info.bufnr: " . pos_info.bufnr
            if wininfo[0].bufnr == pos_info.bufnr
                " 如果找到窗口，切换到该窗口
                execute win . 'wincmd w'
                call setpos('.', pos_info.pos)
                let found_win = 1
                break
            endif
        endfor
        
        " 如果没有找到合适的窗口，在当前窗口打开buffer
        if !found_win
            " 回到原始窗口
            execute current_win . 'wincmd w'
            " 在当前窗口切换buffer
            execute 'buffer ' . pos_info.bufnr
            call setpos('.', pos_info.pos)
        endif
    else
        echom "已经是最新的编辑位置"
    endif
endfunction

" 显示帮助信息
function! tinytoolchiyl#base#goto_marks_switch_win#ShowHelp()
    echo "编辑位置跳转插件使用说明:\n"
    echo "功能："
    echo "- 自动记录用户在不同文件中的编辑位置"
    echo "- 支持在多窗口环境下跳转到上一个/下一个编辑位置"
    echo "- 智能处理文件内容变化，自动更新编辑位置\n"
    echo "命令："
    echo "- tinytool->jump_edit->prev[捷键]\\ep : 跳转到上一个编辑位置"
    echo "- tinytool->jump_edit->next[捷键]\\ep : 跳转到下一个编辑位置"
    echo "- tinytool->jump_edit->show[捷键]\\es : 显示当前编辑位置列表"
    echo "- tinytool->jump_edit->help[捷键]\\eh : 显示本帮助信息"
endfunction

" 显示当前跳转列表
function! tinytoolchiyl#base#goto_marks_switch_win#ShowEditPositions()
    if empty(s:edit_positions)
        echo "当前没有保存的编辑位置"
        return
    endif
    
    echo "编辑位置列表 (总计: " . len(s:edit_positions) . " 条记录):"
    echo "当前位置索引: " . s:current_position_index . "\n"
    
    let index = 0
    for pos_info in s:edit_positions
        let marker = (index == s:current_position_index) ? '>' : ' '
        let filename = bufname(pos_info.bufnr)
        echo printf("%s %2d: [Buffer %3d] 文件: %s 行号: %3d | %s",
            \ marker,
            \ index + 1,
            \ pos_info.bufnr,
            \ filename,
            \ pos_info.line_number,
            \ pos_info.line[:50] . (len(pos_info.line) > 50 ? '...' : '')
            \)
        let index += 1
    endfor
endfunction

