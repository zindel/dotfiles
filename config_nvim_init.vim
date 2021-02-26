" {{{ Plugins
" if has('vim_starting')
"    if &compatible
"      set nocompatible
"    endif

"    set runtimepath+=~/.vim/bundle/neobundle.vim/
" endif
" set rtp+=~/.vim/bundle/fzf/

" " Required:
" call neobundle#begin(expand('~/.vim/bundle/'))

" " Required:
" NeoBundleFetch 'Shougo/neobundle.vim'
set rtp+=/usr/local/opt/fzf

call plug#begin('~/.vim/plugged')

" My Bundles here:
Plug 'altercation/vim-colors-solarized'
Plug 'jlanzarotta/bufexplorer'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'editorconfig/editorconfig-vim'
Plug 'exu/pgsql.vim'
Plug 'dense-analysis/ale'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
Plug 'tpope/vim-commentary'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'rust-lang/rust.vim'
Plug 'andreypopp/vim-reason'
Plug 'chr4/nginx.vim'
Plug 'let-def/ocp-indent-vim'
Plug 'andreypopp/vim-colors-plain'
Plug 'andreypopp/fzf-merlin'

" Plug 'slashmili/alchemist.vim'
" Plug 'elixir-editors/vim-elixir'
" Plug 'Galooshi/vim-import-js'
" Plug 'leafgarland/typescript-vim'
" Plug 'reasonml-editor/vim-reason'
" Plug 'reasonml-editor/vim-reason-legacy'
" Plug 'flowtype/vim-flow', { 'for': 'javascript' }
" Plug 'andreypopp/ale'
" Plug 'ElmCast/elm-vim'
" Plug 'raichoo/purescript-vim'
" Plug 'gcmt/taboo.vim'
" Plug 'rakr/vim-one'
" Plug 'joshdick/onedark.vim'
" Plug 'junegunn/seoul256.vim'
" Plug 'jordwalke/vim-reasonml'
" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': './install.sh'
"     \ }
" Plug 'reasonml-editor/vim-reason-plus'
" Plug 'zindel/vim-colors-plain'


" call neobundle#end()
call plug#end()

filetype plugin indent on
" NeoBundleCheck

" }}}

" {{{ Basic Options / Mappings
set nocompatible
set backspace=indent,eol,start
syntax on
filetype plugin indent on
set history=300
set ruler		" show the cursor position all the time
set noshowcmd		" do not display incomplete commands
set incsearch		" do incremental searching
set hlsearch
set autoindent		" always set autoindenting on
set expandtab
set tabstop=4
set softtabstop=4
set sw=4
set novb
set noeb
language en_US

" brew install reattach-to-user-namespace --wrap-pbcopy-and-pbpaste

if !exists("g:gui_oni")
  set clipboard=unnamed
endif
let mapleader=","
nnoremap <Enter> :nohl<CR>
" }}}

" {{{ Wrap lines and make arrow keys support it
set wrap
" nnoremap j gj
" nnoremap k gk
" vnoremap j gj
" vnoremap k gk
" nnoremap <Down> gj
" nnoremap <Up> gk
" vnoremap <Down> gj
" vnoremap <Up> gk
" inoremap <Down> <C-o>gj
" inoremap <Up> <C-o>gk
" }}}

" {{{ Language specific options
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
let python_highlight_all = 1
let g:sql_type_default = 'pgsql'
" }}}

" {{{ Change directory to match the currently opened file
function! CHANGE_CURR_DIR()
    if bufname('%') !~ '^term://'
        exec "cd %:p:h"
    endif
endfunction
autocmd BufWinEnter * call CHANGE_CURR_DIR()
autocmd BufEnter * call CHANGE_CURR_DIR()
autocmd WinEnter * call CHANGE_CURR_DIR()
autocmd BufReadPost * call CHANGE_CURR_DIR()
" }}}

" {{{ Tab Autocompletion
function! TabForward()
 if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
   return "\<C-N>"
 else
   return "\<Tab>"
endfunction
inoremap <Tab> <C-R>=TabForward()<CR>

" set completeopt+=noselect
" set completeopt+=noinsert
set noshowmode shortmess+=c
set noinfercase
set wrapscan
" set complete-=t
" set complete-=u
" let g:mucomplete#chains = {'default' : ['omni', 'c-n', 'path'] }
" let g:mucomplete#enable_auto_at_startup = 1


" }}}

" {{{ Remember the cursor position and other details / viminfo
"
set viminfo='100,\"200,n~/.nviminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
" }}}

" {{{ Backup
set directory=~/.vimtmp/,.,/tmp
set nobackup
set backupdir=/tmp
set directory=/tmp
set shell=zsh
" }}}

" {{{ Theme / styling
set mouse=
set laststatus=2
set splitright
set fillchars+=vert:│
set cmdheight=1
set cursorline



set t_Co=256
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" " For Neovim 0.1.3 and 0.1.4
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1



syntax enable

" set list listchars=tab:»·,trail:·

" set bg=dark
set bg=dark
let g:solarized_visibility="high"
colorscheme solarized

highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

" Or if you have Neovim >= 0.1.5
" if (has("termguicolors"))
"  set termguicolors
" endif

" set bg=light
" colorscheme plain
" highlight StatusLine gui=underline,bold guifg=#545454
" highlight StatusLineNC gui=underline guifg=#767676


hi VertSplit ctermbg=NONE guibg=NONE
highlight Comment cterm=italic




" }}}

" {{{ Trailing whitespace
set colorcolumn=80
" highlight ExtraWhitespace ctermbg=red guibg=red
" autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
let g:toggleHighlightWhitespace = 1
function! ToggleHighlightWhitespace(...)
  if a:0 == 1 "toggle behaviour
    let g:toggleHighlightWhitespace = 1 - g:toggleHighlightWhitespace
  endif

  if g:toggleHighlightWhitespace == 1 "normal action, do the hi
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
  else
    call clearmatches()
  endif
endfunction

" autocmd BufWinEnter * call ToggleHighlightWhitespace()
" autocmd InsertEnter * call ToggleHighlightWhitespace()
" autocmd InsertLeave * call ToggleHighlightWhitespace()
" autocmd BufWinLeave * call ToggleHighlightWhitespace()
" }}}

" {{{ Python
let g:python3_host_prog = '/usr/local/bin/python'
" }}}

" {{{ FindRepoRoot()
function! FindRepoRoot()
    let current = expand('%:p:h')
    let home = expand("$HOME")
    while 1
        if isdirectory(expand(current . "/./.git"))
        \ || isdirectory(expand(current . "/./.hg"))
            break
        endif
        if current == home
            break
        endif
        let current = fnamemodify(current . "/../", ":p:h")
    endwhile
    return current
endfunction
" }}}

" {{{ FindFileAndOpen
function! FindFileAndOpen(filename)
    let current = expand('%:p:h')
    let home = expand("$HOME")
    while 1
        if filereadable(expand(current . "/./" . a:filename))
            break
        endif
        if isdirectory(expand(current . "/./.git"))
        \ || isdirectory(expand(current . "/./.hg"))
        \ || current == home
            return
        endif
        let current = fnamemodify(current . "/../", ":p:h")
    endwhile
    exe ":e " . expand(current . "/./" . a:filename)
endfunction

nnoremap  <leader>p :call FindFileAndOpen("package.json")<CR>
nnoremap  <leader>s :call FindFileAndOpen("setup.py")<CR>
" }}}

" {{{ FZF Settings

" ignore .gitignore and .hgignore files

let $FZF_DEFAULT_COMMAND = 'ag -l --nocolor
      \ --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore coverage
      \ --ignore build
      \ --ignore node_modules
      \ --ignore site-packages
      \ --ignore "*.egg-info"
      \ --ignore "**/*.pyc"
      \ --ignore "*.pyc"
      \ -g ""'

" make sure fzf quits easily

:au FileType fzf tnoremap <nowait><buffer> <esc> <c-g>

function! OpenRepoRoot()
    exe 'Files '. FindRepoRoot()
endfunction

function! OpenProjects()
    let current = expand('%:p:h')
    let home = expand("$HOME")
    let venv = expand("$HOME/dev")
    let found = home
    if current =~ '^'.venv
        let found = substitute(current, venv . '/', '', '')
        if found !~ '^/'
            let found = venv . '/' . substitute(found, '/.*$', '', '') . '/src'
        endif
    else
        let found = expand("$HOME/fun")
    endif
    exe 'Files '.found
endfunction

function! OpenHome()
    exe 'Files '.expand("$HOME")
endfunction

nnoremap <C-p> :call OpenRepoRoot()<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-f> :Ag 
nnoremap <C-h> :call OpenHome()<CR>
" nnoremap <C-o> :call OpenProjects()<CR>
nnoremap <C-t> :Tags<CR>
nnoremap <C-l> :Lines<CR>

" }}}

" {{{ Close other windows
command! -nargs=0 Wonly :only
command! -nargs=0 Only :only
" }}}

" {{{ Todo Alias
command! -nargs=0 Todo exe "sp ~/.todo.md"
" }}}

" {{{ Ale
nnoremap <leader>o :lopen<CR>
nnoremap <leader>c :lclose<CR>
nnoremap <leader>n :ALENextWrap<CR>

" let g:ale_lint_on_save = 1
" let g:ale_lint_on_text_changed = 0
let g:ale_ignore_2_4_warnings = 1

" Write this in your vimrc file
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
" let g:ale_lint_on_enter = 0

" --- snippet

" function! s:executable_callback(buffer) abort
"   echom "executable_callback!"
"   return 'true'
" endfunction

" function! s:get_command(buffer) abort
"   let l:abspath = expand('#' . string(a:buffer) . ':p')
"   let l:filetype = getbufvar(a:buffer, '&filetype')
"   echom "get_command!"
"   echom l:abspath
"   echom l:filetype

"   if (l:abspath =~ 'ahrefs/merlin3')
"       echom "DUNE"
"       return 'dune exec -p merlin-lsp -- ocamlmerlin-lsp'
"   endif

"   " BuckleScript OCaml 4.02
"   if (l:abspath =~ 'ahrefs/frontend' && l:filetype == 'reason')
"       return '/Users/zindel/ahrefs/merlin-opam/_build/install/default/bin/ocamlmerlin-lsp'
"   endif

"   " fallback is esy
"   return 'ocamlmerlin-lsp'
" endfunction

" function! s:get_language(buffer) abort
"   " echom "get_command!"
"   return getbufvar(a:buffer, '&filetype')
" endfunction

" function! s:get_project_root(buffer) abort
"   let l:package_json = ale#path#FindNearestFile(a:buffer, 'package.json')
"   let l:git = ale#path#FindNearestDirectory(a:buffer, '.git')
"   let l:path = !empty(l:package_json) ? fnamemodify(l:package_json, ':h') : (!empty(l:git) ? fnamemodify(fnamemodify(l:git, ':h'), ':h'): '')
"   echom "get_project_root"
"   echom l:path
"   return l:path
" endfunction

" call ale#linter#Define('ocaml', {
" \   'name': 'merlin-lsp',
" \   'lsp': 'stdio',
" \   'executable_callback': function('s:executable_callback'),
" \   'command_callback': function('s:get_command'),
" \   'language_callback': function('s:get_language'),
" \   'project_root_callback': function('s:get_project_root')
" \})

" call ale#linter#Define('reason', {
" \   'name': 'merlin-lsp',
" \   'lsp': 'stdio',
" \   'executable_callback': function('s:executable_callback'),
" \   'command_callback': function('s:get_command'),
" \   'language_callback': function('s:get_language'),
" \   'project_root_callback': function('s:get_project_root')
" \})

" --- snippet



let g:ale_linters = {
\   'ocaml': ['merlin'],
\   'reason': ['merlin'],
\   'javascript': ['flow'],
\   'javascript.jsx': ['flow'],
\   'haskell': ['hlint'],
\   'python': [],
\}

" }}}

" {{{ Elm
autocmd FileType elm map <buffer> <leader>f :ElmFormat<CR>
" }}}

" {{{ JavaScript
let g:javascript_plugin_flow = 1
" }}}

" {{{ Run ctags -R when saving files
function! RunCtags()
    let current = expand('%:p:h')
    let home = expand("$HOME")
    let repo = FindRepoRoot()

    if home != repo
        let cmd = 'cd ' . repo . ' && ctags -R --sort=yes'
        call jobstart(cmd)
    endif
endfunction

autocmd BufWrite *.yaml,*.elm,*.js,*.py,*.ml :call RunCtags()
" }}}

" {{{ Prettier
function! Prettier()
    let save_cursor = getpos(".")
    exe "normal! gggqG"
    if v:shell_error
        let line = getline(1)
        undo
        echo line
    else
        write
    endif

    call setpos('.', save_cursor)
endfunction

autocmd FileType javascript setlocal formatprg=prettier\ --stdin-filepath\ %\ --stdin
autocmd FileType javascript nnoremap <buffer> <leader>f :call Prettier()<CR>
" }}}

" {{{ Indent Guides
" let g:indent_guides_autocmds_enabled = 1
" let g:indent_guides_guide_size = 1
" let g:indent_guides_enable_on_vim_startup = 1
" let g:indent_guides_auto_colors = 1
" let g:indent_guides_color_change_percent = 50
" let g:indent_guides_exclude_filetypes = ['javascript', 'help']
" }}}

" {{{ OCAML Support

if empty($ESY__ROOT_PACKAGE_CONFIG_PATH)
    let g:opamshare = substitute(system('opam var share'),'\n$','','''')
    " let g:opamshare = substitute(system('opam var share --switch=reason-bs-6'),'\n$','','''')
    execute "set rtp+=" . g:opamshare . "/merlin/vim"
endif

function! MerlinSetBEnv(switch)
    let l:env = system('opam env --switch=' . a:switch)
    python3 <<EOF
env = vim.eval("l:env")
ret = []
for line in env.strip().split('\n'):
    var = line.split(';')[0].strip()
    try:
        var, value = var.split('=')
    except:
        continue
    ret.append(f'\'{var}\': {value}')
vim.command("let b:merlin_env = {" + ", ".join(ret) + "}")
EOF
endfunction

" function! MerlinSelectBinary()
"     echom "MerlinSelectBinary"
"     let g:yyy = &filetype
"     if &filetype == 'reason'
"         let l:path = substitute(system('opam exec --switch=reason-bs-6 -- which ocamlmerlin'),'\n$','','''')
"         call MerlinSetBEnv('reason-bs-6')
"         return l:path
"     else
"         let l:switch = substitute(system('opam switch show'),'\n$','','''')
"         let l:path = substitute(system('opam exec -- which ocamlmerlin'),'\n$','','''')
"         call MerlinSetBEnv(l:switch)
"         let g:switch = l:switch
"         let g:ppath = l:path
"         return l:path
"     endif
" endfunction

"
autocmd FileType ocaml setlocal commentstring=(*%s*)

let g:merlin_type_history_auto_open = 0

autocmd FileType ocaml,reason nnoremap <leader>t :MerlinTypeOf<CR>
autocmd FileType ocaml,reason nnoremap <leader>d :MerlinDestruct<CR>
autocmd FileType ocaml,reason nnoremap <leader>l :MerlinLocate<CR>
autocmd FileType ocaml,reason nnoremap <leader><Enter> :MerlinClearEnclosing<CR>


autocmd FileType reason setlocal formatprg=refmt\ --parse\ re
autocmd FileType reason nnoremap <buffer> <leader>f :call Prettier()<CR>
autocmd FileType ocaml setlocal formatprg=ocamlformat\ --name=input.ml\ -
autocmd FileType ocaml nnoremap <buffer> <leader>f :call Prettier()<CR>
" }}}


" let g:indentLine_setColors = 0
" let g:indentLine_char = '┆'
" let g:indentLine_char = '¦'
" let g:indentLine_char = '·'

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1


" {{{ Hide cursor line from inactive split
augroup CursorLineColumn
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
    au VimEnter * setlocal colorcolumn=80
    au WinEnter * setlocal colorcolumn=80
    au BufWinEnter * setlocal colorcolumn=80
    au WinLeave * setlocal colorcolumn=
augroup END
" }}}

" {{{ Russian Phonetic Mapping
cmap я q
cmap Я Q
nmap я q
nmap Я Q
vmap я q
vmap Я Q
cmap ш w
cmap Ш W
nmap ш w
nmap Ш W
vmap ш w
vmap Ш W
cmap е e
cmap Е E
nmap е e
nmap Е E
vmap е e
vmap Е E
cmap р r
cmap Р R
nmap р r
nmap Р R
vmap р r
vmap Р R
cmap т t
cmap Т T
nmap т t
nmap Т T
vmap т t
vmap Т T
cmap ы y
cmap Ы Y
nmap ы y
nmap Ы Y
vmap ы y
vmap Ы Y
cmap у u
cmap У U
nmap у u
nmap У U
vmap у u
vmap У U
cmap и i
cmap И I
nmap и i
nmap И I
vmap и i
vmap И I
cmap о o
cmap О O
nmap о o
nmap О O
vmap о o
vmap О O
cmap п p
cmap П P
nmap п p
nmap П P
vmap п p
vmap П P
cmap ю [
cmap Ю [
nmap ю [
nmap Ю [
vmap ю [
vmap Ю [
cmap ж ]
cmap Ж ]
nmap ж ]
nmap Ж ]
vmap ж ]
vmap Ж ]
cmap а a
cmap А A
nmap а a
nmap А A
vmap а a
vmap А A
cmap с s
cmap С S
nmap с s
nmap С S
vmap с s
vmap С S
cmap д d
cmap Д D
nmap д d
nmap Д D
vmap д d
vmap Д D
cmap ф f
cmap Ф F
nmap ф f
nmap Ф F
vmap ф f
vmap Ф F
cmap г g
cmap Г G
nmap г g
nmap Г G
vmap г g
vmap Г G
cmap ч h
cmap Ч H
nmap ч h
nmap Ч H
vmap ч h
vmap Ч H
cmap й j
cmap Й J
nmap й j
nmap Й J
vmap й j
vmap Й J
cmap к k
cmap К K
nmap к k
nmap К K
vmap к k
vmap К K
cmap л l
cmap Л L
nmap л l
nmap Л L
vmap л l
vmap Л L
cmap э \
cmap Э \
nmap э \
nmap Э \
vmap э \
vmap Э \
cmap щ `
cmap Щ `
nmap щ `
nmap Щ `
vmap щ `
vmap Щ `
cmap з z
cmap З Z
nmap з z
nmap З Z
vmap з z
vmap З Z
cmap х x
cmap Х X
nmap х x
nmap Х X
vmap х x
vmap Х X
cmap ц c
cmap Ц C
nmap ц c
nmap Ц C
vmap ц c
vmap Ц C
cmap в v
cmap В V
nmap в v
nmap В V
vmap в v
vmap В V
cmap б b
cmap Б B
nmap б b
nmap Б B
vmap б b
vmap Б B
cmap н n
cmap Н N
nmap н n
nmap Н N
vmap н n
vmap Н N
cmap м m
cmap М M
nmap м m
nmap М M
vmap м m
vmap М M
cmap ь -
cmap Ь -
nmap ь -
nmap Ь -
vmap ь -
vmap Ь -
cmap ъ =
cmap Ъ =
nmap ъ =
nmap Ъ =
vmap ъ =
vmap Ъ =
" }}}

set exrc
set secure

" vim: foldmethod=marker:
