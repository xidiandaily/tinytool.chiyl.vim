"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2023.09.25
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

"let s:data_path=escape(expand('<sfile>:p:h'),'\').'/../../../data'
"let s:incr_filename=escape(expand('<sfile>:p:h'),'\').'/../../../data/incr'
let s:incr_filename='.vimtmp.incr'

function! tinytoolchiyl#base#gettmploopfilename#getname()
    "if !isdirectory(s:data_path)
    "    call mkdir(s:data_path)
    "endif

    if !filereadable(s:incr_filename)
        let num=0
        call writefile([0],s:incr_filename)
    else
        let lines = readfile(s:incr_filename)
        let num=str2nr(lines[0])
        let newnum=num+1
        if newnum > 50
            let newnum = 0
        endif
        call writefile([newnum],s:incr_filename)
    endif

    let outfile='.vimtmp.filename.'.num.'.txt'
    "let outfile=s:data_path.'/vimtmpfilename.'.num.'.txt'
    "echom outfile
    "echom s:incr_filename
    "echom outfile
    return outfile
endfunction

"function! tinytoolchiyl#base#gettmploopfilename#writefiletype(filename,filetype)
"    let sout='" vim:'
"    if a:filetype == 'json'
"        let sout=sout."ft=json"
"    else
"        return
"    endif
"    if filereadable(s:incr_filename)
"        let oft=&fileformat
"        set fileformat=unix
"        call writefile(["","",sout,""],a:filename,'a')
"        let &fileformat=oft
"    endif
"endfunction

function! tinytoolchiyl#base#gettmploopfilename#clean_all_vimtmpfile()
  let files = split(glob('.vimtmp.filename*'), "\n")
  for file in files
    echom 'del '.file
    call delete(file)
  endfor
  echom len(files) . ' files deleted.'
endfunction
