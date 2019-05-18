" Vimrc configuration file.
"
" Maintainer:	Rodrigo Alonso
" Last change:	2015 Mar 28 
"
" Sections: 
" 	General
" 	Packages
" 	Keymaps
" 	vim UI
" 	Files
" 	Editing
" 	Autocmds and lang specific
" 	Helpers
" 	Plugin configuration
"


""""""""""""""""""""""""""""""
" GENERAL
""""""""""""""""""""""""""""""
" Set to auto read when a file is changed from the outside
set autoread

" Use Vim settings
" This must be first, because it changes other options as a side effect.
set nocompatible
set laststatus=2
set encoding=utf-8
set hidden

" Remember stuff
set history=256
set undolevels=512
" Last postion
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

if has('langmap') && exists('+langnoremap')
  " Prevent that the langmap option applies to characters that result from a
  " mapping.  If unset (default), this may break plugins (but it's backward
  " compatible).
  set langnoremap
endif

" Pathogen, to install plugins and rutnime files in their own private directories
" execute pathogen#infect()
""""""""""""""""""""""""""""""
" PACKAGES
""""""""""""""""""""""""""""""
" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
	execute '!mkdir -p ~/.vim/autoload'
	execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/plugged')

" Dependencies 
 Plug 'tomtom/tlib_vim'  		"tlib - for vim-asciidoc
 Plug 'dahu/Asif'        		"asif - for vim-asciidoc 
 Plug 'vim-scripts/SyntaxRange'	"SyntaxRange - for vim-asciidoc

" Git interface extensions
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

" Completion
 Plug 'Valloric/YouCompleteMe'
" Plug 'mattn/emmet-vim'
" Plug 'Shougo/neocomplete.vim'

" autoclose brackets, parenth, etc
 Plug 'jiangmiao/auto-pairs'

" status tabline pretty 
 Plug 'bling/vim-airline'

" File handling 
 Plug 'kien/ctrlp.vim'
 Plug 'mileszs/ack.vim'
 Plug 'scrooloose/nerdtree'

" Text wrangling
 Plug 'tpope/vim-commentary'
 Plug 'godlygeek/tabular'
 Plug 'kien/rainbow_parentheses.vim'

" FileType
" Plug 'vim-ruby/vim-ruby'
" Plug 'tpope/vim-rails'
" Plug 'kchmck/vim-coffee-script'
" Plug 'othree/html5.vim'
" Plug 'tpope/vim-haml'
" Plug 'dahu/vim-asciidoc'
" Plug 'plasticboy/vim-markdown'
 Plug 'fatih/vim-go'
" Plug 'vim-jp/vim-go-extra'
" Plug 'dgryski/vim-godef'
" Plug 'Blackrush/vim-gocode'
" Plug 'nsf/gocode'

" Colorschemes
" Plug 'Heldraug/vim-megara'
 Plug 'fatih/molokai'

" tagbars
 Plug 'majutsushi/tagbar'

" Syntax corrector 
 Plug 'scrooloose/syntastic'

" All plugins should be added before this line
call plug#end()

""""""""""""""""""""""""""""""
" KEYMAPS 
""""""""""""""""""""""""""""""
" Use spacebar to repeat last command
nore <Space> .

" Use . as :
nore . :
" Set the <Leader> key as ,
let mapleader = ","

" Use jk instead of ESC to exit edit mode 
imap jk <ESC>

" Paste from the clipboard without indenting
set pastetoggle=<leader>p

" Power navigation, by Andrew Radev
nmap J 5j
noremap K 5k
xmap J 5j
xmap K 5k

" Navigate between split windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l

" Buffer keymaps
map <Leader>bn :bnext<cr>
map <Leader>bN :bprevious<cr>
map <Leader>bd :bdelete<cr>

" Tab keymaps
map <Leader>to :tabnew<cr>
map <Leader>tc :tabclose<cr>
map <Leader>tn :tabn<cr>
map <Leader>tp :tabp<cr>


" Dismiss search highlight 
nmap <Leader><Space> :nohl<cr>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Autocompletion 
" imap <Tab> <C-x><C-o>

" Tagbar
nmap <Leader>8 :TagbarToggle<cr>

" NERDtree
nmap <Leader>nt :NERDTreeToggle<cr>

""""""""""""""""
" Plugin Keymaps
""""""""""""""""
""""""""""""
" Commentary
""""""""""""
xmap <Leader>c <Plug>Commentary
nmap <Leader>c <Plug>Commentary
nmap <Leader>cc <Plug>CommentaryLine
nmap <Leader>cu <Plug>CommentaryUndo

"""""""""""""""""""""""""""""
" VIM UI 
""""""""""""""""""""""""""""""
" Editing position aid
set number
set numberwidth=4
set ruler
set cul
set showmatch

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Search options
set ignorecase
set smartcase
set hlsearch
set incsearch
set magic

" Don't redraw while executing macros
" Doesn't look as cool 
set lazyredraw

" I HATE BELLS
set novisualbell
set noerrorbells
set t_vb=

" Vim command line 
set showcmd		" display incomplete commands
set cmdheight=1

" Golang Specific
filetype off
filetype plugin indent off
set rtp+=$GOROOT/misc/vim
filetype plugin indent on
syntax on 

let g:tagbar_type_go = {  
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
            \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

colorscheme molokai
let g:rehash256=1
set t_Co=256

""""""""""""""""""""""""""""""
" FILES
"""""""""""""""""""""""""""""" 
" Don't write anything but the file
set nobackup
set nowb
set noswapfile

" Blowfish encryption
setlocal cryptmethod=blowfish

" Filetypes
filetype plugin on
filetype indent on
set omnifunc=syntaxcomplete#Complete
augroup vimrcEx
au!

""""""""""""""""""""""""""""""
" EDITING
"""""""""""""""""""""""""""""" 
" Use 4-space tabs
set softtabstop=4
set tabstop=4
set shiftwidth=4

" Use spaces for tabs
set expandtab
set smarttab

" Indent
set autoindent
set smartindent
set wrap

""""""""""""""""""""""""""""""
" AUTOCOMMANDS AND LANG SPECIFIC 
""""""""""""""""""""""""""""""
autocmd!

" Set [...] to 2-space indent
autocmd WinEnter,FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set sts=2 ts=2 sw=2

" Text ->git, Asciidoc
autocmd FileType text setlocal textwidth=80
autocmd FileType asciidoc setlocal textwidth=80

" Don't change tabs for spaces in Makefiles
autocmd FileType make setlocal noexpandtab

" Delete trailing white space on save
func! DeleteTrailingWS()
	exe "normal mz"
	%s/\s\+$//ge
	exe "normal" `z"
endfunc

" Auto fmt Go files
autocmd FileType go autocmd BufWritePre <buffer> :GoImports
" autocmd FileType go autocmd BufWritePre <buffer> :GoVet
" autocmd FileType go autocmd BufWritePre <buffer> :GoLint
" autocmd FileType go autocmd BufWritePre <buffer> :GoBuild
" autocmd FileType go autocmd BufWritePre <buffer> :GoTest

autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.txt :call DeleteTrailingWS()

""""""""""""""""""""""""""""""
" HELPERS
""""""""""""""""""""""""""""""
" Show syntax highlighting groups for word under cursor
" By VimCasts
nmap <Leader>s :call <SID>SynStack()<CR>
function!  <SID>SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

""""""""""""""""""""""""""""""
" PACKAGE CONFIGURATION
""""""""""""""""""""""""""""""
"""""""""
" Airline
"""""""""
let g:airline_theme = 'powerlineish'
" let g:airline_theme = 'bubblegum'
let g:airline#extensions#whitespace#checks=[]
let g:airline#extenstions#tagbar#enabled =1

"""""""""
" CtrlP
"""""""""
" When opening multiple files, opent hem in the background
let g:ctrlp_open_multiple_files = 'i'

"""""""""""""""""
" Rainbow Parenth
"""""""""""""""""
au VimEnter * RainbowParenthesesActivate
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

""""""""""""
" Necomplete
""""""""""""
" let g:acp_enableAtStartup = 0
" let g:neocomplete

""""""""""""
" Vim-go
""""""""""""
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
au FileType go nmap <Leader>e <Plug>(go-rename)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
" let g:go_fmt_command = "goimports"
" let g:go_fmt_fail_silently = 1
