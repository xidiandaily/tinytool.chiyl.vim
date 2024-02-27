"==============================================================================
" Description: global plugin for lawrencechi
" Author:      lawrencechi <codeforfuture <at> 126.com>
" Last Change: 2024.02.26
" License:     This file is placed in the public domain.
" Version:     1.0.0
"==============================================================================

function! tinytoolchiyl#base#lsp_setting#lgamesvr()
    let s:out='compile_commands.json'
    let s:in = substitute(getcwd(), '\\', '/', 'g')
    echom s:in
    silent! execute 'python' . (has('python3') ? '3' : '') . ' directory_to_compile_commands_file("'.s:in.'","'.s:out.'")'
    call ctrlp#mybase#ctrlp_open_new_win(s:out,1)
endfunction


"{
"    "sumneko-lua-language-server":{
"        "workspace_config":{
"            "Lua": {
"                "color": {
"                    "mode": "Semantic"
"                },
"                "completion": {
"                    "callSnippet": "Disable",
"                    "enable": true,
"                    "keywordSnippet": "Replace"
"                },
"                "develop": {
"                    "debuggerPort": 11412,
"                    "debuggerWait": false,
"                    "enable": false
"                },
"                "diagnostics": {
"                    "enable": true,
"                    "globals": "",
"                    "severity": {}
"                },
"                "hover": {
"                    "enable": true,
"                    "viewNumber": true,
"                    "viewString": true,
"                    "viewStringMax": 1000
"                },
"                "runtime": {
"                    "path": ["?.lua", "?/init.lua", "?/?.lua"],
"                    "version": "Lua 5.3"
"                },
"                "signatureHelp": {
"                    "enable": true
"                },
"                "workspace": {
"                    "ignoreDir": [],
"                    "maxPreload": 3000,
"                    "preloadFileSize": 100,
"                    "useGitIgnore": true,
"                    "checkThirdParty":false
"                }
"            }
"        }
"    }
"}
function! tinytoolchiyl#base#lsp_setting#pgamesvr()
    execute ':LspSettingsLocalEdit'
    echom '参考: G:/CodeBase.github/vim/vimfiles/bundle/vim-lsp-settings/settings/sumneko-lua-language-server.vim'
endfunction
