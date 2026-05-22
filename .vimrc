set shell=/bin/zsh\ -l
set rtp+=/opt/homebrew/opt/fzf

syntax on
set number
set mouse=a
set clipboard=unnamed
set statusline=%f\ %m
set laststatus=2
set foldmethod=indent

set path+=**
set wildmenu

call plug#begin()
  Plug 'junegunn/fzf'
  Plug 'junegunn/fzf.vim' 
  Plug 'preservim/nerdtree'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'NLKNguyen/papercolor-theme'
  Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

autocmd VimEnter * NERDTree 

nmap <silent><nowait> gd <Plug>(coc-definition)
nmap <silent><nowait> gy <Plug>(coc-type-definition)
nmap <silent><nowait> gi <Plug>(coc-implementation)
nmap <silent><nowait> gr <Plug>(coc-references)

nnoremap <leader>cf :let @+ = expand('%:t')<CR>
nnoremap <leader>cp :let @+ = expand('%:p')<CR>

set background=dark
colorscheme PaperColor
