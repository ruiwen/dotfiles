
set showcmd
set smartindent
set number
set cursorline

syntax on
" set background=light
set background=dark
colorscheme jellybeans
"colorscheme solarized

" Vundle package management
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" CtrlP plugin - https://github.com/kien/ctrlp.vim
Plugin 'ctrlpvim/ctrlp.vim'

" CoffeeScript plugin - https://github.com/kchmck/vim-coffee-script
Plugin 'kchmck/vim-coffee-script'

" Markdown - https://github.com/plasticboy/vim-markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Vim Jade - https://github.com/digitaltoad/vim-jade
Plugin 'digitaltoad/vim-jade'

" Vimac
" Plugin 'andrep/vimacs'

" vim-emacs-bindings
Plugin 'maxbrunsfeld/vim-emacs-bindings'

" Vim EasyMotion - http://vimawesome.com/plugin/easymotion
Plugin 'Lokaltog/vim-easymotion'

" Ultisnips - https://github.com/sirver/ultisnips
Plugin 'SirVer/ultisnips'

" Snippets
"Plugin 'honza/vim-snippets'

" vim-go
Plugin 'fatih/vim-go'

" YouCompleteMe
Plugin 'Valloric/YouCompleteMe'

" Syntastic
Plugin 'scrooloose/syntastic'

" Docker
Plugin 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}

" All of your Plugins must be added before the following line
call vundle#end()

syntax enable
filetype plugin indent on

" Filetype specific settings
" Simplified setup before we jump into using ftplugin
:filetype on
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype python setlocal ts=4 sw=4 expandtab
autocmd Filetype jade setlocal ts=2 sw=2 expandtab
autocmd BufNewfile,BufRead *.jade set filetype=jade
autocmd Filetype javascript setlocal ts=4 sw=4 expandtab
autocmd Filetype nginx setlocal ts=2 sw=2 expandtab
autocmd Filetype sh setlocal ts=2 sw=2 expandtab
autocmd BufNewfile,BufRead *.coffee set filetype=coffee
autocmd Filetype coffee setlocal ts=2 sw=2 expandtab
autocmd BufNewfile,BufRead Dockerfile set filetype=dockerfile

" Commands
command! Bd bp\|bd \#
command! Reload :so $MYVIMRC

" Key bindings
let g:ctrlp_map = '<c-p>'

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


