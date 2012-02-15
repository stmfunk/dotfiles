"""""""""""""""""
" meises .vimrc "
"""""""""""""""""

" enable loading plugin files

syntax on
filetype on

" default encoding
set termencoding=utf-8
set encoding=utf-8
" tab settings
set tabstop=2
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
" shut the fuck up
set visualbell 
set noerrorbells
" history count and undolevels
set history=500
set undolevels=500
" show matching '()' pairs
set showmatch
" create no *~ backup files
set nobackup

" color
""""""""
if has("gui_running") " GUI color and font settings
  set guifont=Osaka-Mono:h20
  set background=dark
  set t_Co=256 " 256 color mode
  set cursorline " highlight current line
  colors moria
  highlight CursorLine guibg=#003853 ctermbg=24 gui=none cterm=none
else
endif

" plugins
""""""""""
filetype plugin on
" pathogen.vim
call pathogen#infect()

" latex settings
if has('gui_running')
    set grepprg=grep\ -nH\ $*
    filetype indent on
    let g:tex_flavor='latex'
endif

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
au BufRead,BufNewFile *.md set ft=mkd tw=80 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.markdown set ft=mkd tw=80 ts=2 sw=2 expandtab
au BufRead,BufNewFile *.ronn set ft=mkd tw=80 ts=2 sw=2 expandtab

au Filetype gitcommit set tw=68 spell
au Filetype ruby set tw=80 ts=2
au Filetype html,xml,xsl,rhtml source $HOME/.vim/scripts/closetag.vim

au BufNewFile,BufRead *.mustache setf mustache

" Backups
""""""""""
set nobackup  " do not keep backups after close
set nowritebackup   " do not keep a backup while working
set noswapfile  " don't keep swp files either
set backupdir=$HOME/.vim/backup   " store backups under ~/.vim/backup
set backupcopy=yes  " keep attributes of original file
set backupskip=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*
set directory=~/.vim/swap,~/tmp,. " keep swp files under ~/.vim/swap
