"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2024.10.10
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

function! tinytoolchiyl#base#my_marks#get_marks_line_content(mark)
    let lnum = a:mark['pos'][1]
    let file = a:mark['file']
    if a:mark['mark'] =~ '^''[^A-Z]'
        return ''
    endif

    " 读取文件中的行内容
    try
        exe 'edit' file
        let content = getline(lnum)
        let content = content[0:200]
    catch
        " 如果文件读取失败，跳过
        let content = 'read failed pos:'.string(a:mark['pos'])
    endtry
    return content
endfunction

function! tinytoolchiyl#base#my_marks#get_all_global_marks()

    " 获取所有全局标记
    let marklist = getmarklist()
    let az_result = []
    let other_result = []
    let step = 1
    let max_filename_size=0

    " 遍历标记列表，获取每个标记对应的行文本
    for mark in marklist
        if has_key(mark, 'pos') && has_key(mark, 'file')
            let lnum = mark['pos'][1]
            let file = mark['file']
            if strlen(file) > max_filename_size
                let max_filename_size = strlen(file)
            endif

            " 读取文件中的行内容
            " 补充 Dict 中的内容
            let mark['content'] = tinytoolchiyl#base#my_marks#get_marks_line_content(mark)

            " 根据标记名是否在A-Z范围进行分类
            if mark['mark'] =~ '^''[A-Z]$'
                call add(az_result, mark)
            else
                call add(other_result, mark)
            endif
        endif
    endfor

    " 按照标记名排序
    call sort(az_result, {a, b -> a['mark'] < b['mark'] ? -1 : (a['mark'] > b['mark'] ? 1 : 0)})
    call sort(other_result, {a, b -> a['mark'] < b['mark'] ? -1 : (a['mark'] > b['mark'] ? 1 : 0)})

    return [az_result,other_result,max_filename_size]
endfunction

function! tinytoolchiyl#base#my_marks#list_all_global_marks()
    let [l:az_result,l:other_result,l:max_filename_size] = tinytoolchiyl#base#my_marks#get_all_global_marks()
    let l:all_row = [] 

    for item in l:az_result
        call add(l:all_row,[item['mark'],item["pos"][1],item["pos"][2],item['file'],item['content']])
    endfor
    for item in l:other_result
        call add(l:all_row,[item['mark'],item["pos"][1],item["pos"][2],item['file'],item['content']])
    endfor

    "格式化输出
    let str_fmt="%-2s %5s %5s %-" .l:max_filename_size. "s %-10s"
    echo printf(str_fmt,"标记", "行", "列",  "文件",  "文本")
    for row in l:all_row
        echo printf(str_fmt,row[0],row[1],row[2],row[3],row[4])
    endfor
endfunction


"1，调用函数 getmarklist(),获取到所有全局位置标记，此时获取到的标记返回应该是一个List，里面每一个项目都是一个 Dict, 其中Dict的定义是: mark:标记名， pos:标记所在的位置信息，file文件名
"2，遍历这个结果List，根据pos获取到这一行的文本内容，定义为 content，补充到Dict中
"3，对List按照mark按照字符顺序进行排序，并且将结果输出到一个名字为 a.txt 的文本中
function! tinytoolchiyl#base#my_marks#do_output_all_global_marks_to_file(filename)
    " 获取所有全局标记
    let [l:az_result,l:other_result,l:max_filename_size] = tinytoolchiyl#base#my_marks#get_all_global_marks()

    let step = 1

    " 生成输出内容 A-Z
    let output = []

    let str_fmt="第%-2s步 %5s %-" .l:max_filename_size. "s %-10s"
    call add(output,printf(str_fmt,"步骤","标记", "文件",  "文本"))

    for item in l:az_result
        call add(output,printf(str_fmt,step,item['mark'],item['file'],item['content']))
        let step += 1
    endfor

    call add(output, " ")
    call add(output, "================================================================================")
    call add(output, "其他标记: ")
    call add(output, " ")

    " 生成其他输出内容
    let str_fmt="%-5s %-" .l:max_filename_size. "s %-10s"
    for item in other_result
        call add(output,printf(str_fmt,item['mark'],item['file'],item['content']))
    endfor

    " 将结果写入文件
    let filename = a:filename
    call writefile(output, filename)

    echom "Results written to" filename
endfunction

function! tinytoolchiyl#base#my_marks#output_all_global_marks_to_file()
    let s:prev_win=win_getid()
    let s:out=tinytoolchiyl#base#gettmploopfilename#getname()
    call tinytoolchiyl#base#my_marks#do_output_all_global_marks_to_file(s:out)
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
    call win_gotoid(s:prev_win)
endfunction


"以vimscript写如下逻辑：
"1，实现两个函数，一个是 AZMarksSave， 保存A-Z全局标记到文件。 一个是 AZMarksLoad ，将保存到文件中的A-Z标记加载回来并且重新设置到编辑器中；
"2，增加历史记录的功能，ShowHistory，每次点击ShowHistory，会判断这个文件在不在，如果在，才会显示这个AZMarks文件，如果这个文件被删除，则不再显示
"
"AZMarksSave的逻辑:
"1，调用函数 getmarklist(),获取到所有全局位置标记，此时获取到的标记返回应该是一个List，里面每一个项目都是一个 Dict, 其中Dict的定义是: mark:标记名， pos:标记所在的位置信息，file文件名
"2，将这些A-Z的标记保存起来，另存为到一个文件中，文件支持选取保存位置和输入文件名；
"3，选择另存为的api不要用input,该是改成gvim中支持的另存为的弹窗形式的实现： browse confirm saveas
"
"AZMarksLoad的逻辑：
"1，调用函数AZMarksLoad，弹窗选择保存的文件；
"2，校验所选的文件是否为AZMarksSave保存的，符合语法；
"3，加载文件，重新设置A-Z的全局标记
"4，load文件的时候，也是一样，采用弹窗选择文件的方式: browse confirm e
"
"ShowHistory的逻辑：
"1，每次另存为这个AZMarks的文件，都会记录下来
"2，每次点击ShowHistory，会判断这个文件在不在，如果在，才会显示这个AZMarks文件，如果这个文件被删除，则不再显示
"3，ShowHistory作为一个函数，不要直接显示出这些文件，而是将这些有效的AZMarks文件以List的方式返回给调用方，调用方可以拿来刷新菜单，也可以直接输出


" 定义历史文件的路径
let g:history_file = expand('~/.vim_marks_history.txt')
let g:marks_history = []

" 在 Gvim 启动时加载历史记录
function! tinytoolchiyl#base#my_marks#load_history()
    if filereadable(g:history_file)
        try
            let g:marks_history = readfile(g:history_file)
        catch
            echoerr "Error loading marks history."
        endtry
    endif
endfunction

" 保存历史记录到文件
function! tinytoolchiyl#base#my_marks#save_history()
    try
        call writefile(g:marks_history, g:history_file)
    catch
        echoerr "Error saving marks history."
    endtry
endfunction

" 保存 A-Z 全局标记到文件，使用 gvim 弹窗选择保存路径
function! tinytoolchiyl#base#my_marks#azmarks_save()

    " 获取当前项目的根目录、当前时间和主机名
    let l:cwd = getcwd()
    let l:time = strftime("%Y-%m-%d %X")
    let l:hostname = hostname()

    " 获取所有的全局标记
    let l:marks = getmarklist()
    " 过滤出 A-Z 的标记，注意标记前缀问题
    let l:az_marks = filter(l:marks, {_, v -> v.mark =~ '^''[A-Z]'})

    " 使用 gvim 的 browse confirm 弹窗选择另存为的文件路径
    let l:savefile = browse('confirm saveas', 'Select file to save marks', '','')

    if len(l:savefile) == 0
        echom "取消保存"
        return
    endif

    " 如果选择了文件路径
    if !empty(l:savefile)
        try
            " 缓存所有的标记数据到一个列表中
            let l:output = [
                        \ "###### ================================================================================",
                        \ "###### 这个是长期保存gvim中全局寄存器A-Z的内容",
                        \ "###### 插件位置: tinytool.chiyl.vim\\autoload\\tinytoolchiyl\\base\\my_marks.vim",
                        \ "###### 当前项目的根目录    : " . l:cwd,
                        \ "###### 保存这个文件的时间  : " . l:time,
                        \ "###### 保存这个文件的作者  : " . l:hostname,
                        \ "###### ================================================================================"
                        \ ]

            for l:mark in l:az_marks
                " 将标记信息加入到缓存中，格式：mark pos file
                call add(l:output, string(l:mark.mark) . ' ' . l:mark.pos[1] . ' ' .l:mark.pos[2] . ' ' .l:mark.pos[3] . ' ' . l:mark.file. ' ' . tinytoolchiyl#base#my_marks#get_marks_line_content(l:mark))
            endfor

            " 将缓存内容一次性写入文件
            call writefile(l:output, l:savefile)

            " 保存文件路径到历史记录（避免重复）
            if index(g:marks_history, l:savefile) == -1
                call add(g:marks_history, l:savefile)
                call tinytoolchiyl#base#my_marks#save_history()  " 更新历史记录文件
            endif

            echo "Marks saved successfully to " . l:savefile
        catch
            echoerr "An error occurred while saving marks."
        endtry
    else
        echo "Save operation canceled."
    endif
endfunction

" 从文件加载 A-Z 全局标记，使用 gvim 弹窗选择加载的文件
function! tinytoolchiyl#base#my_marks#azmarks_load()
    " 使用 gvim 的 browse confirm 弹窗选择要加载的文件
    let l:loadfile = browse('confirm e', 'Select file to load marks', '','')

    " 校验文件是否存在
    if filereadable(l:loadfile)
        try
            " 读取文件内容
            let l:lines = readfile(l:loadfile)

            " 逐行读取标记并校验格式
            " 区分注释和原始内容
            let l:comment = ''
            let l:mark_list = []
            for l:line in l:lines
                if l:line =~ '^######'
                    let l:comment = l:comment . l:line."\n"
                else
                    call add(l:mark_list,l:line)
                endif
            endfor

            let l:choice = confirm(l:comment."\n更新会清除当前A-Z寄存器位置信息并更新成文件中A-Z的寄存器内容\n请问更新吗?", "&Yes\n&No\n&Cancel",2,"Info")
            "let l:choice = input(l:comment."Yy/Nn[default N]:","N")
            if l:choice != 1
                echom "取消导入 " . l:loadfile
                return
            end

            " 清除现有的A-Z标记
            exec 'delmarks A-Z'

            " 更新标记
            for l:line in l:mark_list
                let l:parts = split(l:line, '\s\+')
                let l:mark  = split(l:parts[0],"'")[0]
                if len(l:parts) >= 5 && l:mark =~ '[A-Z]'
                    " 设置标记，格式为：mark pos file
                    " 打开对应的文件，获取 bufnum
                    exec 'edit ' . l:parts[4]
                    let l:bufnum = bufnr('%')
                    call setpos("'".l:mark, [l:bufnum, l:parts[1], l:parts[2], l:parts[3]])
                else
                    echoerr "Invalid mark format in file: " . l:line
                endif
            endfor

            echom "Marks loaded successfully from " . l:loadfile
            "打开标记内容
            call tinytoolchiyl#base#my_marks#list_all_global_marks()
        catch
            echoerr "An error occurred while loading marks."
        endtry
    else
        echoerr "The selected file does not exist."
    endif
endfunction

" 显示历史记录中有效的文件，返回文件列表
function! tinytoolchiyl#base#my_marks#show_history()
    let l:valid_files = []
    " 遍历历史记录中的文件路径，检查文件是否存在
    for l:file in g:marks_history
        if filereadable(l:file)
            call add(l:valid_files, l:file)
        endif
    endfor

    " 返回有效文件的列表
    return l:valid_files
endfunction

" 自动加载历史记录
autocmd VimEnter * call tinytoolchiyl#base#my_marks#load_history()
