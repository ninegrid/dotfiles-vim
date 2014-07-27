so ~/.vimrc
" gvim specific configuation
set guioptions-=m                                                                "remove menu bar
set guioptions-=T                                                                "remove toolbar
set guioptions-=r                                                                "remove right-hand scroll bar
set guioptions-=L                                                                "remove left-hand scroll bar
" Now, bind those widgets to hide/show on CTRL-F1 .. F3 from normal mode
nnoremap <C-F1> :if &go=~#'m'<Bar>set go-=m<Bar>else<Bar>set go+=m<Bar>endif<CR>
nnoremap <C-F2> :if &go=~#'T'<Bar>set go-=T<Bar>else<Bar>set go+=T<Bar>endif<CR>
nnoremap <C-F3> :if &go=~#'r'<Bar>set go-=r<Bar>else<Bar>set go+=r<Bar>endif<CR>

set clipboard+=unnamed                                                           " Yanks go on clipboard instead.
set nomousehide                                                                  " don't hide the mouse
set mouse=a                                                                      " mouse in all modes

set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 7

let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 16
function! AdjustFontSize(amount)
  if has("gui_gtk2") && has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
  else
    echoerr "You need to run the GTK2 version of Vim to use this function."
  endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

nnoremap <C-UP> :LargerFont<CR>
nnoremap <C-Down> :SmallerFont<CR>
