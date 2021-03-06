"""""""""""""""""
" meises .vimrc "
"""""""""""""""""

" basics
"""""""""
syntax on
filetype on

" allow saving of files as sudo when you forgot to start vim using sudo
if executable('sudo') && executable('tee')
  command! W execute 'w !sudo tee % > /dev/null' | setlocal nomodified
endif

set nocompatible
set modeline
set fo=tcq

" default encoding
set termencoding=utf-8
set encoding=utf-8
" tab settings
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nosmarttab " fu tabs
au FileType Makefile set noexpandtab
" statusline
set statusline=%F%m%r%h%w\ [TYPE=%Y\ %{&ff}]\ [%l/%L\ (%p%%)]
" show the cursor position all the time
set ruler
" search settings
set incsearch
set ignorecase
set smartcase
set hlsearch
" shut the fuck up
set noerrorbells
" history count and undolevels
set history=500
set undolevels=500
" show matching '()' pairs
set showmatch
" create no *~ backup files
set nobackup

" color
if has("gui_running") " GUI color and font settings
  set guifont=Osaka-Mono:h20
  set background=dark
  set t_Co=256 " 256 color mode
  set cursorline " highlight current line
" colors moria
  highlight CursorLine guibg=#003853 ctermbg=24 gui=none cterm=none
else
  set background=dark
  set cursorline "underline the current line in the file
endif

" plugins
""""""""""
filetype plugin indent on

" file types
"""""""""""""
au BufRead,BufNewFile *.rxls set ft=ruby
au BufRead,BufNewFile *.ru set ft=ruby
au BufRead,BufNewFile *.god set ft=ruby
au BufRead,BufNewFile *.rtxt set ft=html spell
au BufRead,BufNewFile *.sql set ft=pgsql
au BufRead,BufNewFile *.rl set ft=ragel
au BufRead,BufNewFile *.svg set ft=svg
au BufRead,BufNewFile *.haml set ft=haml
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set ft=mkd tw=80 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.markdown set ft=mkd tw=80 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.ronn set ft=mkd tw=80 ts=2 sw=2 expandtab
" Set up puppet manifest and spec options
au BufRead,BufNewFile *.pp
  \ set filetype=puppet
au BufRead,BufNewFile *_spec.rb
  \ nmap <F8> :!rspec --color %<CR>

" Git commit
au Filetype gitcommit set tw=68 spell
au Filetype ruby set tw=80 ts=2
au Filetype html,xml,xsl,rhtml source $HOME/.vim/scripts/closetag.vim

au BufNewFile,BufRead *.mustache setf mustache

" Backups
set nobackup  " do not keep backups after close
set noswapfile  " don't keep swp files either

" Use a bar-shaped cursor for insert mode, even through tmux.
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

colorscheme desert

     set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
     " | | | | | | | | | | |
     " | | | | | | | | | | + current
     " | | | | | | | | | | column
     " | | | | | | | | | +-- current line
     " | | | | | | | | +-- current % into file
     " | | | | | | | +-- current syntax in
     " | | | | | | | square brackets
     " | | | | | | +-- current fileformat
     " | | | | | +-- number of lines
     " | | | | +-- preview flag in square brackets
     " | | | +-- help flag in square brackets
     " | | +-- readonly flag in square brackets
     " | +-- rodified flag in square brackets
     " +-- full path to file in the buffer
 " }

highlight comment ctermfg=cyan
highlight LiteralTabs ctermbg=darkgreen guibg=darkgreen
match LiteralTabs /\s\  /
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$/
