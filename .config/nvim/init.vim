scriptencoding utf-8
source ~/.config/nvim/plugins.vim

" Remap leader key to ,
let mapleader = ","
let g:mapleader = ","

set nocompatible

" this just inverts lines instead of toggle comments for all:
nnoremap <C-\> :norm ,c<space><CR>
let NERDSpaceDelims=1

" insert console.log()
map <leader>l <esc>iconsole.log()<esc>i
nnoremap <leader>w :w<CR>
inoremap <leader>w <esc>:w<CR>
map <leader>q <esc>:q!<CR>

filetype plugin on

let g:ft = ''
fu! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        let syn = tolower(syn)
        exe 'setf '.syn
      endif
    endif
  endif
endfu
fu! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    g:ft
  endif
endfu

" Don't show last command
set noshowcmd

" Yank and paste with the system clipboard
set clipboard+=unnamedplus

" Insert spaces when TAB is pressed.
set expandtab

" Change number of spaces that a <Tab> counts for during editing ops
set tabstop=2

" Indentation amount for < and > commands.
set shiftwidth=2

" Disable line/column number in status line
" Shows up in preview window when airline is disabled if not
set noruler

" Only one line for command line
set cmdheight=1

" Don't give completion messages like 'match 1 of 2'
" or 'The only match'
set shortmess+=c
" Don't write backup file
set nobackup

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

syntax enable
set number relativenumber
let g:rehash256 = 1

set noshowmode

" Searches current directory recursively.
set path+=**

" Show hidden files/directories
let g:NERDTreeShowHidden = 1

" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1

" Custom icons for expandable/expanded directories
let g:NERDTreeDirArrowExpandable = '⬏'
let g:NERDTreeDirArrowCollapsible = '⬎'

" Hide certain files and directories from NERDTree
let g:NERDTreeIgnore = ['^\.DS_Store$', '^tags$', '\.git$[[dir]]', '\.idea$[[dir]]', '\.sass-cache$']

" enable line numbers
let NERDTreeShowLineNumbers = 1

" === echodoc === "
" Enable echodoc on startup
let g:echodoc#enable_at_startup = 1

" === vim-javascript === "
" Enable syntax highlighting for JSDoc
let g:javascript_plugin_jsdoc = 1

" === vim-jsx === "
" Highlight jsx syntax even in non .jsx files
let g:jsx_ext_required = 0

" === javascript-libraries-syntax === "
let g:used_javascript_libs = 'underscore,requirejs,chai,jquery'

" === Signify === "
let g:signify_sign_delete = '-'

" Change vertical split character to be a space (essentially hide it)
set fillchars+=vert:.

" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Don't dispay mode in command line (airilne already shows it)
set noshowmode

" Set floating window to be slightly transparent
set winbl=10

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritepre * %s/\n\+\%$//e
colorscheme dracula

if (has("termguicolors"))
  set termguicolors
endif

nmap <leader>n :NERDTreeToggle<CR>

" Quick window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l

nmap <leader>y :StripWhitespace<CR>

map <leader>h :%s///<left><left>
nmap <silent> <leader>. :nohlsearch<CR>

map <leader>m <Plug>(easymotion-bd-w)

cmap w!! w !sudo tee %

nmap <leader>z :JsDoc<CR>

" A syntax for placeholders
" Pressing Control-j jumps to the next match.
map <leader>j <Esc>/<++><CR><Esc>cf>
inoremap <leader>p <++>
" Disable arrows in normal mode
nnoremap <Down> <Nop>
nnoremap <Left> <Nop>
nnoremap <Right> <Nop>
nnoremap <Up> <Nop>
" Disable arrows in visual mode
vnoremap <Down> <Nop>
vnoremap <Left> <Nop>
vnoremap <Right> <Nop>
vnoremap <Up> <Nop>

" Automaticaly close nvim if NERDTree is only thing left open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" ignore case when searching
set ignorecase

" if the search string has an upper case letter in it, the search will be case sensitive
set smartcase

" Automatically re-read file if a change was detected outside of vim
set autoread

" Enable line numbers
set number

" Enable spellcheck for markdown files
autocmd BufRead,BufNewFile *.md setlocal spell
let g:lightline = {
      \ 'colorscheme': 'darcula',
      \ }

" Multiline editing
xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

let g:seiya_auto_enable=1

" Default value: ['ctermbg']
let g:seiya_target_groups = has('nvim') ? ['guibg'] : ['ctermbg']

command! -nargs=0 Sw w !sudo tee % > /dev/null

" map <C-<Bslash>>
let g:vim_vue_plugin_load_full_syntax = 1


set tabstop=2
set autoindent
set smartindent

noremap <F3> :Autoformat<CR>

" helper for indent mistake
set list listchars=tab:»·,trail:·

set indentexpr=

vnoremap <leader>r "ey:call CalcBC()<CR>
function! CalcBC()
  let has_equal = 0
  " remove newlines and trailing spaces
  let @e = substitute (@e, "\n", "", "g")
  let @e = substitute (@e, '\s*$', "", "g")
  " if we end with an equal, strip, and remember for output
  if @e =~ "=$"
    let @e = substitute (@e, '=$', "", "")
    let has_equal = 1
  endif
  " sub common func names for bc equivalent
  let @e = substitute (@e, '\csin\s*(', "s (", "")
  let @e = substitute (@e, '\ccos\s*(', "c (", "")
  let @e = substitute (@e, '\catan\s*(', "a (", "")
  let @e = substitute (@e, "\cln\s*(", "l (", "")
  " escape chars for shell
  let @e = escape (@e, '*()')
  " run bc, strip newline
  let answer = substitute (system ("echo " . @e . " \| bc -l"), "\n", "", "")
  " append answer or echo
  if has_equal == 1
    normal `>
    exec "normal a" . answer
  else
    echo "answer = " . answer
  endif
endfunction

" let g:sclangTerm = "st -x $SHELL -ic"
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd set filetype=supercollider
au Filetype supercollider packadd scvim
let g:sclangTerm = "st -e zsh -ic"
let g:scFlash = 1

" Delete without cut
"nnoremap x "_x
"nnoremap d "_d
"nnoremap D "_D
"vnoremap d "_d
"nnoremap c "_c

let g:ale_fixers = {
 \ 'javascript': ['eslint']
 \ }
