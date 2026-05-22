" =========================
" OS Detection
" =========================
let g:is_windows = has('win32') || has('win64')
let g:is_mac = has('macunix')
let g:is_linux = has('unix') && !has('macunix')


" =========================
" Shell
" =========================
if g:is_windows
    set shell=pwsh
elseif g:is_mac
    set shell=/bin/zsh\ -l
endif


" =========================
" FZF Runtime Path
" =========================
if g:is_mac
    set rtp+=/opt/homebrew/opt/fzf
elseif g:is_linux
    set rtp+=/usr/share/fzf
endif

" =========================
" Basic Settings
" =========================
syntax on
set number
set mouse=a
set statusline=%f\ %m
set laststatus=2
set foldmethod=indent

set path+=**
set wildmenu

" =========================
" Clipboard
" =========================
if g:is_windows
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif


" =========================
" Setup CocConfig Home Path
" =========================
let g:coc_config_home = '~/.vim'


" =========================
" vim-plug
" =========================
call plug#begin()
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim' 
  Plug 'preservim/nerdtree'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
call plug#end()


" =========================
" NERDTree
" =========================
autocmd VimEnter * NERDTree 

" =========================
" coc.nvim mappings
" =========================
nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

" =========================
" Copy filename/path
" =========================
nnoremap <leader>cf :let @+ = expand('%:t')<CR>
nnoremap <leader>cp :let @+ = expand('%:p')<CR>

" =========================
" Theme
" =========================
set background=dark
colorscheme PaperColor
