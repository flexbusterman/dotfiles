call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdtree'
" Plug 'tsony-tsonev/nerdtree-git-plugin'
" Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'ryanoasis/vim-devicons'
" Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'scrooloose/nerdcommenter'
" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

Plug 'christoomey/vim-tmux-navigator'

" Plug 'morhetz/gruvbox'

Plug 'HerringtonDarkholme/yats.vim' " TS Syntax

" Improved motion in Vim
Plug 'easymotion/vim-easymotion'

Plug 'dracula/vim'

Plug 'vimwiki/vimwiki'

Plug 'ThePrimeagen/vim-be-good', {'do': '.\install.sh'}

" Plug 'sbl/scvim'
Plug 'supercollider/scvim'

Plug 'itchyny/lightline.vim'                      " Lightline statusbar

" Initialize plugin system
call plug#end()
