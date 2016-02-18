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

function ToDos()
	:e ++enc=866
	:syntax on
endfunction

function ToKoi()
	:e ++enc=koi8-r
	:syntax on
endfunction


let python_highlight_all = 1

set clipboard=unnamed
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
"let g:solarized_termcolors=256
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


" Alternative tab navigation
nnoremap <C-T> :tabnew<CR>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabprevious<CR>

