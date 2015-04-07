
set smartindent
set number
syntax on
colorscheme jellybeans

:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Vundle package management
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" CtrlP plugin - https://github.com/kien/ctrlp.vim
Plugin 'kien/ctrlp.vim'

" CoffeeScript plugin - https://github.com/kchmck/vim-coffee-script
Plugin 'kchmck/vim-coffee-script'

" Markdown - https://github.com/plasticboy/vim-markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" Vimac
Plugin 'andrep/vimacs'

" All of your Plugins must be added before the following line
call vundle#end()

syntax enable
filetype plugin indent on

" Filetype specific settings
" Simplified setup before we jump into using ftplugin
:filetype on
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype python setlocal ts=4 sw=4 expandtab
autocmd Filetype javascript setlocal ts=4 sw=4 expandtab
autocmd Filetype nginx setlocal ts=2 sw=2 expandtab
autocmd Filetype coffee setlocal ts=4 sw=4 expandtab


" Key bindings
let g:ctrlp_map = '<c-p>'
