if exists("g:moria_style")
    let s:moria_style = g:moria_style
else
    let s:moria_style = &background
endif

if exists("g:moria_monochrome")
    let s:moria_monochrome = g:moria_monochrome
else
    let s:moria_monochrome = 0
endif

if exists("g:moria_fontface")
    let s:moria_fontface = g:moria_fontface
else
    let s:moria_fontface = "plain"
endif

execute "command! -nargs=1 Colo let g:moria_style = \"<args>\" | colo moria"

if s:moria_style == "black" || s:moria_style == "dark"
    set background=dark
elseif s:moria_style == "light" || s:moria_style == "white"
    set background=light
else
    let s:moria_style = &background 
endif

hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "moria"

if &background == "dark"
    if s:moria_style == "dark"
        hi Normal ctermbg=0 ctermfg=7 guibg=#202020 guifg=#d0d0d0 gui=none
        hi clear CursorLine
        hi ColorColumn ctermbg=8 ctermfg=15 guibg=#494949 gui=none
        hi CursorColumn ctermbg=8 ctermfg=15 guibg=#404040 gui=none
        hi CursorLine ctermbg=8 ctermfg=15 guibg=#404040 gui=none
    elseif s:moria_style == "black"
        hi Normal ctermbg=0 ctermfg=7 guibg=#000000 guifg=#d0d0d0 gui=none

        hi ColorColumn ctermbg=8 ctermfg=15 guibg=#444444 gui=none
        hi CursorColumn ctermbg=8 ctermfg=15 guibg=#3a3a3a gui=none
        hi CursorLine ctermbg=8 ctermfg=15 guibg=#3a3a3a gui=none
    endif
    if s:moria_monochrome == 1
        hi FoldColumn ctermbg=bg guibg=bg guifg=#a0a0a0 gui=none
        hi LineNr ctermbg=fg guifg=#a0a0a0 gui=none
        hi MoreMsg guibg=bg guifg=#b6b6b6 gui=bold
        hi NonText ctermfg=8 guibg=bg guifg=#a0a0a0 gui=bold
        hi SignColumn ctermbg=bg guibg=bg guifg=#a0a0a0 gui=none
        hi TabLine guibg=#6e6e6e guifg=fg gui=underline
        hi TabLineFill guibg=#6e6e6e guifg=fg gui=underline
        if s:moria_fontface == "mixed"
            hi Folded guibg=#4e4e4e guifg=#c0c0c0 gui=bold
        else
            hi Folded guibg=#4e4e4e guifg=#c0c0c0 gui=none
        endif            
    else
        hi FoldColumn ctermbg=bg guibg=bg guifg=#8fa5d1 gui=none
        hi LineNr guifg=#2B2B2B ctermfg=159 guibg=#C0C0FF
        hi MoreMsg guibg=bg guifg=#97abd5 gui=bold
        hi NonText ctermfg=8 guibg=bg guifg=#8fa5d1 gui=bold
        hi SignColumn ctermbg=bg guibg=bg guifg=#8fa5d1 gui=none
        hi TabLine guibg=#41609e guifg=fg gui=underline
        hi TabLineFill guibg=#41609e guifg=fg gui=underline
        if s:moria_fontface == "mixed"
            hi Folded guibg=#4e4e4e guifg=#bdcae3 gui=bold
        else
            hi Folded guibg=#4e4e4e guifg=#bdcae3 gui=none
        endif            
    endif
    hi Cursor guibg=#ffa500 guifg=bg gui=none
    hi DiffAdd guibg=#008b00 guifg=fg gui=none
    hi DiffChange guibg=#00008b guifg=fg gui=none
    hi DiffDelete guibg=#8b0000 guifg=fg gui=none
    hi DiffText guibg=#0000cd guifg=fg gui=bold
    hi Directory guibg=bg guifg=#1e90ff gui=none
    hi ErrorMsg guibg=#ee2c2c guifg=#ffffff gui=bold
    hi IncSearch guibg=#e0cd78 guifg=#000000 gui=none
    hi ModeMsg guibg=bg guifg=fg gui=bold
    hi Question guibg=bg guifg=#e8b87e gui=bold
    hi Search guibg=#90e090 guifg=#000000 gui=none
    hi SpecialKey guibg=bg guifg=#e8b87e gui=none
    if has("spell")
        hi SpellBad guisp=#ee2c2c gui=undercurl
        hi SpellCap guisp=#2c2cee gui=undercurl
        hi SpellLocal guisp=#2ceeee gui=undercurl
        hi SpellRare guisp=#ee2cee gui=undercurl
    endif
    hi TabLineSel guibg=bg guifg=fg gui=bold
    hi Title ctermbg=0 ctermfg=15 guifg=fg gui=bold
    if version >= 700
        hi Visual ctermbg=7 ctermfg=0 guibg=#606060 gui=none
    else
        hi Visual ctermbg=7 ctermfg=0 guibg=#606060 guifg=fg gui=none
    endif
    hi VisualNOS ctermbg=8 ctermfg=0 guibg=bg guifg=#a0a0a0 gui=bold,underline
    hi WarningMsg guibg=bg guifg=#ee2c2c gui=bold
    hi WildMenu guibg=#e0e000 guifg=#000000 gui=bold

    hi Comment guibg=bg guifg=#d0d0a0 gui=none
    hi Constant guibg=bg guifg=#87df71 gui=none
    hi Error guibg=bg guifg=#ee2c2c gui=none
    hi Identifier guibg=bg guifg=#7ee0ce gui=none
    hi Ignore guibg=bg guifg=bg gui=none
    hi lCursor guibg=#00e700 guifg=#000000 gui=none
    hi MatchParen guibg=#008b8b gui=none
    hi Special guibg=bg guifg=#e8b87e gui=none
    hi Todo guibg=#e0e000 guifg=#000000 gui=none
    hi Underlined ctermbg=0 ctermfg=15 guibg=bg guifg=#00a0ff gui=underline    

    if s:moria_fontface == "mixed"
        hi Statement guibg=bg guifg=#7ec0ee gui=bold
        hi Type guibg=bg guifg=#f09479 gui=bold
    else
        hi Statement guibg=bg guifg=#7ec0ee gui=none
        hi Type guibg=bg guifg=#f09479 gui=none
    endif

    hi htmlBold ctermbg=0 ctermfg=15 guibg=bg guifg=fg gui=bold
    hi htmlBoldItalic ctermbg=0 ctermfg=15 guibg=bg guifg=fg gui=bold,italic
    hi htmlBoldUnderline ctermbg=0 ctermfg=15 guibg=bg guifg=fg gui=bold,underline
    hi htmlBoldUnderlineItalic ctermbg=0 ctermfg=15 guibg=bg guifg=fg gui=bold,underline,italic
    hi htmlItalic ctermbg=0 ctermfg=15 guibg=bg guifg=fg gui=italic
    hi htmlUnderline ctermbg=0 ctermfg=15 guibg=bg guifg=fg gui=underline
    hi htmlUnderlineItalic ctermbg=0 ctermfg=15 guibg=bg guifg=fg gui=underline,italic
endif

hi! default link bbcodeBold htmlBold
hi! default link bbcodeBoldItalic htmlBoldItalic
hi! default link bbcodeBoldItalicUnderline htmlBoldUnderlineItalic
hi! default link bbcodeBoldUnderline htmlBoldUnderline
hi! default link bbcodeItalic htmlItalic
hi! default link bbcodeItalicUnderline htmlUnderlineItalic
hi! default link bbcodeUnderline htmlUnderline
hi Folded 		guibg=#384048 guifg=#a0a8b0 gui=none ctermfg=81 ctermbg=16
hi Visual		guifg=#ffffd7 guibg=#444444 gui=none ctermfg=186 ctermbg=blue
hi LineNr 		guifg=#808080 guibg=#000000 gui=none ctermfg=7 ctermbg=16
hi StatusLine ctermbg=80 ctermfg=85 guibg=#a0a0a0 guifg=fg gui=bold
hi StatusLineNC ctermfg=83 ctermbg=black 
hi Keyword guifg=#CC7833 ctermfg=1
hi Statement guifg=#CC7833 ctermfg=6 gui=NONE
hi Function guifg=#FFC66D ctermfg=77 gui=NONE
hi Type guifg=#DA4939 ctermfg=68 gui=NONE cterm=NONE
hi String guifg=#A5C261 ctermfg=2
hi Comment guifg=#BC9458 ctermfg=82 gui=italic
hi PreProc guifg=#CC7833 ctermfg=69
hi TabLine guifg=#080808 guibg=#080808 ctermfg=86 ctermbg=81
hi Title guifg=#FFFFFF ctermfg=15 ctermbg=80
