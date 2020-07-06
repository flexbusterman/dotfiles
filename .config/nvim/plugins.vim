" ============================================================================ "
" ===                               PLUGINS                                === "
" ============================================================================ "

" check whether vim-plug is installed and install it if necessary
" let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
" if !filereadable(plugpath)
"     if executable('curl')
"         let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"         call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
"         if v:shell_error
"             echom "Error downloading vim-plug. Please install it manually.\n"
"             exit
"         endif
"     else
"         echom "vim-plug not installed. Please install it manually or install curl.\n"
"         exit
"     endif
" endif

call plug#begin('~/.config/nvim/plugged')

" === Editing Plugins === "
" Trailing whitespace highlighting & automatic fixing
Plug 'ntpeters/vim-better-whitespace'

" auto-close p lugin
Plug 'rstacruz/vim-closer'

" Improved motion in Vim
Plug 'easymotion/vim-easymotion'

" Intellisense Engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Denite - Fuzzy finding, buffer management
if has('nvim')
  Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" Snippet support
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Print function signatures in echo area
Plug 'Shougo/echodoc.vim'

" === Git Plugins === "
" Enable git changes to be shown in sign column
" Plug 'mhinz/vim-signify'
" Plug 'tpope/vim-fugitive'

" === Javascript Plugins === "
" Typescript syntax highlighting
Plug 'HerringtonDarkholme/yats.vim'

" ReactJS JSX syntax highlighting
Plug 'mxw/vim-jsx'

" Generate JSDoc commands based on function signature
Plug 'heavenshell/vim-jsdoc'

" === Syntax Highlighting === "

" Syntax highlighting for nginx
Plug 'chr4/nginx.vim'

" Syntax highlighting for javascript libraries
Plug 'othree/javascript-libraries-syntax.vim'

" Improved syntax highlighting and indentation
Plug 'othree/yajs.vim'

" === UI === "
" File explorer
Plug 'scrooloose/nerdtree'

" Colorscheme
Plug 'mhartington/oceanic-next'

" Customized vim status line
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'

Plug 'itchyny/lightline.vim'                      " Lightline statusbar

" Icons
" Plug 'ryanoasis/vim-devicons'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Flex
Plug 'tpope/vim-surround'                         " https://github.com/tpope/vim-surround

" Plug 'leafoftree/vim-vue-plugin'                  " vimawesome.com/plugin/vim-vue-plugin

" Seems to work better
Plug 'posva/vim-vue'                  " vimawesome.com/plugin/vim-vue-plugin

Plug 'dracula/vim'
Plug 'chiel92/vim-autoformat'

" Plug 'chrisbra/vim-commentary'
Plug 'preservim/nerdcommenter'
" Plug 'Yggdroot/indentLine' " https://github.com/Yggdroot/indentLine
Plug 'ap/vim-css-color'

Plug 'miyakogi/seiya.vim'
" Plug 'arecarn/vim-crunch'
" Plug 'eslint/eslint'
" Plug 'sk1418/howmuch.vim'
Plug 'nixon/vim-vmath'

Plug 'vimwiki/vimwiki'

Plug 'ThePrimeagen/vim-be-good', {'do': '.\install.sh'}

Plug 'sbl/scvim'


" Initialize plugin system
call plug#end()
