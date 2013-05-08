set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

" Edit {{{
  NeoBundle 'scrooloose/nerdcommenter.git'
  NeoBundle 'xmledit'
  NeoBundle 'Gundo'
" }}}

" Completion {{{
  NeoBundle 'Shougo/neocomplcache'
  NeoBundle 'scrooloose/nerdtree.git'
  NeoBundle 'Shougo/neosnippet.git'
  NeoBundle 'honza/snipmate-snippets'
  NeoBundle 'm2ym/rsense'
  NeoBundle 'taichouchou2/vim-rsense'
" }}}

" Searching/Moving{{{
  NeoBundle 'smartword'
  NeoBundle 'matchit.zip'
  NeoBundle 'ruby-matchit'
  NeoBundle 'grep.vim'
  NeoBundle 'eregex.vim'
" }}}

" Programming {{{
  " SQLUtilities : SQL整形、生成ユーティリティ
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

" Utility {{{
  NeoBundle 'L9'
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


" 以前開いていたときのカーソル位置を復元する
autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif

" 全角空白と行末の空白の色を変える
highlight WideSpace ctermbg=blue guibg=blue
highlight EOLSpace ctermbg=red guibg=red

function! s:HighlightSpaces()
  syntax match WideSpace /　/ containedin=ALL
  syntax match EOLSpace /\s\+$/ containedin=ALL
endf

call s:HighlightSpaces()
autocmd WinEnter * call s:HighlightSpaces()

" 挿入モード時、ステータスラインの色を変える
autocmd InsertEnter * highlight StatusLine ctermfg=red
autocmd InsertLeave * highlight StatusLine ctermfg=white
autocmd InsertLeave * set nopaste

" Plugins
" NERD Commenter
let g:NERDCreateDefaultMappings = 0
let NERDSpaceDelims = 1
nmap <Leader>/ <Plug>NERDCommenterToggle
vmap <Leader>/s <Plug>NERDCommenterSexy
" NERD Tree
map <C-n> :NERDTreeToggle<CR>
