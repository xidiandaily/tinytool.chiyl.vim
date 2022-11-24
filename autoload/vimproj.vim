"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2022.10.29
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

fu! vimproj#init()
    let s:map_F12=maparg('<F12>')
    if exists('g:proj_type') && g:proj_type=='vim'
        "echohl WarningMsg | echom "has already define vimproj"| echohl None
        "do nothing
    else
        :map <buffer> <F12> :silent execute '!ctags -f vim.tags -R --languages=Vim --c++-kinds=+p --fields=+iaS  .'<CR><CR>
    endif
    return 1
endfu

fu! vimproj#jump_to_cmd()
    let s:word=expand("<cword>")
    let s:target=':'.s:word
    echo s:target
    exe 'tag '.s:target
endfu

fu! vimproj#jump_to_function()
    let s:word=expand("<cword>")
    let s:target=s:word.'()'
    echo s:target
    exe 'tag '.s:target
endfu

fu! vimproj#get_tags_cn_path()
    let ret=''
    for dir in pathogen#split(&rtp)
        "优先判断中文文档
        let filename=dir.pathogen#slash().'doc'.pathogen#slash().'tags-cn'
        if filereadable(filename)
            let ret=ret.','.filename
        else
            "判断英文文档
            let filename=dir.pathogen#slash().'doc'.pathogen#slash().'tags'
            if filereadable(filename)
                let ret=ret.','.filename
            endif
        endif
    endfor
    return ret
endfu
