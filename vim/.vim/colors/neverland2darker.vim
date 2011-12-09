" Vim color file - neverland2-darker.vim
" Eyes are sober, this is the plan
" I'm sitting in a car heading Neverland
" Author: Magnus Woldrich <trapd00r@trapd00r.se>


set background=dark
hi clear

if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="neverland2darker"


" Support for 256-color terminal
if &t_Co > 255

   set background=dark

   hi Normal 		guifg=#e2e2e5 guibg=#202020 gui=none ctermfg=256 ctermbg=232
   hi Boolean         ctermfg=135
   hi Character       ctermfg=143
   hi Number          ctermfg=33
   hi String          ctermfg=179
   hi Conditional     ctermfg=196               cterm=bold
   hi Constant        ctermfg=135               cterm=bold
   hi Cursor          ctermfg=150  ctermbg=253
   hi Debug           ctermfg=225               cterm=bold
   hi Define          ctermfg=81
   hi Delimiter       ctermfg=241

   hi DiffAdd                     ctermbg=232
   hi DiffChange      ctermfg=181 ctermbg=234
   hi DiffDelete      ctermfg=162 ctermbg=232
   hi DiffText                    ctermbg=232 cterm=bold

   hi Directory       ctermfg=118               cterm=bold
   hi Error           ctermfg=219 ctermbg=232
   hi ErrorMsg        ctermfg=199 ctermbg=232    cterm=bold
   hi Exception       ctermfg=118               cterm=bold
   hi Float           ctermfg=135
   hi FoldColumn      ctermfg=67  ctermbg=16
   hi Folded          ctermfg=67  ctermbg=16
   hi Function        ctermfg=197 " sub..
   hi Identifier      ctermfg=166 " ..foo
   hi Ignore          ctermfg=244 ctermbg=232

   hi Keyword         ctermfg=74                cterm=bold
   hi Label           ctermfg=229               cterm=none
   hi Macro           ctermfg=193
   hi SpecialKey      ctermfg=81

   hi ModeMsg         ctermfg=215
   hi MoreMsg         ctermfg=215
   hi Operator        ctermfg=46

   " complete menu
   hi Pmenu           ctermfg=81  ctermbg=242
   hi PmenuSel                    ctermbg=184

   hi PreCondit       ctermfg=118               cterm=bold
   hi PreProc         ctermfg=218
   hi Question        ctermfg=81
   hi Repeat          ctermfg=161               cterm=bold

   " marks column
   hi SignColumn      ctermfg=118 ctermbg=235
   hi SpecialChar     ctermfg=161               cterm=bold
   hi SpecialComment  ctermfg=245               cterm=bold
   hi Special         ctermfg=81  ctermbg=232
   hi SpecialKey      ctermfg=245

   hi Statement       ctermfg=228               cterm=bold " my...
   hi StorageClass    ctermfg=208
   hi Structure       ctermfg=81
   hi StatusLine 	guifg=#d3d3d5 guibg=#444444 gui=italic ctermfg=253 ctermbg=238 cterm=italic
   hi StatusLineNC guifg=#939395 guibg=#444444 gui=none ctermfg=246 ctermbg=238
   hi Tag             ctermfg=161
   hi Title		guifg=#f6f3e8 guibg=NONE	gui=bold ctermfg=white cterm=bold
   hi Todo            ctermfg=160 ctermbg=232   cterm=bold

   hi Typedef         ctermfg=81
   hi Type            ctermfg=81                cterm=none
   hi Underlined      ctermfg=244               cterm=underline

   hi VertSplit 	guifg=#444444 guibg=#444444 gui=none ctermfg=238 ctermbg=238
   hi VisualNOS                   ctermbg=238
   hi Visual                      ctermbg=235
   hi WarningMsg      ctermfg=21 ctermbg=238   cterm=bold

   hi Comment         ctermfg=101
   hi CursorLine                  ctermbg=234   cterm=none
   hi CursorColumn                ctermbg=234
   hi LineNr 		guifg=#808080 guibg=#000000 gui=none ctermfg=244 ctermbg=233
   hi NonText 		guifg=#808080 guibg=#303030 gui=none ctermfg=248 ctermbg=233

   hi TabLine     guifg=#080808 guibg=#080808 ctermfg=225 ctermbg=239

   hi Search ctermbg=yellow ctermfg=black
   hi MatchParen guifg=#f6f3e8 guibg=#ff9800 gui=bold ctermbg=208
   hi ColorColumn guibg=#2d2d2d ctermbg=237

end
