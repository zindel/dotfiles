" {{{ NeoBundle
if has('vim_starting')
   if &compatible
     set nocompatible
   endif

   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'jlanzarotta/bufexplorer'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'mxw/vim-jsx'
" NeoBundle 'flowtype/vim-flow', { 'for': 'javascript' }
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'exu/pgsql.vim'
NeoBundle 'w0rp/ale'
NeoBundle 'ElmCast/elm-vim'
NeoBundle 'raichoo/purescript-vim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'gcmt/taboo.vim'
NeoBundle 'rakr/vim-one'
NeoBundle 'joshdick/onedark.vim'
NeoBundle 'junegunn/seoul256.vim'
NeoBundle '/usr/local/opt/fzf'
NeoBundle 'junegunn/fzf.vim'
" NeoBundle 'vim-airline/vim-airline'
" NeoBundle 'vim-airline/vim-airline-themes'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck
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
set clipboard=unnamed
let mapleader=","
nnoremap <Enter> :nohl<CR>
" }}}

" {{{ Wrap lines and make arrow keys support it
set wrap
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap <Down> gj
nnoremap <Up> gk
vnoremap <Down> gj
vnoremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk
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
set mouse=a
set laststatus=2
set splitright
set fillchars+=vert:│
set cmdheight=1
set cursorline

" set t_Co=256


let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" " For Neovim 0.1.3 and 0.1.4
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" " Or if you have Neovim >= 0.1.5
" if (has("termguicolors"))
"  set termguicolors
" endif

syntax enable

set bg=dark

let g:solarized_visibility="high"
colorscheme solarized

" if (has("autocmd") && !has("gui_running"))
"   let s:white = { "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7" }
"   autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white }) " No `bg` setting
" end
" let g:onedark_terminal_italics=1
" colorscheme onedark

hi VertSplit ctermbg=NONE guibg=NONE
highlight Comment cterm=italic



" }}}

" {{{ Trailing whitespace
set colorcolumn=80
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL
" }}}

" {{{ Terminal Settings
tnoremap <C-w><Left> <C-\><C-n><C-w>h
tnoremap <C-w><Right> <C-\><C-n><C-w>l
tnoremap <C-w><Down> <C-\><C-n><C-w>j
tnoremap <C-w><Up> <C-\><C-n><C-w>k
tnoremap <ESC><ESC> <C-\><C-n>
autocmd BufWinEnter,WinEnter term://* startinsert

let g:terminal_scrollback_buffer_size=100000

function! OpenTerminal()
    if $TMUX !~ '^$'
        silent exec '!tmux select-pane -L'
    else
        let d=expand("%:p:h")
        sp
        enew
        call termopen('CHDIR=' . d . ' zsh')
        startinsert
    endif
endfunction

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
nnoremap <C-o> :call OpenProjects()<CR>
nnoremap <C-t> :Tags<CR>

" }}}

" {{{ Close other windows
command! -nargs=0 Wonly :only
command! -nargs=0 Only :only
" }}}

" {{{ Airline
" let g:airline_powerline_fonts = 1
" }}}

" {{{ Todo Alias
command! -nargs=0 Todo exe "sp ~/.todo.md"
" }}}

" {{{ Ale
nnoremap <leader>o :lopen<CR>
nnoremap <leader>c :lclose<CR>
nnoremap <leader>n :ALENextWrap<CR>

let g:ale_linters = {
\   'javascript': ['eslint'],
\   'haskell': ['hlint'],
\}
" }}}

" {{{ Elm
autocmd FileType elm map <buffer> <leader>f :ElmFormat<CR>
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

autocmd BufWrite *.yaml,*.elm,*.js,*.py :call RunCtags()
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

autocmd FileType javascript set formatprg=prettier\ --stdin
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

" let g:opamshare = substitute(system('opam config var share'),'\n$','','''')
" execute "set rtp+=" . g:opamshare . "/merlin/vim"

" ## added by OPAM user-setup for vim / base ## 93ee63e278bdfc07d1139a748ed3fff2 ## you can edit, but keep this line
let s:opam_share_dir = system("opam config var share")
let s:opam_share_dir = substitute(s:opam_share_dir, '[\r\n]*$', '', '')

let s:opam_configuration = {}

function! OpamConfOcpIndent()
  execute "set rtp^=" . s:opam_share_dir . "/ocp-indent/vim"
endfunction
let s:opam_configuration['ocp-indent'] = function('OpamConfOcpIndent')

function! OpamConfOcpIndex()
  execute "set rtp+=" . s:opam_share_dir . "/ocp-index/vim"
endfunction
let s:opam_configuration['ocp-index'] = function('OpamConfOcpIndex')

function! OpamConfMerlin()
  let l:dir = s:opam_share_dir . "/merlin/vim"
  execute "set rtp+=" . l:dir
endfunction
let s:opam_configuration['merlin'] = function('OpamConfMerlin')

let s:opam_packages = ["ocp-indent", "ocp-index", "merlin"]
let s:opam_check_cmdline = ["opam list --installed --short --safe --color=never"] + s:opam_packages
let s:opam_available_tools = split(system(join(s:opam_check_cmdline)))
for tool in s:opam_packages
  " Respect package order (merlin should be after ocp-index)
  if count(s:opam_available_tools, tool) > 0
    call s:opam_configuration[tool]()
  endif
endfor
" ## end of OPAM user-setup addition for vim / base ## keep this line
"
autocmd FileType ocaml setlocal commentstring=(*%s*)
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

" vim: foldmethod=marker:
