""" Author: Ajay Roopakalu

""" Pathogen:
call pathogen#infect()

"""  Basic Configurations:

set autochdir
set autoindent
set autowrite
set bs=2
set cursorline
set expandtab
set foldlevelstart=99
set foldmethod=syntax
set guioptions-=m
set guioptions-=r
set guioptions-=T
set guioptions-=L
set hlsearch
set ignorecase
set incsearch
set laststatus=2
set lz
set list
set listchars=
set listchars=tab:▸\ ,trail:⋅,nbsp:⋅
set mouse=a
set nocompatible
set nowrap
set number
set pastetoggle=<F12>
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

if v:version >= 703
    set colorcolumn=80
endif

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
    autocmd BufRead *.py setlocal foldmethod=indent expandtab

""" OCaml options
    autocmd FileType ocaml setlocal ts=2 sw=2 colorcolumn=80

""" Hard tabs in Makefiles
    autocmd FileType make setlocal noexpandtab

""" Hard tabs in .txt files


""" Open TagBar
    autocmd VimEnter * nested TagbarOpen

""" "Obvious Mode"
    autocmd InsertEnter * hi StatusLine ctermfg=202 ctermbg=258
    autocmd InsertLeave * hi StatusLine ctermfg=253 ctermbg=258

""" Automatically close preview window on omnicomplete
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
endif


""" Theme Options:
set background=dark
set t_Co=256
colors mustang
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

""" Pylint Options:
let g:pymode_lint_checker = 'pyflakes'
let g:pymode_lint_onfly = 1
let g:pymode_syntax = 0
let g:pymode_rope_vim_completion = 1
let g:pymode_rope_extended_complete = 1

let g:Powerline_symbols = 'fancy'
let g:syntastic_ocaml_use_ocamlc = 1

