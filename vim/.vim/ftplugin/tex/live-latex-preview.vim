" 
" Live LaTeX preview script, v0.6 Kevin C. Klement
" klement <at> philos <dot> umass <dot> edu
" 
" Only do this when not done yet for this buffer
if exists("b:did_llpplugin")
  finish
endif
let b:did_llpplugin = 1
" Install help file if not already installed
if !filereadable($HOME . "/.vim/doc/live-latex-preview.txt")
   silent! exec "! mkdir -p " . $HOME . "/.vim/doc"
   if filereadable($VIMRUNTIME . "/ftplugin/tex/live-latex-preview.txt")
      silent! exec "!cp " . $VIMRUNTIME . "/ftplugin/tex/live-latex-preview.txt " . $HOME . "/.vim/doc/"
   endif
endif
" Read tags from help file
if filereadable($HOME . "/.vim/doc/live-latex-preview.txt")
    silent! helptags $HOME/.vim/doc
endif
" Make sure config files have somewhere to go
silent! exec "! mkdir -p " . $HOME . "/.config/live-latex-preview"
silent! exec "! echo -n 9999 > " . $HOME ."/.config/live-latex-preview/activepid"
" Set up initial variables 
let b:Pdfviewing = "no"
let b:MuPDFWindowID = "999999"
" Look for root file
function! LivePreviewFindRoot()
    let b:Rootfile = expand("%")
    for linenum in range(1,5)
        let linecontents = getline(linenum)
        if linecontents =~ 'root\s*='
           let b:Rootfile = substitute(linecontents, '.*root\s*=\s*', "", "")
           let b:Rootfile = substitute(b:Rootfile, '\s*$', "", "")
        endif
    endfor
    let b:Pdfroot = substitute(b:Rootfile, '\.tex$', "", "") 
endfunction
call LivePreviewFindRoot()
" make space for messages
setlocal cmdheight=2
" open PDF viewer
function! LaunchMuPDF() 
    " Go to right directory and keep it that way
    lcd %:p:h
    setlocal autochdir
    if filewritable(bufname("%"))
        call LivePreviewFindRoot()
        if b:Pdfviewing == "yes"
           call system("xdotool windowkill " . b:MuPDFWindowID)
        endif
        if !filereadable(b:Pdfroot.".pdf")
            echo "Initial compile..."
            silent! call system("live-latex-update.sh \"" . b:Rootfile . "\" 123456789")
        endif
        if filereadable(b:Pdfroot.".pdf")
            let b:MuPDFWindowID = system("mupdf-launch.sh \"" . b:Pdfroot . ".pdf\" \"" . expand("%") . "\"")
            let b:Pdfviewing = "yes"
            echo "Live preview mode now ON."
        else 
            echoerr "Compilation failed; the PDF does not exist."
        endif
    else
        echo "You must save the file first at least once."
    endif
endfunction
" Close viewer; end compilation
function! CloseMuPDF()
    if b:Pdfviewing == "yes"
       call system("xdotool windowkill ".b:MuPDFWindowID)
    endif
    let b:Pdfviewing = "no"
    echo "Live preview mode now OFF."
endfunction
" forward search with mupdf
function! MuPDFForward()
    lcd %:p:h
    let pageforward = 0
    let searchline = line(".") + 1
    let searchcol = col(".") + 1
    let pageforward = system("synctex view -i " . searchline . ":" . searchcol . ":\"" . expand("%") . "\" -o \"" . b:Pdfroot . ".pdf\" | grep -m1 'Page:' | sed 's/Page://' | tr -d '\n'")  
    if pageforward > 0
        echo "Jumping to page " . pageforward 
        silent call system("xdotool type --window " .b:MuPDFWindowID."  \"" . pageforward . "g\"")
    endif
endfunction
function! MuPDFReverse()
    lcd %:p:h
    if b:Pdfviewing == "yes"
        let activepage = 0
        let activepage = system("xdotool getwindowname " . b:MuPDFWindowID . " | sed 's:.* - \\([0-9]*\\)/.*:\\1:' | tr -d '\n'")
        if activepage > 0
            let inputfile = system("synctex edit -o \"" . activepage . ":288:108:" . b:Pdfroot . ".pdf\" | grep 'Input:' | sed 's/Input://' | head -n1 | tr -d '\n' 2>/dev/null")
            if inputfile =~ expand("%")
                let gotoline = 0
                    let gotoline = system("synctex edit -o \"" . activepage . ":288:108:" . b:Pdfroot . ".pdf\" | grep -m1 'Line:' | sed 's/Line://' | head -n1 | tr -d '\n'")
                if gotoline > 0
                    exec ":" . gotoline
                    echo "Went to line " . gotoline
                endif
            else
                echo "Synctex reported an external location - " . inputfile
            endif
        else
            echo "Cannot read MuPDF page number."
        endif
    endif
endfunction 
if !exists("tex_preview_always_autosave")
    let tex_preview_always_autosave = 0
endif
if tex_preview_always_autosave == 1
    function! UpdatePDF()
       if filewritable(bufname("%"))
           silent update
           if b:Pdfviewing == "yes"
                silent! exec "silent! !live-latex-check.sh \"" . b:Rootfile . "\" \"" . expand("%") . "\" " . b:MuPDFWindowID . " &" 
           endif
       endif
    endfunction
else
    function! UpdatePDF()
       if filewritable(bufname("%")) && b:Pdfviewing == "yes"
           silent update
           silent! exec "silent! !live-latex-check.sh \"" . b:Rootfile . "\" \"" . expand("%") . "\" " . b:MuPDFWindowID . " &" 
       endif
    endfunction
endif
" Check status of last compilation
function! CheckLiveUpdateStatus()
    let liveupdatestatus = system("cat " . $HOME . "/.config/live-latex-preview/lastresult")
    if liveupdatestatus =~ "failure"
        let errline = 0
        let errline = system("cat " . b:Pdfroot . ".log | grep \"" . expand("%") . ":\" | head -n1 | cut -d \":\" -f 2")
        let errmessg = system("cat " . b:Pdfroot . ".log | grep \"" .expand("%") . ":\" | head -n1 | sed \"s/[^:]*:[^:]*://\"")
        if errline > 0
            exec ":" . errline
            echohl ErrorMsg | unsilent echo errmessg
        else
            echohl ErrorMsg | unsilent echo "Error (probably in another subdocument)"
        endif
    else
        echohl ErrorMsg | unsilent echo liveupdatestatus
    endif
endfunction
" Keymaps go here
if !exists("no_plugin_maps") && !exists("no_tex_maps")
    " \v to open the viewer
    nnoremap <silent> <buffer> <LocalLeader>p :call LaunchMuPDF()<CR>
    nnoremap <silent> <buffer> <LocalLeader>o :call CloseMuPDF()<CR>
    nnoremap <silent> <buffer> <LocalLeader>s :call CheckLiveUpdateStatus()<CR>
    nnoremap <silent> <buffer> <LocalLeader>f :call MuPDFForward()<CR>
    nnoremap <silent> <buffer> <LocalLeader>r :call MuPDFReverse()<CR>
    nnoremap <silent> <buffer> <LocalLeader>c :exec "silent! !live-latex-update.sh \"" . b:Rootfile . "\" " . b:MuPDFWindowID . " &"<CR>
    nnoremap <silent> <buffer> <LocalLeader><PageDown> :silent! call system("xdotool key --window " . b:MuPDFWindowID . " Page_Down")<CR>
    nnoremap <silent> <buffer> <LocalLeader><PageUp> :silent! call system("xdotool key --window " . b:MuPDFWindowID . " Page_Up")<CR>
    nnoremap <silent> <buffer> <LocalLeader><Up> :silent! call system("xdotool key --window " . b:MuPDFWindowID . " Up")<CR>
    nnoremap <silent> <buffer> <LocalLeader><Down> :silent! call system("xdotool key --window " . b:MuPDFWindowID . " Down")<CR>
    nnoremap <silent> <buffer> <LocalLeader><Left> :silent! call system("xdotool key --window " . b:MuPDFWindowID . " Left")<CR>
    nnoremap <silent> <buffer> <LocalLeader><Right> :silent! call system("xdotool key --window " . b:MuPDFWindowID . " Right")<CR>
    nnoremap <silent> <buffer> <LocalLeader>G :silent! call system("xdotool key --window " . b:MuPDFWindowID . " G")<CR>
    nnoremap <silent> <buffer> <LocalLeader>m :silent! call system("xdotool key --window " . b:MuPDFWindowID . " m")<CR>
    nnoremap <silent> <buffer> <LocalLeader>t :silent! call system("xdotool key --window " . b:MuPDFWindowID . " t")<CR>
    nnoremap <silent> <buffer> <LocalLeader>- :silent! call system("xdotool key --window " . b:MuPDFWindowID . " minus")<CR>
    nnoremap <silent> <buffer> <LocalLeader>+ :silent! call system("xdotool key --window " . b:MuPDFWindowID . " plus")<CR>
    nnoremap <silent> <buffer> <LocalLeader>= :silent! call system("xdotool key --window " . b:MuPDFWindowID . " equal")<CR>
endif
" The autocommands
autocmd CursorMoved *.tex silent call UpdatePDF()
autocmd CursorMovedI *.tex silent call UpdatePDF()
autocmd CursorHold *.tex silent call UpdatePDF()
autocmd CursorHoldI *.tex silent call UpdatePDF()
" Jump to active page when inserting
autocmd InsertEnter *.tex silent call MuPDFForward()
" Welcome message
echohl ErrorMsg | echo "See ':help live-latex-preview' for help with the plugin" 
