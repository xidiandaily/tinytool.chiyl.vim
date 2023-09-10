"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.09.07
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

function! tinytoolchiyl#base#touch_files_in_clipboard#doit()
    let clipboard = getreg('*')

    " 使用空格、换行符、逗号和#号分割剪切板内容为文件列表
    let files = split(clipboard, '[ ,#\n]')

    " 初始化文件列表
    let updated_files = []

    " 遍历文件列表
    for file in files
        " 检查文件是否存在
        if filereadable(file)
            " 读取文件内容
            let content = readfile(file)

            " 写入文件以更新最近修改时间
            call writefile(content, file)
            call add(updated_files,file)
        endif
    endfor
    if len(updated_files) == 0
        call add(updated_files,"剪切板中找不到需要更新最近修改时间的文件")
    endif

    let outfile = ".vimtmp.out.touch_files_in_clipboard"
    call writefile(updated_files,outfile)
    call ctrlp#mybase#ctrlp_open_new_win(outfile,1)
endfunction

