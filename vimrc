" vimrc
" Author:  Daniel Jackson <daniel@thinkhard.net>
" Source:  http://raw.github.com/ninegrid/dotfiles/master/vim/vimrc
" Package: http://github.com/ninegrid/dotfiles.git
" Notes:   Perfecting this has been a lot of work. Thanks to dozens of sources
"          from God knows where!
" Preamble ---------------------------------------------------------------- {{{

filetype off

"   Pathogen -------------------------------------------------------------- {{{

runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
call pathogen#incubate()
call pathogen#helptags()

"   }}}

filetype plugin indent on
set nocompatible

" }}}
" General options --------------------------------------------------------- {{{

set autochdir
        " change working dir to buffer's dir
set autoindent                                                                   " enable auto-indentation
set autoread                                                                     " detect external file changes
set autowrite                                                                    " auto save when buffer loses focus
set backup                                                                       " enable the creation of backup files
set backupdir=~/.vim/tmp/backup//                                                " where backups will go
set backspace=indent,eol,start                                                   " allow backspace over everything
set backupskip="/tmp/*,/private/tmp/*"                                           " make vim able to edit crontab files
set cf                                                                           " enable error files and error jumping
set cindent                                                                      " auto indentation (the complicated one)
set cinoptions=:0,p0,to                                                          " indent options
set cinwords=if,else,while,do,for,switch,case                                    " indent words
set colorcolumn=+1                                                               " color the 81st column
set completeopt=longest,menuone,preview                                          " good completion options
set dictionary=/usr/share/dict/usa                                               " dictonary file
set directory=~/.vim/tmp/swap//                                                  " where temporary files will go
set encoding=utf-8                                                               " everything is utf8
set termencoding=utf-8                                                           " everything is utf8
set expandtab                                                                    " convert tabs to spaces
set fillchars=diff:⣿,vert:│                                                      " diff chars and vertical split chars
set formatoptions=tcqr                                                           " autowrap txt, cmnts, qq cmnts, insert newline leader
set hidden                                                                       " hide buffers instead of closing them
set history=10000                                                                " big enough history
set laststatus=2                                                                 " always show status line
set lazyredraw                                                                   " speed up scrolling
set linebreak                                                                    " wordwrap without line breaks
set list                                                                         " show whitespace as characters
set listchars=tab:⇥\ ,eol:↵,extends:❯,precedes:❮                                 " show all whitespace chars, toggle with: ,l
nmap <leader>l :set list!<CR>
set mat=5                                                                        " bracket blinking
set matchtime=3                                                                  " type () jump back to ( and wait a third of a second
set modelines=0                                                                  " modelines is off
set noerrorbells                                                                 " no noises I'm eff-in busy
set norelativenumber                                                             " i've got enough stuff to think about
set notimeout                                                                    " no timeout on mappings
set nottimeout                                                                   " no timeout for command sequences
set novisualbell                                                                 " no blinking
set number                                                                       " show line numbers
set ruler                                                                        " show ruler in status line (bottom right)
set shell=/usr/bin/bash                                                          " set shell to bash (archlinux)
set shiftround                                                                   " shift quick with >>
set shiftwidth=2                                                                 " shift by two spaces (i like two space indent)
set softtabstop=2                                                                " fill whitespace modulo 2
set showbreak=↪                                                                  " visible line breaks
set showcmd                                                                      " display the command being written in the status line
set showmode                                                                     " display the current editor mode in the status line
set smarttab                                                                     " tab in front of a line honors shiftwidth (2 spaces)
set splitbelow                                                                   " new split buffers go below the current buffer
set splitright                                                                   " new vsplit buffers go to the right of current buffer
set tabstop=2                                                                    " tabs are 2 spaces
set textwidth=80                                                                 " 80 columns of characters
set title                                                                        " put the buffer name in the window title
set ttimeout                                                                     " timeout on key codes
set ttimeoutlen=10                                                               " this makes terminal vim work correctly
set ttyfast                                                                      " make it snappy
set undodir=~/.vim/tmp/undo//                                                    " undos go here
set undofile                                                                     " undo file is on
set undoreload=10000                                                             " reload 10,000 undos
set viminfo^=!                                                                   " see http://vimdoc.sourceforge.net/htmldoc/options.html#%27viminfo%27
set visualbell                                                                   " no sound, but ping visually in the status line
set wrap                                                                         " word wrap without line breaks
augroup general_options
  au!
  au FocusLost * :silent! wall                                                   " auto save when losing focus
  au VimResized * :wincmd =                                                      " resize splits on window resize
augroup end

" }}}
" Aesthetics -------------------------------------------------------------- {{{

"   (g)vimrc auto source -------------------------------------------------- {{{

" source the vimrc and gvimrc when it is saved
if has ("autocmd")
  filetype plugin indent on
  autocmd bufwritepost .vimrc source $MYVIMRC
  autocmd bufwritepost .gvimrc source $MYGVIMRC
  autocmd bufwritepost vimrc source $MYVIMRC
  autocmd bufwritepost gvimrc source $MYGVIMRC
endif

"   }}}
"   Calculator ------------------------------------------------------------- {{{

inoremap <C-B> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

"   }}}
"   Color theme ----------------------------------------------------------- {{{

syntax on
set background=light
let g:zenburn_high_Contrast=1
colorscheme solarized
highlight ColorColumn ctermbg=7
" reload colorscheme whenever we write the buffer

"   Cursor colors --------------------------------------------------------- {{{

"   }}}

augroup reloadcolorscheme
  au!
  au BufWritePost solarized.vim color solarized
augroup END

"   }}}
"   Cursor Line ----------------------------------------------------------- {{{

" only show the cursorline in normal mode and in the current window
augroup cline
  au!
  au InsertEnter * set nocursorline
  au InsertLeave * set cursorline
  au WinLeave * set nocursorline
  au WinEnter * set cursorline
augroup END

"   }}}
"   Fonts ----------------------------------------------------------------- {{{

"   }}}
"   Line return ----------------------------------------------------------- {{{

" vim can return to the same line when you reopen a file
augroup remember_line_position
  au!
  au BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   execute 'normal! g`"zvzz' |
    \ endif
augroup END

"   }}}
"   Set coptions+=J ------------------------------------------------------- {{{

" this will occasionally break because of some conflict
augroup twospace
  au!
  au BufRead * :set cpoptions+=J
augroup END

"   }}}
"   Trailing whitespace --------------------------------------------------- {{{

" I only want to show it when I'm not in INSERT mode
augroup trailing
  au!
  au InsertEnter * :set listchars-=trail:⌴
  au InsertLeave * :set listchars+=trail:⌴
augroup END

"   }}}
"   VCS ------------------------------------------------------------------- {{{

match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

"   }}}
" }}}
" Folding ----------------------------------------------------------------- {{{

set foldlevelstart=0
nnoremap <space> za
vnoremap <space> za
" z0 recursively opens top level fold, wherever the cursor may be
noremap z0 zCz0
nnoremap <leader>z zMzvzz
function! MyFoldText() " {{{
  let line = getline(v:foldstart)
  let nucolwidth = &fdc + &number * &numberwidth
  let windowwidth = winwidth(0) - nucolwidth - 3
  let foldedlinecount = v:foldend - v:foldstart
  " expand tabs to spaces
  let onetab = strpart('          ', 0, &tabstop)
  let line = substitute(line, '\t', onetab, 'g')
  let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
  let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
  return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()
augroup folding_options
  au!
  au BufWinLeave * silent! mkview
  au BufWinEnter * silent! loadview
augroup end

" }}}
" Abbreviations ----------------------------------------------------------- {{{

function! EatChar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunction
function! MakeSpacelessIabbrev(from, to)
  execute "iabbrev <silent>".a:from." ".a:to."<c-R>=EatChar('\\s')<cr>"
endfunction
" some examples:
" call MakeSpacelessIabbrev('th/',   'http://www.thinkhard.net')
" call MakeSpacelessIabbrev('thb/',  'http://blog.thinkhard.net')
" call MakeSpacelessIabbrev('thm/',  'http://mail.thinkhard.net')
" call MakeSpacelessIabbrev('bb/',   'http://bitbucket.org')
" call MakeSpacelessIabbrev('thbb/', 'http://bitbucket.org/thinkhard/')
" call MakeSpacelessIabbrev('gh/',   'http://github.com')
" call MakeSpacelessIabbrev('ghth/', 'http://github.com/thinkhard')
iabbrev th@ daniel@thinkhard.net
iabbrev p@  daniel.jackson@promitheia.net
iabbrev vrcf `~/.vimrc` file

" }}}
" Mappings ---------------------------------------------------------------- {{{
"   Greek ----------------------------------------------------------------- {{{

" make fancy chars from insert mode
" α alpha
inoremap <c-l>a <c-k>a*
" Α Alpha
inoremap <c-l>A <c-k>A*
" β beta
inoremap <c-l>b <c-k>b*
" Β Beta
inoremap <c-l>B <c-k>B*
" γ gamma
inoremap <c-l>g <c-k>g*
" Γ Gamma
inoremap <c-l>G <c-k>G*
" δ delta
inoremap <c-l>d <c-k>d*
" Δ Delta
inoremap <c-l>D <c-k>D*
" ε epsilon
inoremap <c-l>e <c-k>e*
" Ε Epsilon
inoremap <c-l>E <c-k>E*
" ζ zeta
inoremap <c-l>z <c-k>z*
" Ζ Zeta 
inoremap <c-l>Z <c-k>Z*
"   eta
inoremap <c-l>y <c-k>y*
"   Eta
inoremap <c-l>Y <c-k>Y*
" Θ theta
inoremap <c-l>h <c-k>H*
" θ Theta
inoremap <c-l>H <c-k>h*
"   iota
inoremap <c-l>i <c-k>i*
"   Iota
inoremap <c-l>I <c-k>I*
" λ lambda
inoremap <c-l>l <c-k>l*
" Λ Lambda
inoremap <c-l>L <c-k>L*
" μ mu
inoremap <c-l>m <c-k>m*
" Μ Mu
inoremap <c-l>M <c-k>M*
" ν nu
inoremap <c-l>n <c-k>n*
" Ν Nu
inoremap <c-l>N <c-k>N*
" ξ xi
inoremap <c-l>c <c-k>c*
" Ξ Xi
inoremap <c-l>C <c-k>C*
" ο omicron
inoremap <c-l>o <c-k>o*
" Ο Omicron
inoremap <c-l>O <c-k>O*
" π pi
inoremap <c-l>p <c-k>p*
" Π Pi
inoremap <c-l>P <c-k>P*
" ρ rho
inoremap <c-l>r <c-k>r*
" Ρ Rho
inoremap <c-l>R <c-k>R*
" σ sigma
inoremap <c-l>s <c-k>s*
" Σ Sigma
inoremap <c-l>S <c-k>S*
" τ tau
inoremap <c-l>t <c-k>t*
" Τ Tau
inoremap <c-l>T <c-k>T*
" υ upsilon
inoremap <c-l>u <c-k>u*
" Υ Upsilon
inoremap <c-l>U <c-k>U*
" φ phi
inoremap <c-l>f <c-k>f*
" Φ Phi
inoremap <c-l>F <c-k>F*
" χ chi
inoremap <c-l>x <c-k>x*
" Χ Chi
inoremap <c-l>X <c-k>X*
" ψ phi
inoremap <c-l>q <c-k>q*
" Ψ Phi
inoremap <c-l>Q <c-k>Q*
" ω omega
inoremap <c-l>w <c-k>w*
" Ω Omega
inoremap <c-l>W <c-k>W*

"   }}}
"   Leader ---------------------------------------------------------------- {{{
let mapleader = ","
let maplocalleader = ";"
imap <c-right> <esc>ei
imap <c-left>  <esc>bi
"   }}}
"   Searching ------------------------------------------------------------- {{{

" very magic regex in normal mode
nnoremap / /\V
" very magic regex in visual mode
vnoremap / /\V
set gdefault
set hlsearch
set ignorecase
set incsearch
set showmatch
noremap <leader><space> :noh<cr>:call clearmatches()<cr>
" keep the hash key working correctly
inoremap # X<bs>#
" Highlight Group(s)
nnoremap <f8> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                        \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
" open a QuickFix window for the last search
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>
" Ack for the last search:
nnoremap <silent> <leader>? :execute "Ack! '" . substitute(substitute(substitute(@/, "\\\\<", "\\\\b", ""), "\\\\>", "\\\\b", ""), "\\\\v", "", "") . "'"<CR>
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *<c-o>
set smartcase
nnoremap <silent> <leader>h1 :execute 'match InterestingWord1 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h2 :execute '2match InterestingWord2 /\<<c-r><c-w>\>/'<cr>
nnoremap <silent> <leader>h3 :execute '3match InterestingWord3 /\<<c-r><c-w>\>/'<cr>

"   }}}
"   Movement and selection ------------------------------------------------ {{{

set scrolloff=3
set sidescroll=1
set sidescrolloff=10
map <tab> %
noremap H ^
noremap L g_
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A
" select entire buffer
nnoremap vaa ggvGg_
nnoremap Vaa ggVG
" easy linewise reselection
nnoremap <leader>V V`]
" select conetents of a line excluding leading whitespace
nnoremap vv ^vg_
" gi moves to last place insert mode was exited, this will move to last change
nnoremap gI `.
" list navigation
nnoremap <left> :cprev<cr>zvzz
nnoremap <right> :cnext<cr>zvzz
nnoremap <up> :lprev<cr>zvzz
nnoremap <down> :lnext<cr>zvzz
" toggle keeping the current line in the center of the screen
nnoremap <leader>Z :let &scrolloff=999-&scrolloff<cr>
" emacs bindings in commandline mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>
nnoremap g; g;zz
nnoremap g, g,zz

"   }}}
"   Editing --------------------------------------------------------------- {{{

" cursor can be positioned where there is no actual char in Visual block mode.
set virtualedit+=block
" clean trailing whitespaces on current line
nnoremap <leader>w mz:s/\s\+$//<cr>:let @/=''<cr>`z
" clean trailing whitespaces on all lines
nnoremap <leader>W mz:%s/\s\+$//<cr>:let @/=''<cr>`z
" sudo to write
cnoremap w!! w !sudo tee % >/dev/null
" drag lines in any mode
noremap <c-Down> :m+<cr>
noremap <c-Up> :m-2<cr>
inoremap <c-Down> <esc>:m+<cr>
inoremap <c-Up> <esc>:m-2<cr>
vnoremap <c-Down> :m'>+<cr>gv
vnoremap <c-Up> :m-2<cr>gv
" change case
nnoremap <c-u> gUiw
inoremap <c-u> <esc>gUiwea
" diffoff
nnoremap <leader>D :diffoff!<cr>
" texmate formatting
nnoremap Q ggip
vnoremap Q gq
" keep cursor in place when joining lines
nnoremap J mzJ`z
" split line (cojoin), the normal use of S is covered by cc
nnoremap S i<cr><esc>^mwgk:silent! s /\v +$//<cr>:noh<cr>`w
" increment number under cursor
nnoremap + <c-a>
" decrement number under cursor
nnoremap - <c-x>
" align text
nnoremap <leader>Al :left<cr>
nnoremap <leader>Ac :center<cr>
nnoremap <leader>Ar :right<cr>
vnoremap <leader>Al :left<cr>
vnoremap <leader>Ac :center<cr>
vnoremap <leader>Ar :right<cr>
" easy delete to end of line
nnoremap D d$A
" Quickreturn
inoremap <c-cr> <esc>A<cr>
" TODO make this filetype-specific
inoremap <s-cr> <esc>A:<cr>
" insert mode completion
inoremap <c-l> <c-x><c-l>
" insert filename completion
inoremap <c-f> <c-x><c-f>

"   }}}
"   Windows and Buffers --------------------------------------------------- {{{

"kill window
noremap K :q<cr>
" force screen redaw
nnoremap <leader>u :syntax sync fromstart<cr>:redraw!<cr>:AirlineTheme solarized<cr>
" clipboard interaction
noremap <leader>y "*y
noremap <leader>p :set paste<cr>"*p<cr>:set nopaste<CR>
noremap <leader>P :set paste<cr>"*P<cr>:set nopaste<CR>
" override the help key to something useful
noremap  <f1> :set invfullscreen<cr>
inoremap <f1> <esc>:set invfullscreen<cr>a
" for some reason ctags refuses to ignore python variables so i'll just hack
" the tags file with sed and strip them out myself
nnoremap <leader><cr> :silent !/usr/local/bin/ctags -R . && sed -i .bak -E -e '/^[^	]+	[^	]+.py	.+v$/d' tags<cr>:redraw!<cr>
" gist requires gist commandline tool
" what about gist.vim?
" insert directory of current buffer in command line mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" switch cmdheight
nnoremap <leader>1 :set cmdheight=1<cr>
nnoremap <leader>2 :set cmdheight=2<cr>
" nnoremap <c-left> 5<c-w>>
" nnoremap <c-right> 5<c-w><

"   }}}
" }}}
" Edit rc files quickly --------------------------------------------------- {{{

nnoremap <leader>vim <C-w>s<C-w>j<C-w>L:e ~/.files/vim/vimrc<cr>
nnoremap <leader>gvim <C-w>s<C-w>j<C-w>L:e ~/.files/vim/gvimrc<cr>
" source current line for quick hacking vimrc
nnoremap <leader>S ^vg_y:execute @@<cr>
" source current visual selection
vnoremap <leader>S y:execute @@<cr>

nnoremap <leader>es <C-w>s<C-w>j<C-w>L:e ~/.files/vim/snippets/<cr>
nnoremap <leader>eg <C-w>s<C-w>j<C-w>L:e ~/.files/gitconfig<cr>
nnoremap <leader>em <C-w>s<C-w>j<C-w>L:e ~/.files/mutt/muttrc<cr>
nnoremap <leader>ei <C-w>s<C-w>j<C-w>L:e ~/.files/irssi/config<cr>
nnoremap <leader>eb <C-w>s<C-w>j<C-w>L:e ~/.files/bashrc<cr>
nnoremap <leader>ep <C-w>s<C-w>j<C-w>L:e ~/.files/bash_profile<cr>
nnoremap <leader>ex <C-w>s<C-w>j<C-w>L:e ~/.files/xmonad/xmonad.hs<cr>

" }}}
" CTags ------------------------------------------------------------------- {{{

" }}}
" Completion -------------------------------------------------------------- {{{

set completeopt+=longest,menu,preview
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" }}}
" Filetype-specific ------------------------------------------------------- {{{
"   Filetype switching ---------------------------------------------------- {{{

nnoremap _md :set ft=markdown<cr>
nnoremap _hd :set ft=htmldjango<cr>
nnoremap _jt :set ft=htmljinja<cr>
nnoremap _js :set ft=javascript<cr>
nnoremap _co :set ft=coffee<cr>
nnoremap _cw :set ft=confluencewiki<cr>
nnoremap _pd :set ft=python.django<cr>
nnoremap _d  :set ft=diff<cr>
nnoremap _fs :set ft=fsharp<cr>
nnoremap _hs :set ft=haskell<cr>
nnoremap _lhs:set ft=lhaskell<cr>
nnoremap _oc :set ft=ocaml<cr>
nnoremap _tex:set ft=plaintex<cr>

"   }}}
"   C --------------------------------------------------------------------- {{{
augroup ft_c
  au!
  au FileType c setlocal foldmethod=syntax
augroup end
"   }}}
"   Clojure --------------------------------------------------------------- {{{
let g:slimv_leader = '\'
let g:slimv_keybindings = 2
augroup ft_clojure
  au!
  au FileType clojure call TurnOnClojureFolding()
  au FileType clojure compiler clojure
  au FileType clojure setlocal report=100000
  au BufWinEnter SLIMY.REPL setlocal nolist
  au BufNewFile,BufReadPost SLIMV.REPL setlocal nowrap foldlevel=99
  au BufNewFile,BufReadPost SLIMV.REPL nnoremap <buffer> A GA
  au BufNewFile,BufReadPost SLIMV.REPL nnoremap <buffer> <localleader>R :emenu REPL.<Tab>
  " Fix the eval mappings.
  au FileType clojure nnoremap <buffer> <localleader>ef :<c-u>call SlimvEvalExp()<cr>
  au FileType clojure nnoremap <buffer> <localleader>ee :<c-u>call SlimvEvalDefun()<cr>
  " And the inspect mapping.
  au FileType clojure nmap <buffer> \i \di
  " Indent top-level form.
  au FileType clojure nmap <buffer> <localleader>= v((((((((((((=%
augroup end
"   }}}
"   Clojurescript --------------------------------------------------------- {{{
augroup ft_clojurescript
  au!
  au BufNewFile,BufRead *.cljs set filetype=clojurescript
  au FileType clojurescript call TurnOnClojureFolding()
  " indent top-level form.
  au FileType clojurescript nmap <buffer> <localleader>= v((((((((((((=%
augroup END
"   }}}
"   Coco ------------------------------------------------------------------ {{{
augroup ft_coco
  au!
augroup end
"   }}}
"   Coffee-script --------------------------------------------------------- {{{
augroup ft_coffeescript
  au!
augroup end
"   }}}
"   CSS and LessCSS ------------------------------------------------------- {{{
augroup ft_css
  au!
  au BufNewFile,BufRead *.less setlocal filetype=less
  au Filetype less,css setlocal foldmethod=marker
  au Filetype less,css setlocal foldmarker={,}
  au Filetype less,css setlocal omnifunc=csscomplete#CompleteCSS
  au Filetype less,css setlocal iskeyword+=-
  " Use <leader>S to sort properties.  Turns this:
  "     p {
  "         width: 200px;
  "         height: 100px;
  "         background: red;
  "
  "         ...
  "     }
  "
  " into this:
  "     p {
  "         background: red;
  "         height: 100px;
  "         width: 200px;
  "
  "         ...
  "     }
  au BufNewFile,BufRead *.less,*.css nnoremap <buffer> <localleader>S ?{<cr>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>
  " Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
  " positioned inside of them AND the following code doesn't get unfolded.
  au BufNewFile,BufRead *.less,*.css inoremap <buffer> {<cr> {}<left><cr><space><space><space><space>.<cr><esc>kA<bs>
augroup END
"   }}}
"   HTML ------------------------------------------------------------------ {{{
augroup ft_html
  au!
  au FileType html setlocal ts=2 sts=2 sw=2 expandtab
augroup END
inoremap <C-_> <Space><BS><ESC>:call InsertCloseTag()<cr>a
"   }}}
"   Haskell --------------------------------------------------------------- {{{
augroup ft_haskell
  au!
  au BufNewFile,BufRead *.ghs setf haskell
  au BufEnter *.hs compiler ghc
  au BufEnter *.lhs compiler ghc
augroup END
"   }}}
"   Java ------------------------------------------------------------------ {{{
augroup ft_java
  au!
  au FileType java setlocal foldmethod=marker
  au FileType java setlocal foldmarker={,}
augroup END
"   }}}
"   Javascript ------------------------------------------------------------ {{{
augroup ft_javascript
  au!
  au FileType javascript setlocal foldmethod=marker
  au FileType javascript setlocal foldmarker={,}
  au Filetype javascript inoremap <buffer> {<cr> {}<left><cr><space><space>.<cr><esc>kA<bs>
augroup END
"   }}}
"   Lisp ------------------------------------------------------------------ {{{
let g:lisp_rainbow = 1

augroup ft_lisp
  au!
  au FileType lisp call TurnOnLispFolding()
augroup END
"   }}}
"   LiveScript ------------------------------------------------------------ {{{
augroup ft_livescript
  au!
augroup end
"   }}}
"   Markdown -------------------------------------------------------------- {{{
augroup ft_markdown
  au!
  au BufNewFile,BufRead *.m*down setlocal filetype=markdown
  " Use <localleader>1/2/3 to add headings.
  au Filetype markdown nnoremap <buffer> <localleader>1 yypVr=
  au Filetype markdown nnoremap <buffer> <localleader>2 yypVr-
  au Filetype markdown nnoremap <buffer> <localleader>3 I### <ESC>
augroup END
"   }}}
"   Nginx ----------------------------------------------------------------- {{{
augroup ft_nginx
  au!
  au BufRead,BufNewFile /etc/nginx/conf/*                      set ft=nginx
  au BufRead,BufNewFile /etc/nginx/sites-available/*           set ft=nginx
  au BufRead,BufNewFile /usr/local/etc/nginx/sites-available/* set ft=nginx
  au BufRead,BufNewFile vhost.nginx                            set ft=nginx
  au FileType nginx setlocal foldmethod=marker foldmarker={,}
augroup END
"   }}}
"   NoFlo Testing FBP Syntax----------------------------------------------- {{{
" augroup ft_noflo
"   au!
"   au BufRead,BufNewFile *.fbp set filetype=fbp
"   au! Syntax fbp source '$HOME/work/vim-noflo/syntax/fbp.vim'
"   autocmd BufRead,BufNewFile *.example set filetype=example
"   au! Syntax example source '~/work/vim-noflo/syntax/example.vim'
" augroup end
"   }}}
"   Python ---------------------------------------------------------------- {{{
augroup ft_python
  au!
  " au FileType python setlocal omnifunc=pythoncomplete#Complete
  au FileType python setlocal define=^\s*\\(def\\\\|class\\)
  au FileType python compiler nose
  au FileType man nnoremap <buffer> <cr> :q<cr>
  au FileType python if exists("python_space_error_highlight") | unlet python_space_error_highlight | endif
  au FileType python inoremap <buffer> <c-g> _(u'')<left><left>
  au FileType python inoremap <buffer> <c-b> """"""<left><left><left>
augroup END
"   }}}
"   QuickFix -------------------------------------------------------------- {{{
augroup ft_quickfix
  au!
  au Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap tw=0
augroup END
"   }}}
"   Ruby ------------------------------------------------------------------ {{{

augroup ft_ruby
  au!
  au Filetype ruby,eruby set nocompatible
  au Filetype ruby,eruby syntax on
  au Filetype ruby,eruby filetype on
  au Filetype ruby,eruby filetype plugin indent on
  au Filetype ruby,eruby setlocal foldmethod=syntax
  au Filetype ruby,eruby set expandtab
  au Filetype ruby,eruby set tabstop=2 shiftwidth=2 softtabstop=2
  au Filetype ruby,eruby set autoindent
  au Filetype ruby set omnifunc=rubycomplete#Complete
  au Filetype ruby,eruby let g:rubycomplete_classes_in_global = 1
  au Filetype ruby,eruby let g:rubycomplete_buffer_loading = 1
  au Filetype ruby,eruby let g:rubycomplete_rails = 1
  au Filetype ruby,eruby imap <buffer> <CR> <C-R>=RubyEndToken()<CR>
  " au BufEnter * Rvm
augroup END

if !exists( "*RubyEndToken" )

  function RubyEndToken()
    let current_line = getline( '.' )
    let braces_at_end = '{\s*|\(,\|\s\|\w*|\s*\)\?$'
    let stuff_without_do = '^\s*class\|if\|unless\|begin\|case\|for\|module\|while\|until\|def'
      let with_do = 'do\s*|\(,\|\s\|\w*|\s*\)\?$'

      if match(current_line, braces_at_end) >= 0
        return "\<CR>}\<C-O>O"
      elseif match(current_line, stuff_without_do) >= 0
        return "\<CR>end\<C-O>O"
      elseif match(current_line, with_do) >= 0
        return "\<CR>end\<C-O>O"
      else
        return "\<CR>"
      endif
    endfunction

endif

"   }}}
"   LaTeX ----------------------------------------------------------------- {{{
augroup ft_plaintex
  au!
  au FileType plaintex setlocal filetype plugin on
  set grepprg=grep\ -nH\ $*
  let g:tex_flavor='latex'
  set sw=2
  set iskeyword+=:
augroup END
"   }}}
"   Vim ------------------------------------------------------------------- {{{
augroup ft_vim
  au!
  au FileType vim setlocal foldmethod=marker
  au FileType help setlocal textwidth=78
  au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END
"   }}}
"   Xml files ------------------------------------------------------------- {{{
augroup ft_xml
  au!
  au FileType xml setlocal foldmethod=syntax ts=2 sts=2 sw=2 expandtab
  au BufNewFile,BufRead *.rss,*.atom setfiletype xml
augroup END
"   }}}
" }}}
" Plugin settings --------------------------------------------------------- {{{
"   Ack ------------------------------------------------------------------- {{{
"   }}}
"   Airline --------------------------------------------------------------- {{{
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 1
let g:airline_theme='solarized'
"   }}}
"   Coco ------------------------------------------------------------------ {{{
augroup plugin_coco
  au!
  au BufWritePost *.co silent CocoMake! -b | cwindow | redraw!
  au BufNewFile,BufReadPost *.co setl foldmethod=indent
  au BufNewFile,BufReadPost *.co setl shiftwidth=2 expandtab
  au FileType co nmap <buffer> <localleader>w :<c-u>CocoCompile watch<CR>
  au FileType co nmap <buffer> <localleader>r :<c-u>CocoRun<CR>
  au FileType co set dictionary+=~/.files/vim/bundle/vim-node-dict/dict/node.dict
augroup end
"   }}}
"   Coffee-script --------------------------------------------------------- {{{
augroup plugin_coffeescript
  au!
  au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!
  au BufNewFile,BufReadPost *.coffee setl foldmethod=indent
  au BufNewFile,BufReadPost *.coffee setl shiftwidth=2 expandtab
  au FileType coffee nmap <buffer> <localleader>w :<c-u>CoffeeCompile watch<CR>
  au FileType coffee nmap <buffer> <localleader>r :<c-u>CoffeeRun<CR>
  au FileType coffee set dictionary+=~/.files/vim/bundle/vim-node-dict/dict/node.dict
augroup end
"   }}}
"   Commentary ------------------------------------------------------------ {{{
nmap <leader>c <Plug>CommentaryLine
xmap <leader>c <Plug>Commentary
augroup plugin_commentary
  au!
  au FileType clojurescript setlocal commentstring=;\ %s
  au FileType fsharp setlocal commentstring={(*\ %s\ *)}
  au FileType htmldjango setlocal commentstring={#\ %s\ #}
augroup END
"   }}}
"   Ctrl-P ---------------------------------------------------------------- {{{
let g:ctrlp_dont_split = 'NERD_tree_2'
let g:ctrlp_jump_to_buffer = 0
let g:ctrlp_map = '<leader>,'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 1
let g:ctrlp_split_window = 0
let g:ctrlp_max_height = 20
let g:ctrlp_extensions = ['tag']
let g:ctrlp_prompt_mappings = {
\ 'PrtSelectMove("j")':   ['<c-j>', '<down>', '<s-tab>'],
\ 'PrtSelectMove("k")':   ['<c-k>', '<up>', '<tab>'],
\ 'PrtHistory(-1)':       ['<c-n>'],
\ 'PrtHistory(1)':        ['<c-p>'],
\ 'ToggleFocus()':        ['<c-tab>'],
\ }
let ctrlp_filter_greps = "".
  \ "egrep -iv '\\.(" .
  \ "jar|class|swp|swo|log|so|o|pyc|jpe?g|png|gif|mo|po" .
  \ ")$' | " .
  \ "egrep -v '^(\\./)?(" .
  \ "deploy/|lib/|classes/|libs/|deploy/vendor/|.git/|.hg/|.svn/|.*migrations/" .
  \ ")'"
let my_ctrlp_user_command = "" .
  \ "find %s '(' -type f -or -type l ')' -maxdepth 15 -not -path '*/\\.*/*' | " .
  \ ctrlp_filter_greps
let my_ctrlp_git_command = "" .
  \ "cd %s && git ls-files | " .
  \ ctrlp_filter_greps
let g:ctrlp_user_command = ['.git/', my_ctrlp_git_command, my_ctrlp_user_command]
nnoremap <leader>. :CtrlPTag<cr>
"   }}}
"   Easymotion ------------------------------------------------------------ {{{
let g:EasyMotion_do_mapping = 0
nnoremap <silent> <Leader>f      :call EasyMotion#F(0, 0)<cr>
onoremap <silent> <Leader>f      :call EasyMotion#F(0, 0)<cr>
vnoremap <silent> <Leader>f :<c-U>call EasyMotion#F(1, 0)<cr>
nnoremap <silent> <Leader>F      :call EasyMotion#F(0, 1)<cr>
onoremap <silent> <Leader>F      :call EasyMotion#F(0, 1)<cr>
vnoremap <silent> <Leader>F :<c-U>call EasyMotion#F(1, 1)<cr>
onoremap <silent> <Leader>t      :call EasyMotion#T(0, 0)<cr>
onoremap <silent> <Leader>T      :call EasyMotion#T(0, 1)<cr>
"   }}}
"   Fugitive -------------------------------------------------------------- {{{
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>ga :Gadd<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gco :Gcheckout<cr>
nnoremap <leader>gci :Gcommit<cr>
nnoremap <leader>gm :Gmove<cr>
nnoremap <leader>gr :Gremove<cr>
nnoremap <leader>gl :Shell git gl -18<cr>:wincmd \|<cr>
augroup ft_fugitive
  au!
  au BufNewFile,BufRead .git/index setlocal nolist
augroup END
" GistHub
nnoremap <leader>H :Gbrowse<cr>
vnoremap <leader>H :Gbrowse<cr>
"   }}}
"   Gundo ----------------------------------------------------------------- {{{
nnoremap <F5> :GundoToggle<CR>
let g:gundo_debug = 1
let g:gundo_preview_bottom = 1
let g:gundo_tree_statusline = "Gundo"
let g:gundo_preview_statusline = "Gundo Preview"
"   }}}
"   Haskellmode ----------------------------------------------------------- {{{
let g:haddock_browser = "w3m"
let g:haddock_browser_callformat = "%s %s"
let g:ghc = "/usr/local/bin/ghc"
"   }}}
"   Hoogle ---------------------------------------------------------------- {{{
let g:hoogle_search_count=15
let g:hoogle_search_buf_name='Hoogle'
"   }}}
"   HTML5 ----------------------------------------------------------------- {{{
let g:event_handler_attributes_complete = 0
let g:rdfa_attributes_complete = 0
let g:microdata_attributes_complete = 0
let g:atia_attributes_complete = 0
"   }}}
"   Jade ------------------------------------------------------------------ {{{

"   }}}
"   Linediff -------------------------------------------------------------- {{{
vnoremap <leader>l :Linediff<cr>
nnoremap <leader>L :LinediffReset<cr>
"   }}}
"   LiveScript ------------------------------------------------------------ {{{
augroup plugin_livescript
  au!
  au BufWritePost *.ls silent LiveScriptMake! -b | cwindow | redraw!
  au BufNewFile,BufReadPost *.ls setl foldmethod=indent
  au BufNewFile,BufReadPost *.ls setl shiftwidth=2 expandtab
  au FileType ls nmap <buffer> <localleader>w :<c-u>LiveScriptCompile watch<CR>
  au FileType ls nmap <buffer> <localleader>r :<c-u>LiveScriptRun<CR>
  au FileType ls set dictionary+=~/.files/vim/bundle/vim-node-dict/dict/node.dict
augroup end
"   }}}
"   Makegreen ------------------------------------------------------------- {{{
nnoremap \| :call MakeGreen('')<cr>
"   }}}
"   Matchit --------------------------------------------------------------- {{{

"   }}}
"   Mustache -------------------------------------------------------------- {{{

"   }}}
"   Neocomplete ----------------------------------------------------------- {{{
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplcache_auto_completion_start_length = 3
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_enable_quick_match = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplete#data_directory='~/.files/vim/tmp/neocomplete'
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" define dictionary
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : '',
    \ 'c' : '~/.files/vim/bundle/vim-dicts/c.dict',
    \ 'cpp' : '~/.files/vim/bundle/vim-dicts/cpp.dict',
    \ 'coffee' : '~/.files/vim/bundle/vim-node-dict/dict/node.dict',
    \ 'haskell' : '~/.files/vim/bundle/vim-dicts/haskell.dict',
    \ 'java' : '~/.files/vim/bundle/vim-dicts/java.dict',
    \ 'javascript' : '~/.files/vim/bundle/vim-dicts/javascript.dict',
    \ 'ocaml' : '~/.files/vim/bundle/vim-dicts/ocaml.dict',
    \ 'perl' : '~/.files/vim/bundle/vim-dicts/perl.dict',
    \ 'php' : '~/.files/vim/bundle/vim-dicts/php.dict',
\}

" plugin key mappings
inoremap <expr><C-g> neocomplete#undo_completion()
inoremap <expr><C-l> neocomplete#complete_common_string()

" recommended key mappings
" <CR>: close popup and save indent
inoremap <silent> <CR> <C-r>=<SID>neo_cr_function()<CR>
function! s:neo_cr_function()
  return neocomplete#smart_close_popup() . "\<CR>"
  " for no inserting <CR> key
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backward char
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplete#close_popup()
inoremap <expr><C-e> neocomplete#cancel_popup()

" AutoComplPop like behavior.
let g:neocomplete#enable_auto_select = 1

" Enable omni completion.
augroup plugin_neocomplete
  au!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
  au BufWritePost * NeoCompleteBufferMakeCache
augroup end

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif

let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
" let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
"   }}}
"   NERDTree -------------------------------------------------------------- {{{
noremap <f2> :NERDTreeToggle<cr>
inoremap <f2> <esc>:NERDTreeToggle<cr>
augroup ps_nerdtree
  au!
  au Filetype nerdtree setlocal nolist
  au Filetype nerdtree nnoremap <buffer> K :q<cr>
augroup end
let NERDTreeHighlightCursorLine=1
let NERDTreeIgnore = ['\~$', '.*\.pyc$', 'pip-log\.txt$', 'whoosh_index',
                    \ 'xapian_index', '.*.pid', 'monitor.py', '.*-fixtures-.*.json',
                    \ '.*\.o$', 'db.db', 'tags.bak']
let NERDTreeMinimalUI=1
let NERDChristmasTree=1
let NERDTreeShowLineNumbers=1
let NERDTreeDirArrows=1
let NERDTreeShowHidden=1
"   }}}
"   Node ------------------------------------------------------------------ {{{

"   }}}
"   Nose ------------------------------------------------------------------ {{{

"   }}}
"   OrgMode --------------------------------------------------------------- {{{
let g:org_plugins = ['ShowHide', '|', 'Navigator', 'EditStructure', '|', 'Todo', 'Date', 'Misc']
let g:org_todo_keywords = ['TODO', '|', 'DONE']
let g:org_debug = 1
"   }}}
"   Python-mode ----------------------------------------------------------- {{{

"   }}}
"   Rails ----------------------------------------------------------------- {{{

"   }}}
"   Rake ------------------------------------------------------------------ {{{

"   }}}
"   Ri -------------------------------------------------------------------- {{{

"   }}}
"   Ruby ------------------------------------------------------------------ {{{

"   }}}
"   Rvm ------------------------------------------------------------------- {{{
"   }}}
"   Stylus ---------------------------------------------------------------- {{{

"   }}}
"   Supertab -------------------------------------------------------------- {{{

"   }}}
"   Syntastic ------------------------------------------------------------- {{{
augroup plugin_syntastic
  au BufWritePost *.coffee silent SyntasticCheck
augroup end
"   }}}
"   Tabular --------------------------------------------------------------- {{{

"   }}}
"   VimIRC ---------------------------------------------------------------- {{{
let g:vimirc_nick = "ninegrid"
let g:vimirc_user = "ninegrid"
let g:vimirc_realname = "ninegrid"
let g:vimirc_server = "irc.sucks.net:6667"
let g:vimirc_autojoin = "#reboot"
let g:vimirc_browser = "w3m"
"   }}}
"   w3m ------------------------------------------------------------------- {{{
let g:w3m#command = "w3m"
"   }}}
"   wildmenu -------------------------------------------------------------- {{{
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                                                    " version control
set wildignore+=*.aux,*.out,*.toc                                                " LaTeX intermediates
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg                                   " images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest                                 " object files
set wildignore+=*.spl                                                            " compiled spell files
set wildignore+=*.sw?                                                            " vim swap files
set wildignore+=*.luac,*.pyc                                                     " byte code
set wildignore+=migrations                                                       " django migrations
set wildignore+=*.orig                                                           " merge resolution files
" }}}
" }}}
" Text objects ------------------------------------------------------------ {{{
"   Fix linewise visual selection ----------------------------------------- {{{

nnoremap VV V
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

"   }}}
"   Shortcut for [] ------------------------------------------------------- {{{

onoremap ir i[
onoremap ar a[
vnoremap ir i[
vnoremap ar a[

"   }}}
"   Next and Last --------------------------------------------------------- {{{

onoremap an :<c-u>call <SID>NextTextObject('a','f')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a','f')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i','f')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i','f')<cr>
onoremap al :<c-u>call <SID>NextTextObject('a','F')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a','F')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i','F')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i','F')<cr>
function! s:NextTextObject(motion, dir)
  let c = nr2char(getchar())
  if c ==# "b"
    let c = "("
  elseif c ==# "B"
    let c = "{"
  elseif c ==# "r"
    let c = "["
  exe "normal!" ".a:dir.c."v".a:motion.c
endfunction

"   }}}
"   Numerics -------------------------------------------------------------- {{{

function! s:NumberTextObject(whole)
  normal! v
  while getline('.')[col('.')] =~# '\v[0-9]'
    normal! l
  endwhile
  if a:whole
    normal! o
    while col('.') > 1 && getline('.')[col('.') - 2] =~# '\v[0-9]'
      normal! h
    endwhile
  endif
endfunction
" Motion for numbers.  Great for CSS.  Lets you do things like this:
" margin-top: 200px; -> daN -> margin-top: px;
" TODO: Handle floats.
onoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
xnoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
onoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
onoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>

"   }}}
"   Ack motions ----------------------------------------------------------- {{{

" Motions to Ack for things. Works with pretty much everything, including:
"
" w, W, e, E, b, B, t*, f*, i*, a*, and custom text objects
"
" Awesome.
"
" Note: If the text covered by a motion contains a newline it won't work. Ack
" searches line-by-line.

nnoremap <silent> <leader>A :set opfunc=<SID>AckMotion<CR>g@
xnoremap <silent> <leader>A :<C-U>call <SID>AckMotion(visualmode())<CR>

nnoremap <bs> :Ack! '\b<c-r><c-w>\b'<cr>
xnoremap <silent> <bs> :<C-U>call <SID>AckMotion(visualmode())<CR>

function! s:CopyMotionForType(type)
  if a:type ==# 'v'
    silent execute "normal! `<" . a:type . "`>y"
  elseif a:type ==# 'char'
    silent execute "normal! `[v`]y"
  endif
endfunction

function! s:AckMotion(type) abort
  let reg_save = @@
  call s:CopyMotionForType(a:type)
  execute "normal! :Ack! --literal " . shellescape(@@) . "\<cr>"
  let @@ = reg_save
endfunction

"   }}}
" }}}
" Workspaces -------------------------------------------------------------- {{{

let g:screen_size_restore_pos = 1
let g:screen_size_by_vim_instance = 1

if has("gui_running")
  function! ScreenFilename()
    if has('amiga')
      return "s:.vimsize"
    elseif has('win32')
      return $HOME.'\_vimsize'
    else
      return $HOME.'/.vimsize'
    endif
  endfunction

  function! ScreenRestore()
    " Restore window size (columns and lines) and position
    " from values stored in vimsize file.
    " Must set font first so columns and lines are based on font size.
    let f = ScreenFilename()
    if has("gui_running") && g:screen_size_restore_pos && filereadable(f)
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      for line in readfile(f)
        let sizepos = split(line)
        if len(sizepos) == 5 && sizepos[0] == vim_instance
          silent! execute "set columns=".sizepos[1]." lines=".sizepos[2]
          silent! execute "winpos ".sizepos[3]." ".sizepos[4]
          return
        endif
      endfor
    endif
  endfunction

  function! ScreenSave()
    " Save window size and position.
    if has("gui_running") && g:screen_size_restore_pos
      let vim_instance = (g:screen_size_by_vim_instance==1?(v:servername):'GVIM')
      let data = vim_instance . ' ' . &columns . ' ' . &lines . ' ' .
            \ (getwinposx()<0?0:getwinposx()) . ' ' .
            \ (getwinposy()<0?0:getwinposy())
      let f = ScreenFilename()
      if filereadable(f)
        let lines = readfile(f)
        call filter(lines, "v:val !~ '^" . vim_instance . "\\>'")
        call add(lines, data)
      else
        let lines = [data]
      endif
      call writefile(lines, f)
    endif
  endfunction

  if !exists('g:screen_size_restore_pos')
    let g:screen_size_restore_pos = 1
  endif
  if !exists('g:screen_size_by_vim_instance')
    let g:screen_size_by_vim_instance = 1
  endif
  autocmd VimEnter * if g:screen_size_restore_pos == 1 | call ScreenRestore() | endif
  autocmd VimLeavePre * if g:screen_size_restore_pos == 1 | call ScreenSave() | endif
endif

" }}}
" Statusline -------------------------------------------------------------- {{{
set statusline=[%n]\ %<%f%m%r
set statusline+=\ %{exists('g:loaded_rvm')?rvm#statusline():'\ '}
set statusline+=%{fugitive#statusline()}%=
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%w\ <%{&fileformat}>%\=\ [%o]\ %l,%c%V\/%L\ \ %P
" }}}
syntax enable
syntax on

set nomousehide
