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

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck



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

" Use CTRL+Arrows to movei across windows
imap <C-W> <C-O><C-W>
"imap <Esc><Up>		<C-W>k
"imap <M-Up>		<C-O><C-W>k
"map <Esc><Down>		<C-W>j
"imap <M-Down>		<C-O><C-W>j
"noremap <Esc><Left>		<C-W><Left>
"inoremap <C-Left>		<C-O><C-W><Left>
"noremap <Esc><Right>		<C-W><Right>
"inoremap <C-Right>		<C-O><C-W><Right>

" oncve again do something

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

nnoremap <C-T> :tabnew<CR>
nnoremap <C-N> :tabnext<CR>
nnoremap <C-P> :tabprevious<CR>

"set encoding=koi8-r
"set fileencodings=cp1251,koi8-r 
"set fileencoding=koi8-r 
set directory=~/.vimtmp/,.,/tmp

function ToDos()
	:e ++enc=866
	:syntax on
endfunction

function ToKoi()
	:e ++enc=koi8-r
	:syntax on
endfunction

au BufReadPost * if getline(1) =~ "# dos:" | call ToDos() | endif
au BufReadPost * if getline(1) =~ ".*koi8.*" | call ToKoi() | endif
au BufReadPost * if getline(1) =~ ".*KOI8.*" | call ToKoi() | endif
au BufReadPost * if getline(2) =~ ".*koi8.*" | call ToKoi() | endif

function Insert()
	set cul
endfunction

function NoInsert()
	set nocul
	"syntax on
	"\<Esc>
	"\<Esc>
	"\<Esc>
endfunction

function Yet()
	<Esc>
endfunction

set autoindent		" always set autoindenting on
"set bg=light

let python_highlight_all = 1

set clipboard=unnamed
set expandtab
set cmdheight=1

function! CHANGE_CURR_DIR() 
"    let _dir = expand("%:p:h") 
    exec "cd %:p:h"
"    exec "cd " . _dir 
"    unlet _dir 
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
nnoremap <C-Left> <C-W><Left>
nnoremap <C-Right> <C-W><Right>

inoremap <C-Up> <C-O><C-W><Up>
inoremap <C-Down> <C-O><C-W><Down>
inoremap <C-Left> <C-O><C-W><Left>
inoremap <C-Right> <C-O><C-W><Right>

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

" color theme support
"let g:solarized_contrast="high"    "default value is normal
"let g:solarized_visibility="high"    "default value is normal
let g:solarized_termcolors=256
syntax enable
set bg=dark
colorscheme solarized

" all sql files are by default pgsql
let g:sql_type_default = 'pgsql'


command B :BufExplorer

