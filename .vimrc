
set showcmd
set smartindent " Use smartindent
set number      " Show line numbers
set cursorline
set hidden      " Allow buffer switching on dirty buffers

" Undo/backup/swap dirs
" Ref: https://coderwall.com/p/sdhfug/vim-swap-backup-and-undo-files
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//


syntax on
" set background=light
set background=dark
colorscheme mod8


" Vim Plug Begin
call plug#begin("~/.vim/bundle")

" let Vundle manage Vundle, required
Plug 'gmarik/Vundle.vim'

" CtrlP plugin - https://github.com/kien/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'

" CoffeeScript plugin - https://github.com/kchmck/vim-coffee-script
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

" Markdown - https://github.com/plasticboy/vim-markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': 'md' }

" Vim Jade - https://github.com/digitaltoad/vim-jade
Plug 'digitaltoad/vim-jade', { 'for': 'jade' }

" Vimac
" Plug 'andrep/vimacs'

" vim-emacs-bindings
Plug 'maxbrunsfeld/vim-emacs-bindings'

" Vim EasyMotion - http://vimawesome.com/plugin/easymotion
Plug 'Lokaltog/vim-easymotion'

" Ultisnips - https://github.com/sirver/ultisnips
" Plug 'SirVer/ultisnips'

" Snippets
"Plug 'honza/vim-snippets'

" vim-go
Plug 'fatih/vim-go', { 'for': 'go' }

" YouCompleteMe
" Plug 'Valloric/YouCompleteMe'

" Syntastic
" Plug 'scrooloose/syntastic'

" Neomake
Plug 'neomake/neomake'

" Docker
Plug 'docker/docker' , { 'rtp': '/contrib/syntax/vim/' }

" vim git-gutter
Plug 'airblade/vim-gitgutter'

" deoplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

" deoplete jedi
Plug 'zchee/deoplete-jedi'

" All of your Plugins must be added before the following line
" call vundle#end()
call plug#end()

syntax enable
filetype plugin indent on

" Filetype specific settings
" Simplified setup before we jump into using ftplugin
:filetype on
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype python setlocal ts=4 sw=4 expandtab
autocmd Filetype jade setlocal ts=2 sw=2 expandtab
autocmd BufNewfile,BufRead *.jade set filetype=pug
autocmd Filetype javascript setlocal ts=4 sw=4 expandtab
autocmd Filetype nginx setlocal ts=2 sw=2 expandtab
autocmd Filetype sh setlocal ts=2 sw=2 expandtab
autocmd BufNewfile,BufRead *.coffee set filetype=coffee
autocmd Filetype coffee setlocal ts=2 sw=2 expandtab
autocmd BufNewfile,BufRead *.go set filetype=go
autocmd Filetype yaml setlocal ts=2 sw=2 expandtab
autocmd Filetype fluentd setlocal ts=2 sw=2 expandtab
autocmd! BufWritePost * Neomake

" Commands
command! Bd bp\|bd #
command! R :so $MYVIMRC
command! E :set paste!

" Neovim / Deoplete
if has('nvim') != 0
  let g:deoplete#enable_at_startup = 1

  " Python 3 support
  let g:python3_host_prog = '/usr/bin/python3'

  "deoplete tab-complete
  " Ref: https://gregjs.com/vim/2016/configuring-the-deoplete-asynchronous-keyword-completion-plugin-with-tern-for-vim/
  inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
endif

" Key bindings
let g:ctrlp_map = '<c-p>'

" YouCompleteMe config
" https://github.com/Valloric/YouCompleteMe#options
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1


" Ctrl P ignore settings
set wildignore+=*/venv*/*,*.pyc,*/node_modules/*,*/bower_components/*

" EasyMotion
"map <Leader> <Plug>(easymotion-prefix)
map <Leader> <Plug>(easymotion-s2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Gif config
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" These `n` & `N` mappings are options. You do not have to map `n` & `N` to
" EasyMotion.
" Without these mappings, `n` & `N` works fine. (These mappings just provide
" " different highlight method and have some other features )
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" Rebound keys

" Remove trailing spaces
:noremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Resizing splits
:map <C-J> <C-W>j
:map <C-K> <C-W>k
:map <C-H> <C-W>h
:map <C-L> <C-W>l
:noremap <silent> ˘  <C-W>+
:noremap <silent> ¯  <C-W>-
:noremap <silent> ≤  <C-W><
:noremap <silent> ≥  <C-W>>
:noremap <C-W>_  <C-W>s
:noremap <C-W>\| <C-W>v

" Move lines around
" http://vim.wikia.com/wiki/Moving_lines_up_or_down
" Mapping Alt in Mac - http://stackoverflow.com/a/5382863
nnoremap <silent> ∆  :m .+1<CR>==
nnoremap <silent> ˚ :m .-2<CR>==
inoremap <silent> ∆ <Esc>:m .+1<CR>==gi
inoremap <silent> ˚ <Esc>:m .-2<CR>==gi
vnoremap <silent> ∆ :m '>+1<CR>gv=gv
vnoremap <silent> ˚ :m '<-2<CR>gv=gv

" Use Esc to clear search highlighting
" Ref: http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#comment3805589_657447
nnoremap <silent> <Esc> :nohlsearch<CR> :let @/=""<CR>

