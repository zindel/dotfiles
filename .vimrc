if has('vim_starting')
   if &compatible
     set nocompatible               " Be iMproved
   endif

   " Required:
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
NeoBundle 'editorconfig/editorconfig-vim'
NeoBundle 'exu/pgsql.vim'
NeoBundle 'lambdatoast/elm.vim'
NeoBundle 'raichoo/purescript-vim'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'
NeoBundle 'ctrlpvim/ctrlp.vim'
NeoBundle 'tpope/vim-commentary'
NeoBundle 'mileszs/ack.vim'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif



set nocompatible
set backspace=indent,eol,start
syntax on
filetype plugin indent on
"set backup
set history=150		" keep 150 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set hlsearch
set autoindent		" always set autoindenting on
set tabstop=4
set softtabstop=4
set sw=4
set novb
set noeb

set mouse=

set nobackup
"let Tlist_Ctags_Cmd="D:\\Lang\\Ctags\\ctags"
"let Tlist_Display_Prototype = 1
"hi clear
"colorscheme torte

" Use CTRL-S for saving, also in Insert mode
noremap <C-S>		:update<CR>
vnoremap <C-S>		<C-C>:update<CR>
inoremap <C-S>		<C-O>:update<CR>
inoremap <C-V>		<C-O>"*p<CR>


set laststatus=2
"set statusline=%-10.20t%7.7m%20.20y%7.7l,%7.7c%10.10P%5.5b

"imap <M-c> <Esc><Plug>Traditionalji
"map <M-c> <Esc><Plug>Traditionalji
"vmap <M-c> <Plug>VisualFirstLine

"imap <F8> <C-O>:Tlist<CR><C-O><C-W><Left>
"map <F8> <Esc>:Tlist<CR><C-W><Left>

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


set directory=~/.vimtmp/,.,/tmp


let python_highlight_all = 1

set clipboard^=unnamed
set expandtab
set cmdheight=1

function! CHANGE_CURR_DIR()
    exec "cd %:p:h"
endfunction
autocmd BufWinEnter * call CHANGE_CURR_DIR()
autocmd BufEnter * call CHANGE_CURR_DIR()
autocmd WinEnter * call CHANGE_CURR_DIR()
autocmd BufReadPost * call CHANGE_CURR_DIR()

let Tlist_Use_Right_Window = 1
let Tlist_Close_On_Select = 1
let Tlist_GainFocus_On_ToggleOpen = 1
nnoremap <F2> :TlistToggle<CR>:TlistUpdate<CR>
inoremap <F2> <C-O>:TlistToggle<CR><C-O>:TlistUpdate<CR>

nnoremap <C-Up> <C-W><Up>
nnoremap <C-Down> <C-W><Down>


inoremap <C-Up> <C-O><C-W><Up>
inoremap <C-Down> <C-O><C-W><Down>

function! TabForward()
 if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
   return "\<C-N>"
 else
   return "\<Tab>"
endfunction

inoremap <Tab> <C-R>=TabForward()<CR>


set viminfo='100,\"200,:50,%,n~/.viminfo
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

:au BufNewFile,BufRead *.boo setf boo

set colorcolumn=80

"au BufNewFile,BufRead *.yaml,*.ym so ~/.vim/syntax/yaml.vim

set nobackup
set backupdir=/tmp
set directory=/tmp
set shell=bash

let mapleader = ","
set t_Co=256
set cursorline

set bg=dark
" color theme support
"let g:solarized_contrast="high"    "default value is normal
let g:solarized_visibility="high"    "default value is normal
let g:solarized_termcolors=256
syntax enable
colorscheme solarized
"set bg=dark

" all sql files are by default pgsql
let g:sql_type_default = 'pgsql'


" Show trailing whitepace and spaces before a tab:
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t/ containedin=ALL

" CtrlP settings
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|[^\/]+\.egg-info)$',
  \ 'file': '\v\.(exe|so|dll|pyc)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_root_markers = ['rex.core']
nnoremap <C-B> :CtrlPBuffer<CR>
nnoremap <C-o> :CtrlP $VIRTUAL_ENV/src<CR>

"Home/End
nnoremap B 0
nnoremap E $



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
" }}}

" vim: foldmethod=marker:
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
