" --------------------------------------------
" #### Usage
" Ctrl + n => NERTTreeToggle
" <Leader>/ => Togglecommentout
"
" --------------------------------------------

set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

" Edit {{{
  NeoBundle 'scrooloose/nerdcommenter.git'
  NeoBundle 'xmledit'
" }}}

" Completion {{{
  NeoBundle 'kien/ctrlp.vim'
  NeoBundle 'scrooloose/nerdtree.git'
  NeoBundle 'm2ym/rsense'
" }}}

" Searching/Moving{{{
  NeoBundle 'grep.vim'
  NeoBundle 'eregex.vim'
" }}}

" Programming {{{
  NeoBundle 'SQLUtilities'
  NeoBundle 'vim-ruby/vim-ruby'
  NeoBundle 'tpope/vim-rails'
" }}}

" Syntax {{{
  NeoBundle 'haml.zip'
  NeoBundle 'JavaScript-syntax'
  NeoBundle 'jQuery'
  NeoBundle 'nginx.vim'
  NeoBundle 'tpope/vim-markdown'
  NeoBundle 'kchmck/vim-coffee-script'
  NeoBundle 'scrooloose/syntastic'
" }}}

" Encording {{{
  NeoBundle 'banyan/recognize_charcode.vim'
" }}}

" ColorSchema{{{{
  NeoBundle 'fugalh/desert'
" }}}

filetype plugin indent on

syntax enable
set background=dark
colorscheme desert

set encoding=utf-8
set fileencodings=utf-8,cp932,eucjp,iso2022jp,utf-16
set fileformats=unix,dos,mac

set ambiwidth=double
set autoindent
set autoread
set backspace=indent,eol,start
set cursorline
set directory-=.
set display=lastline
set hidden
set ignorecase
set incsearch
set laststatus=2
set list
set listchars=tab:»\
set mouse=a
set ttymouse=xterm2
set nobackup
set nohlsearch
set number
set ruler
set showcmd
set showmatch
set showmode
set smartcase
set smartindent
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%=%l,%c%v%8p
set ttimeoutlen=0
set virtualedit=block
set visualbell t_vb=
set wildmode=list:longest,list:full
set expandtab tabstop=2 shiftwidth=2

" Plugins
" NERD Commenter
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
nmap <Leader>/ <Plug>NERDCommenterToggle
vmap <Leader>/s <Plug>NERDCommenterSexy
" NERD Tree
map <C-n> :NERDTreeToggle<CR>
" Gundo
" nnoremap <Leader><F5> :GundoToggle<CR>
let g:acp_enableAtStartup = 0
let g:neocomplcache_enable_at_startup = 1

scriptencoding utf-8
augroup MyCommand
  autocmd!

  autocmd FileType * setlocal formatoptions-=ro
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
  autocmd InsertEnter * highlight StatusLine ctermfg=red
  autocmd InsertLeave * highlight StatusLine ctermfg=white
  autocmd InsertEnter * set nopaste
  autocmd VimEnter,ColorScheme * highlight ZenkakuSpace term=underline ctermbg=Red guibg=Red
  autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  " auto trailing whitespace
  autocmd BufWritePre * :%s/\s\+$//e
  " neocomplcache
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21
