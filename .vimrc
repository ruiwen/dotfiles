
set showcmd
set smartindent " Use smartindent
set number      " Show line numbers
set cursorline
set hidden      " Allow buffer switching on dirty buffers
set lazyredraw
set nocompatible

" Undo/backup/swap dirs
" Ref: https://coderwall.com/p/sdhfug/vim-swap-backup-and-undo-files
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
set directory=~/.vim/.swp//

syntax on
" set background=light
set background=dark
colorscheme mod8

set mouse=a

" Vim Plug Begin
call plug#begin("~/.vim/bundle")

" CtrlP plugin - https://github.com/kien/ctrlp.vim
Plug 'ctrlpvim/ctrlp.vim'

" CoffeeScript plugin - https://github.com/kchmck/vim-coffee-script
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

" Markdown - https://github.com/plasticboy/vim-markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown', { 'for': 'md' }

" Vim Jade - https://github.com/digitaltoad/vim-jade
Plug 'digitaltoad/vim-jade', { 'for': 'jade' }

" vim-emacs-bindings
Plug 'maxbrunsfeld/vim-emacs-bindings'

" Vim EasyMotion - http://vimawesome.com/plugin/easymotion
Plug 'Lokaltog/vim-easymotion'

" Ultisnips - https://github.com/sirver/ultisnips
Plug 'SirVer/ultisnips'

" vim-go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } "{ 'for': 'go' }

" mdempsky/gocode
Plug 'mdempsky/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }

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

" deoplete go
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make', 'for': 'go'}

" vim-airline
Plug 'vim-airline/vim-airline'

" vim-airline-themes
" Plug 'vim-airline/vim-airline-themes'

" vim indent guides
Plug 'nathanaelkane/vim-indent-guides'

" fugitive - git plugin
Plug 'tpope/vim-fugitive'

" terminus - makes vim work better in a terminal/tmux
Plug 'wincent/terminus'

" vim-easy-align
Plug 'junegunn/vim-easy-align'

" vimade - Fade inactive panes
Plug 'TaDaa/vimade'

" ale
Plug 'w0rp/ale'

" All of your Plugins must be added before the following line
call plug#end()

"
" Editing
" =========================

syntax enable
filetype plugin indent on

set foldenable  " Enable folding
set foldmethod=indent
set foldlevelstart=1
set foldnestmax=2
nnoremap <space> za  " space toggles opening/closing of the fold

" Filetype specific settings
" Simplified setup before we jump into using ftplugin
:filetype on

" Ref: https://stackoverflow.com/a/10410590
let blacklist = ['go']
augroup filetypes
  autocmd!
  autocmd BufWritePre * %s/\s\+$//e
  autocmd Filetype html setlocal ts=2 sw=2 expandtab
  autocmd Filetype css setlocal ts=2 sw=2 expandtab
  autocmd Filetype json setlocal ts=2 sw=2 expandtab
  autocmd Filetype python setlocal ts=4 sw=4 expandtab
  autocmd Filetype ruby setlocal ts=4 sw=4 expandtab
  autocmd Filetype jade setlocal ts=2 sw=2 expandtab
  autocmd BufNewfile,BufRead *.jade set filetype=pug
  autocmd Filetype javascript setlocal ts=4 sw=4 expandtab
  autocmd Filetype javascript setlocal foldmethod=syntax
  autocmd Filetype nginx setlocal ts=2 sw=2 expandtab
  autocmd Filetype sh setlocal ts=2 sw=2 expandtab
  autocmd BufNewfile,BufRead *.coffee set filetype=coffee
  autocmd Filetype coffee setlocal ts=2 sw=2 expandtab
  autocmd BufNewfile,BufRead *.go set filetype=go
  autocmd Filetype yaml setlocal ts=2 sw=2 expandtab
  autocmd BufNewfile,BufRead *.sls set filetype=yaml
  autocmd Filetype fluentd setlocal ts=2 sw=2 expandtab
  autocmd Filetype dockerfile setlocal ts=2 sw=2 expandtab
  autocmd Filetype vim setlocal ts=2 sw=2 expandtab
  autocmd Filetype go setlocal ts=4 sw=4 sts=4 noexpandtab
  autocmd Filetype snippets setlocal ts=2 sw=2 sts=2 noexpandtab
  autocmd CursorHold,FocusLost,BufLeave * if index(blacklist, &ft) < 0 | Neomake
augroup END

" augroup golang
"   autocmd!
"   autocmd BufWritePost *.go Neomake
"   autocmd Filetype go setlocal nofoldenable
" augroup END

" Allow manual folding while editing even though auto folding is on
" augroup vimrc
"   au BufReadPre * setlocal foldmethod=indent
"   au BufWinEnter * if &fdm == 'indent' | setlocal foldmethod=manual | endif
" augroup END

" let g:go_gocode_autobuild = 0

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" Commands
command! Bd bp\|bd #
command! R :so $MYVIMRC
command! E :set paste!

" Neovim / Deoplete
if has('nvim')
  let g:deoplete#enable_at_startup = 1

  " Python 3 support
  let g:python3_host_prog = '/usr/bin/python3'

  "deoplete tab-complete
  " Ref: https://gregjs.com/vim/2016/configuring-the-deoplete-asynchronous-keyword-completion-plugin-with-tern-for-vim/
  inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

  " Deoplete Go settings
  " https://github.com/zchee/deoplete-go#available-settings
  let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'

  augroup nvim
    autocmd!
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
  augroup END
endif

""
" UltiSnips
""
let g:UltiSnipsSnippetDirectories=["UltiSnips", "snips"]
" Ref: https://github.com/Valloric/YouCompleteMe/issues/420#issuecomment-55940039
let g:UltiSnipsExpandTrigger = "<nop>"
let g:ulti_expand_or_jump_res = 0
function! ExpandSnippetOrCarriageReturn()
    let snippet = UltiSnips#ExpandSnippetOrJump()
    if g:ulti_expand_or_jump_res > 0
        return snippet
    else
        return "\<CR>"
    endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Set vim-airline theme
let g:airline_extensions = ['hunks', 'branch']
" let g:airline_powerline_fonts = 1

" Set up indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_auto_colors = 0
hi IndentGuidesOdd  guibg=grey   ctermbg=0
hi IndentGuidesEven guibg=grey ctermbg=0

" Ctrl P
" Key bindings
let g:ctrlp_map = '<c-p>'
let g:ctrlp_prompt_mappings = {
  \ 'PrtClearCache()': ['<c-R>'],
  \ }
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

" Map easy-align
vmap \| <Plug>(EasyAlign)
"xmap ga <Plug>(EasyAlign)

" Vimade
" Ref: https://github.com/TaDaa/vimade/blob/master/README.md
let g:vimade = {
  \ "fadelevel": 0.6,
  \ "colbufsize": 30,
  \ "rowbufsize": 30,
  \ "checkinterval": 32,}

" vim-go settings
let g:go_auto_sameids = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1


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
" nnoremap <silent> <A-j>  :m .+1<CR>==
" nnoremap <silent> <A-k> :m .-2<CR>==
" inoremap <silent> <A-j> <Esc>:m .+1<CR>==gi
" inoremap <silent> <A-k> <Esc>:m .-2<CR>==gi
" vnoremap <silent> <A-j> :m '>+1<CR>gv=gv
" vnoremap <silent> <A-k> :m '<-2<CR>gv=gv

" Use Esc to clear search highlighting
" Ref: http://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting#comment3805589_657447
nnoremap <silent> <Esc> :nohlsearch<CR> :let @/=""<CR>

