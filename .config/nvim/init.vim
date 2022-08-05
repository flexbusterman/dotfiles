scriptencoding utf-8
source ~/.config/nvim/plugins.vim
" options
set cursorline
set nocompatible
set number relativenumber
set smarttab
set cindent
set tabstop=2
set shiftwidth=2
set numberwidth=2
set autoread
set scrolloff=10
set nohlsearch
set clipboard+=unnamedplus
set updatetime=50
" set signcolumn=yes
set shortmess+=c
set t_Co=256
set ignorecase
set smartcase
set smartindent
set noswapfile
" this directory needs to be created
set undodir=~/.config/nvim/undodir
set incsearch
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set shortmess+=c
set signcolumn=number
set splitbelow splitright
set whichwrap+=b,s
set virtualedit=onemore

filetype off
set runtimepath+=/usr/share/lilypond/current/vim/
filetype on
syntax on

colorscheme dracula
if (has("termguicolors"))
	set termguicolors
endif

highlight Normal ctermbg=none guibg=none guifg=White
highlight NonText ctermbg=none guibg=none guifg=White
highlight EndOfBuffer ctermbg=none ctermfg=none guibg=none guifg=none
highlight CursorLine ctermbg=Black
highlight SignColumn ctermbg=none guibg=none guifg=White

augroup vimrc " Source vim configuration upon save
  autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
  autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
augroup END
" Fixes syntax highlighting from stopping
autocmd BufEnter * :syntax sync fromstart | set nohlsearch
autocmd FileType mail set textwidth=0 wrapmargin=0
autocmd BufEnter,BufWinEnter,BufNewFile,BufRead *.jsfx set filetype=eel2
" Alacritty full size
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"
autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown | set nospell

" let g:vimwiki_list = [{'path': '~/Dropbox/NOTES/',
                      " \ 'syntax': 'markdown', 'ext': '.md'}]

"  ____
" |  _ \ ___ _ __ ___   __ _ _ __  ___
" | |_) / _ \ '_ ` _ \ / _` | '_ \/ __|
" |  _ <  __/ | | | | | (_| | |_) \__ \
" |_| \_\___|_| |_| |_|\__,_| .__/|___/
" remaps                    |_|
let mapleader = " "
let g:mapleader = " "
nnoremap <silent> <nowait> <leader>j :w<CR>
vnoremap <silent> <nowait> <leader>j :w<CR>
nnoremap <silent> <nowait> <leader>q <esc>:q!<CR>
vnoremap <silent> <nowait> <leader>q <esc>:q!<CR>
xnoremap <silent> <nowait> <leader>q <esc>:q!<CR>
nnoremap <silent> <nowait> <M-`>:w<CR>
"delete duplicate empty lines
nnoremap <silent> <nowait> <leader>l :g/^\s\+$/s/\s\+//e <CR> <bar> :g/^$/,/./-j<CR><c-o>
" tabs
nnoremap <silent> <nowait> <leader><tab> :tabn<CR>
" Format capitalization to title 
nnoremap <silent> <nowait> <leader>t :s/\v<(.)(\w*)/\u\1\L\2/g<CR>
" center matches on screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
nmap <silent> <nowait> <leader>d dd
vmap <silent> <nowait> <leader>d dd
nmap <silent> <nowait> <leader>g gg
vmap <silent> <nowait> <leader>g gg
nmap <silent> <nowait> <leader>y yy
vmap <silent> <nowait> <leader>y yy
nmap <silent> <nowait> <leader>z zz
vmap <silent> <nowait> <leader>z zz
" remove previous WORD without exiting insert mode
inoremap <silent> <C-h> <esc>bciW
" Quick window switching
nmap <C-h> <C-w>h
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-l> <C-w>l
" nmap <leader>y :StripWhitespace<CR>
nmap <leader>f <Plug>(easymotion-bd-w)
vmap <leader>f <Plug>(easymotion-bd-w)
noremap <F3> :Autoformat<CR>
" * and # search for next/previous of selected text when used in visual mode
xno * :<c-u>cal<SID>VisualSearch()<cr>/<cr>
xno # :<c-u>cal<SID>VisualSearch()<cr>?<cr>
fun! s:VisualSearch()
  let old = @" | norm! gvy
  let @/ = '\V'.substitute(escape(@", '\'), '\n', '\\n', 'g')
  let @" = old
endf
" nmap <F13> <Plug>VimwikiNextLink
" nmap <F14> <Plug>VimwikiPrevLink
" nmap <leader>i <Plug>VimwikiIndex
" Fugitive bindings
nmap <leader>gs :G<CR>
nmap <leader>gh :diffget //2<CR>
nmap <leader>gl :diffget //3<CR>
" window resizing
nmap <silent> <leader>ww <C-w>=
nnoremap <silent> <leader>wk :exe "resize " . float2nr(&lines * 0.75)<CR>
nnoremap <silent> <leader>wj :exe "resize " . float2nr(&lines * 0.25)<CR>
nnoremap <silent> <leader>w= :res 50<CR>
nmap <silent> <Leader>wh :vertical resize -20<CR>
nmap <silent> <Leader>wl :vertical resize +20<CR>
" jump to first / last of paragraph
nnoremap { k{<Space>0
vnoremap { k{<Space>0
nnoremap } j}<BS>0
vnoremap } j}<BS>0
map <C-p> :Telescope find_files<CR>

"  __  __
" |  \/  | __ _  ___ _ __ ___  ___
" | |\/| |/ _` |/ __| '__/ _ \/ __|
" | |  | | (_| | (__| | | (_) \__ \
" |_|  |_|\__,_|\___|_|  \___/|___/
" macros
" mobile screenshot renaming
let @s='dt_xllla-lla-lllr lla_lla_0j'
let @u='f/;;;lD0jf+f=pldf i l0kddci"~ q€kb'
let @f='5Wdt;ofont-family: pa;k0wWWWWdwjofont-size: pa;kkf/ldwjjofont€kb€kb€kb€kbline-height: pi;kkk0WWWWdw3jofont-weight:a pi;kkkkdd'

"  ____  _             _
" |  _ \| |_   _  __ _(_)_ __  ___
" | |_) | | | | |/ _` | | '_ \/ __|
" |  __/| | |_| | (_| | | | | \__ \
" |_|   |_|\__,_|\__, |_|_| |_|___/
" plugins        |___/

" NERDTree
" Add spaces after comment delimiters by default
let NERDSpaceDelims=1
" Show hidden files/directories
let g:NERDTreeShowHidden = 1
" enable line numbers
let NERDTreeShowLineNumbers=1
let NERDTreeMinimalUI=1
let NERDTreeQuitOnOpen = 1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber
let g:NERDTreeGitStatusWithFlags = 0
let g:NERDTreeIgnore = ['^node_modules$']
vmap <leader>; <plug>NERDCommenterToggle
nmap <leader>; <plug>NERDCommenterToggle
nmap <leader>h :NERDTreeToggle<CR>
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
let g:NERDCustomDelimiters = { 'text': { 'left': '"','right': '' } }
let g:NERDCustomDelimiters = { 'html': { 'left': '// ','right': '' } }

" ctrlp
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" basic calculator
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

" CoC - Conquer of Completion
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-vetur',
  \ ]
let g:scnvim_snippet_format = "ultisnips"
let g:UltiSnipsSnippetDirectories = ['UltiSnips', 'scnvim-data']
let g:scnvim_sclang_executable = '/usr/bin/sclang'
" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" Remap for rename current word
nmap <F2> <Plug>(coc-rename)
nmap <leader>k :Prettier<CR>
" Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>a <Plug>(coc-fix-current)
" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)
" Using CocList Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
" inoremap <silent><expr> <TAB>
      " \ pumvisible() ? "\<C-n>" :
      " \ <SID>check_back_space() ? "\<TAB>" :
      " \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
" if has('nvim')
  " inoremap <silent><expr> <c-space> coc#refresh()
" else
  " inoremap <silent><expr> <c-@> coc#refresh()
" endif
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
" nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
" autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>af <Plug>(coc-fix-current)
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <leader>ca  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <leader>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <leader>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <leader>co  :<C-u>CocList outline<cr>
" Search workleader symbols.
nnoremap <silent><nowait> <leader>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <leader>cn  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <leader>cp  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <leader>cr  :<C-u>CocListResume<CR>
" coc snippet bindings
let g:UltiSnipsExpandTrigger='<Nop>'
let g:UltiSnipsJumpForwardTrigger = '<TAB>'
let g:UltiSnipsJumpBackwardTrigger = '<S-TAB>'
let g:coc_snippet_next = '<TAB>'
let g:coc_snippet_prev = '<S-TAB>'

" LaTeX
filetype plugin indent on
syntax enable
let g:vimtex_view_method = 'zathura'

" SuperCollider
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd set filetype=supercollider
" configure the color
highlight SCNvimEval guifg=black guibg=cyan ctermfg=black ctermbg=cyan
autocmd BufRead,BufWritePre *.sc normal magg=G`azt
autocmd BufRead,BufWritePre *.scd normal magg=G`azt
" au Filetype supercollider packadd scvim
let g:sclangTerm = "st -e zsh -ic"
" let g:scFlash = 1
" nmap <silent><nowait> <CR> <Plug>(scnvim-send-block)
" vmap <silent><nowait> <CR> <Plug>(scnvim-send-selection)
" nmap <silent><nowait> <leader>. <Plug>(scnvim-hard-stop)
" map <silent><nowait> <leader>p <Plug>(scnvim-postwindow-toggle)
" map <silent><nowait> <leader>b <Plug>(scnvim-hard-stop)
" nmap <silent><nowait> <leader>p <Plug>(scnvim-postwindow-clear)
map <silent><nowait> <leader>s :SCNvimStart<CR>
lua << EOF
local scnvim = require 'scnvim'
local map = scnvim.map
local map_expr = scnvim.map_expr

scnvim.setup {
 ensure_installed = true,
  sclang = {
    cmd = nil,
    args = {},
  },
  keymaps = {},
  documentation = {
    cmd = nil,
    horizontal = true,
    direction = 'top',
    keymaps = true,
  },
  postwin = {
    highlight = true,
    auto_toggle_error = true,
    scrollback = 5000,
    horizontal = true,
    direction = 'bot',
    size = nil,
    fixed_size = nil,
    keymaps = nil,
    float = {
      enabled = false,
      row = 0,
      col = function()
        return vim.o.columns
      end,
      width = 64,
      height = 14,
      config = {
        border = 'single',
      },
      callback = function(id)
        vim.api.nvim_win_set_option(id, 'winblend', 10)
      end,
    },
  },
  editor = {
    force_ft_supercollider = true,
    highlight = {
      color = 'TermCursor',
      type = 'flash',
      flash = {
        duration = 50,
        repeats = 1,
      },
      fade = {
        duration = 375,
      },
    },
    signature = {
      float = true,
      auto = true,
    },
  },
  snippet = {
    engine = {
      name = 'luasnip',
      options = {
        descriptions = true,
      },
    },
  },
  statusline = {
    poll_interval = 1,
  },
  extensions = {},
  keymaps = {
    ['<leader>f'] = map('editor.send_line', {'i', 'n'}),
    ['f'] = {
      map('editor.send_block', {'i', 'n'}),
      map('editor.send_selection', 'x'),
    },
    ['<leader>t'] = map('postwin.toggle'),
    ['<M-CR>'] = map('postwin.toggle', 'i'),
    ['<leader>p'] = map('postwin.clear', {'n', 'i'}),
    ['<C-k>'] = map('signature.show', {'n', 'i'}),
    ['<leader>.'] = map('sclang.hard_stop', {'n', 'x', 'i'}),
    ['<leader>s'] = map('sclang.start'),
    ['<leader>r'] = map('sclang.recompile'),
    ['<F1>'] = map_expr('s.boot'),
    ['<F2>'] = map_expr('s.meter'),
  },
}
EOF

" vertical 'v' or horizontal 'h' split
" let g:scnvim_postwin_orientation = 'h'
" position of the post window 'right' or 'left'
" let g:scnvim_postwin_direction = 'right'
" default is half the terminal size for vertical and a third for horizontal
" let g:scnvim_postwin_size = 15
" automatically open post window on a SuperCollider error
" let g:scnvim_postwin_auto_toggle = 1
" duration of the highlight
" let g:scnvim_eval_flash_duration = 25
" set this variable to browse SuperCollider documentation in nvim (requires `pandoc`)
" let g:scnvim_scdoc = 1
" number of flashes. A value of 0 disables this feature.
" let g:scnvim_eval_flash_repeats = 1
" path to the sclang executable
" scnvim will look in some known locations for sclang, but if it can't find it use this variable instead
" (also improves startup time slightly)
" let g:scnvim_sclang_executable = ''
" update rate for server info in status line (seconds)
" (don't set this to low or vim will get slow)
" let g:scnvim_statusline_interval = 1
" set this variable if you don't want the "echo args" feature
" let g:scnvim_echo_args = 0
" set this variable if you don't want any default mappings
" let g:scnvim_no_mappings = 1
" set this variable to browse SuperCollider documentation in nvim (requires `pandoc`)
" let g:scnvim_scdoc = 1
" pass flags directly to sclang - see help file for more details, caveats, and further examples
" let g:scnvim_sclang_options = ['-u', 9999]
" help
" let g:scnvim_scdoc_render_prg = '/usr/bin/pandoc'
" let g:scnvim_scdoc_render_args = '% -o %'
"
autocmd BufWritePre *.cpp :silent exec "!make"
autocmd BufWritePre *.ly :silent exec "!./makescore %"
" autocmd BufWritePre avistamagic :silent exec "!./avistamagic"
