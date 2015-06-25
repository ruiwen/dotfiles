
set showcmd
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

" Vim EasyMotion - http://vimawesome.com/plugin/easymotion
Plugin 'Lokaltog/vim-easymotion'

" Ultisnips - https://github.com/sirver/ultisnips
Plugin 'SirVer/ultisnips'

" Snippets
"Plugin 'honza/vim-snippets'

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
autocmd Filetype javascript setlocal ts=4 sw=4 expandtab
autocmd Filetype nginx setlocal ts=2 sw=2 expandtab
autocmd BufNewfile,BufRead *.coffee set filetype=coffee
autocmd Filetype coffee setlocal ts=4 sw=4 expandtab


" Key bindings
let g:ctrlp_map = '<c-p>'

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
