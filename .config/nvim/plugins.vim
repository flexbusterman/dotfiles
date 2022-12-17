call plug#begin('~/.vim/plugged')
" Plug 'scrooloose/nerdtree'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ctrlpvim/ctrlp.vim' " fuzzy find files
Plug 'scrooloose/nerdcommenter'
" Plug 'christoomey/vim-tmux-navigator'
" Plug 'HerringtonDarkholme/yats.vim' " TS Syntax
Plug 'easymotion/vim-easymotion' " Improved /home/flex/.vim/plugged/vim-nerdtree-l-open-h-closemotion in Vim
Plug 'dracula/vim'
Plug 'vimwiki/vimwiki'
Plug 'markonm/traces.vim' " previews substitution and sort using regex
" Plug 'flw-cn/vim-nerdtree-l-open-h-close' " NERDTree h l open and close
Plug 'andymass/vim-matchup' " To matchit in vue
Plug 'leafOfTree/vim-vue-plugin'
Plug 'posva/vim-vue'
Plug 'davidgranstrom/scnvim'
Plug 'vim-pandoc/vim-pandoc' " to show sc documentation in nvim
Plug 'vim-pandoc/vim-pandoc-syntax' 
" Plug 'sainnhe/sonokai'
" Plug 'johngrib/vim-game-snake'
" Plug 'wellle/targets.vim'
Plug 'tpope/vim-fugitive' " git wrapper
Plug 'vim-airline/vim-airline'
" Plug 'wincent/loupe' " very magic searching Greg Hurrell
Plug 'lervag/vimtex'
" Plug 'nvim-lua/popup.nvim' " telescope
" Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'metakirby5/codi.vim'
Plug 'sheerun/vim-polyglot' " syntax and indenting for multiple languages
" Plug 'TristanCrawford/vim-eel2' " reaper syntax highlighting
" Plug 'tidalcycles/vim-tidal'
" Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' } " show colors as colors
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
"
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" quickfix list jumping
Plug 'tpope/vim-unimpaired'

" Plug 'madskjeldgaard/vim-supercollider-snippets'

" OLD
" Plug 'tsony-tsonev/nerdtree-git-plugin'
" Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'ryanoasis/vim-devicons'
" Plug 'airblade/vim-gitgutter'
" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
" Plug 'morhetz/gruvbox'
" Plug 'ThePrimeagen/vim-be-good', {'do': '.\install.sh'}
" Plug 'itchyny/lightline.vim' Lightline statusbar
" Plug 'sbl/scvim'
" Plug 'supercollider/scvim'
" Plug 'sersorrel/vim-lilypond'
" Plug 'vim-scripts/tetris'

call plug#end()

lua << EOF
require('scnvim').setup()
EOF
