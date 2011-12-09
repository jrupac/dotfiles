""" Author: Ajay Roopakalu

""" Vundle:
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

""" Vundle Bundles:
Bundle 'gmarik/vundle'

Bundle 'scrooloose/nerdtree'
Bundle 'ervandew/supertab'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdcommenter'
Bundle 'tagbar'
Bundle 'scratch.vim'

Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/snipmate-snippets'
Bundle 'garbas/vim-snipmate'

Bundle 'kevinw/pyflakes-vim'

"""  Basic Configurations:

set autochdir
set autoindent
set autowrite
set bs=2
set colorcolumn=80
set cursorline
set expandtab
set foldmethod=syntax
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lz
set mouse=a
set nocompatible
set nowrap
set number
set ruler
set shiftwidth=4
set showcmd
set showfulltag
set showmode
set smartcase
set smartindent
set switchbuf=usetab
set tabstop=4
set wildmenu
set wildmode=longest,full
set whichwrap+=h,l,<,>

""" Options:
filetype on
filetype plugin on
syn on
au FocusLost * :wa
let mapleader = ","
let g:mapleader = ","
let maplocalleader = ","


""" Autocmd Options:
if has("autocmd") 
""" Java options
    autocmd FileType java setlocal omnifunc=javacomplete#Complete

""" Python options
    autocmd BufRead *.py setlocal foldmethod=indent

""" Hard tabs in Makefiles
    autocmd FileType make setlocal noexpandtab

""" Hard tabs in .txt files
    autocmd BufRead,BufNew *.txt setlocal noexpandtab

""" "Obvious Mode"
    autocmd InsertEnter * hi StatusLine ctermfg=202 ctermbg=258
    autocmd InsertLeave * hi StatusLine ctermfg=253 ctermbg=258 

""" Automatically open Tagbar in files
    autocmd VimEnter,BufNew * nested TagbarOpen

""" Automatically close preview window on omnicomplete
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif 
endif 


""" Theme Options:
set background=dark
set t_Co=256
colors railscasts
hi SignColumn guibg=#384048 guifg=#a0a8b0 gui=none ctermfg=239 ctermbg=232

""" Misc Mappings And Configs:
cmap w!! %!sudo tee > /dev/null %
imap <c-c> <Esc>
imap jj <Esc>
nnoremap <silent> <C-Left> :tabprevious<CR>
nnoremap <silent> <C-Right> :tabnext<CR>
nnoremap <silent> <C-t> :tabnew<CR>
nnoremap ' ` 
vmap < <gv
vmap > >gv
nmap ; :
let g:clipbrdDefaultReg = '+'

""" TagBar Options:
let g:tagbar_autoclose = 0
let g:tagbar_autofocus = 0
let g:tagbar_width = 40
let g:tagbar_left = 0
let g:tagbar_compact = 1
let g:tagbar_sort = 0
let g:tagbar_singleclick = 1

""" Syntastic Options:
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=1

""" Scratch Options:
com! S Sscratch

""" SuperTab Options:
let g:SuperTabDefaultCompletionType = 'context'

""" Conque Options:
let g:ConqueTerm_InsertOnEnter = 1
let g:ConqueTerm_CWInsert = 1
let g:ConqueTerm_Color = 0

