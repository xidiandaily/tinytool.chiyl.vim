"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2025.01.05
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

" 修改配置文件中的URL和标签
function! tinytoolchiyl#base#flomo#edit_config()
    let l:conf_file = findfile('flomo_url_conf.vim', &rtp)
    if empty(l:conf_file)
        "如果找不到，就会在包含 ftpplugin/flomo.vim文件的 runtim
        "path下创建一个配置文件
        let l:rtp=split(&rtp,',')
        let l:conf_path=''
        for path in l:rtp
            if filereadable(path . '/ftplugin/flomo.vim')
                let l:conf_path=path . '/flomo_url_conf.vim'
                break
            endif
        endfor

        if empty(l:conf_path)
            let l:conf_path=l:rtp[0] . '/flomo_url_conf.vim'
        endif
        call writefile([
                    \ "\" Flomo API URL",
                    \ "let g:flomo_url = ''",
                    \ "",
                    \ "\" Flomo 标签列表",
                    \ "let g:flomo_tags = []",
                    \ "",
                    \ "\" 启用日志",
                    \ "let g:flomo_log_enabled = 0",
                    \ ],l:conf_path)

        let l:conf_file = l:conf_path
    endif
    execute ':split | edit ' . l:conf_file
endfunction

" 读取配置文件中的URL和标签
function! tinytoolchiyl#base#flomo#flomo_read_config()
    let l:conf_file = findfile('flomo_url_conf.vim', &rtp)
    if !empty(l:conf_file)
        execute 'source ' . l:conf_file
    endif
endfunction

" 标签补全函数
function! tinytoolchiyl#base#flomo#flomo_tag_complete(findstart, base)
    if empty(g:flomo_tags)
        call tinytoolchiyl#base#flomo#flomo_read_config()
        if empty(g:flomo_tags)
            echohl ErrorMsg | echo "未找到有效的Flomo tags配置" | echohl None
            return []
        endif
    endif
    if a:findstart
        " 定位补全开始位置
        let line = getline('.')
        let start = col('.') - 1
        while start > 0 && line[start - 1] != '#'
            let start -= 1
        endwhile
        return start
    else
        " 查找匹配的标签
        let res = []
        for tag in g:flomo_tags
            if tag =~ '^' . a:base
                call add(res, tag)
            endif
        endfor
        return res
    endif
endfunction

" 上传内容到Flomo
function! tinytoolchiyl#base#flomo#flomo_upload()
    if empty(g:flomo_url)
        call tinytoolchiyl#base#flomo#flomo_read_config()
        if empty(g:flomo_url)
            echohl ErrorMsg | echo "未找到有效的Flomo URL配置" | echohl None
            return
        endif
    endif

    let l:content = join(getline(1, '$'), "\n")
    
    " 使用Python发送HTTP请求
    python3 << EOF
import vim
import json
import urllib.request
import urllib.error

try:
    url = vim.eval('g:flomo_url')
    content = vim.eval('l:content')
    
    data = json.dumps({'content': content}).encode('utf-8')
    headers = {'Content-Type': 'application/json'}
    
    req = urllib.request.Request(url, data=data, headers=headers, method='POST')
    with urllib.request.urlopen(req) as response:
        result = response.read().decode('utf-8')
        vim.command('let l:result = "' + result.replace('"', '\\"') + '"')
        vim.command('let l:success = 1')
except Exception as e:
    error_msg = str(e).replace('"', '\\"')
    vim.command('let l:result = "' + error_msg + '"')
    vim.command('let l:success = 0')
EOF

    if g:flomo_log_enabled
        echom "调用结果: " . l:result
    endif

    if l:success
        call confirm("内容已成功上传到Flomo!", "&确定", 1)
    else
        call confirm("上传失败: " . l:result, "&确定", 1)
    endif
endfunction

" 确认对话框函数
function! tinytoolchiyl#base#flomo#flomo_confirm_upload()
    if has('gui_running')
        let l:choice = confirm("是否上传当前内容到Flomo?", "&是\n&否", 1)
        if l:choice == 1
            call tinytoolchiyl#base#flomo#flomo_upload()
        endif
    else
        echo "是否上传当前内容到Flomo? (y/n): "
        let l:choice = nr2char(getchar())
        if l:choice ==? 'y'
            call tinytoolchiyl#base#flomo#flomo_upload()
        endif
    endif
endfunction 

"输出说明

function! tinytoolchiyl#base#flomo#help()
    echo "*flomo.txt*  Flomo上传插件"
    echo ""
    echo "=============================================================================="
    echo "简介                                                    *flomo-introduction*"
    echo ""
    echo "这是一个用于将文本内容上传到Flomo的Vim插件。支持标签自动补全功能，并提供专门"
    echo "的写作环境设置。"
    echo ""
    echo "=============================================================================="
    echo "配置                                                    *flomo-configuration*"
    echo ""
    echo "在使用此插件之前，你需要设置以下全局变量："
    echo ""
    echo "g:flomo_url         Flomo API的URL"
    echo "g:flomo_tags        Flomo标签列表"
    echo "g:flomo_log_enabled 是否启用日志输出 (0: 禁用, 1: 启用)"
    echo ""
    echo "你可以在vimrc中直接设置这些变量，或者在runtime path中创建"
    echo "'flomo_url_conf.vim'文件进行配置。如果没有找到配置文件，插件会自动在"
    echo "runtime path中创建一个默认配置文件。"
    echo ""
    echo "示例配置："
    echo "    let g:flomo_url = 'https://flomoapp.com/api/v1/memo'"
    echo "    let g:flomo_tags = ['工作', '生活', '学习']"
    echo "    let g:flomo_log_enabled = 0"
    echo ""
    echo "=============================================================================="
    echo "使用方法                                                *flomo-usage*"
    echo ""
    echo "1. 确保文件类型设置为'flomo' (:set ft=flomo)"
    echo "2. 输入#号时会自动触发标签补全"
    echo "3. 按<F7>键会弹出确认对话框"
    echo "4. 选择\"是\"将上传当前buffer中的所有内容"
    echo "5. 选择\"否\"则取消上传"
    echo ""
    echo "标签补全：                                              *flomo-completion*"
    echo "    在输入模式下输入#会自动触发标签补全"
    echo "    可以继续输入字符进行过滤"
    echo "    使用<C-n>和<C-p>在补全列表中选择"
    echo ""
    echo "写作环境：                                              *flomo-environment*"
    echo "当设置文件类型为flomo时，会自动应用以下设置："
    echo "    - 使用pencil配色方案"
    echo "    - 设置等宽字体"
    echo "    - 关闭行号显示"
    echo "    - 关闭颜色列"
    echo "    - 启用自动换行"
    echo "    - 使用浅色背景"
    echo "    - 关闭代码折叠"
    echo "    - 启用SoftPencil模式"
    echo ""
    echo "这些设置会在切换到其他文件类型时自动恢复为原始值。"
    echo ""
    echo "命令：                                                  *flomo-commands*"
    echo "    无特殊命令，支持<F7>快捷键和#标签补全"
    echo ""
    echo "依赖：                                                  *flomo-dependencies*"
    echo "    - vim-pencil 插件"
    echo "    - pencil 配色方案"
    echo "    - Python3 支持 (:echo has('python3'))"
    echo ""
    echo "=============================================================================="
    echo "故障排除                                                *flomo-troubleshooting*"
    echo ""
    echo "如果需要查看上传结果的详细信息，可以："
    echo "1. 在配置文件中设置 let g:flomo_log_enabled = 1"
    echo "2. 使用 :messages 命令查看详细日志"
    echo ""
    echo "=============================================================================="
    echo " vim:tw=78:ts=8:ft=help:norl: "
endfunction

