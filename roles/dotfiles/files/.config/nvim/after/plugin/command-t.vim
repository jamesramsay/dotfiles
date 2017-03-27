" Settings

let g:CommandTEncoding='UTF-8'
let g:CommandTFileScanner='watchman'
let g:CommandTMaxCachedDirectories=10
let g:CommandTMaxFiles=100000
let g:CommandTScanDotDirectories=1
let g:CommandTTraverseSCM='pwd'
let g:CommandTWildIgnore=&wildignore
let g:CommandTWildIgnore.=',*/.git,*/node_modules/*'

" Mappings

nmap <unique> <Leader>c <Plug>(CommandTCommand)
nmap <unique> <Leader>h <Plug>(CommandTHelp)
