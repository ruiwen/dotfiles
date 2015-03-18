
syntax on
colorscheme jellybeans

:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" Filetype specific settings
" Simplified setup before we jump into using ftplugin
:filetype on
autocmd Filetype html setlocal ts=2 sw=2 expandtab
autocmd Filetype python setlocal ts=4 sw=4 expandtab
autocmd Filetype javascript setlocal ts=4 sw=4 expandtab
autocmd Filetype nginx setlocal ts=2 sw=2 expandtab
