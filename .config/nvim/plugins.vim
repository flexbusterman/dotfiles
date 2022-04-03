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

" Plug 'ThePrimeagen/vim-be-good', {'do': '.\install.sh'}

" Lightline statusbar
" Plug 'itchyny/lightline.vim'

" previews substitution and sort using regex
Plug 'markonm/traces.vim'

" NERDTree h l open and close
Plug 'flw-cn/vim-nerdtree-l-open-h-close'


Plug 'flw-cn/vim-nerdtree-l-open-h-close'

" To matchit in vue
Plug 'andymass/vim-matchup'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'posva/vim-vue'

" Plug 'sbl/scvim'
" Plug 'supercollider/scvim'
Plug 'davidgranstrom/scnvim', { 'do': {-> scnvim#install() } }
" to show sc documentation in nvim
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax' 

" Plug 'sersorrel/vim-lilypond'

Plug 'sainnhe/sonokai'
" Initialize plugin system
Plug 'johngrib/vim-game-snake'
Plug 'wellle/targets.vim'

Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'

Plug 'wincent/loupe'

Plug 'lervag/vimtex'
Plug 'xuhdev/vim-latex-live-preview', { 'for': 'tex' }
" Plug 'vim-scripts/tetris'

" telescope
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'metakirby5/codi.vim'
Plug 'sheerun/vim-polyglot'
Plug 'TristanCrawford/vim-eel2'
Plug 'tidalcycles/vim-tidal'
call plug#end()
