scriptencoding utf-8
source ~/.config/nvim/plugins.vim
"   ____                           _    ___        _   _
"  / ___| ___ _ __   ___ _ __ __ _| |  / _ \ _ __ | |_(_) ___  _ __  ___
" | |  _ / _ \ '_ \ / _ \ '__/ _` | | | | | | '_ \| __| |/ _ \| '_ \/ __|
" | |_| |  __/ | | |  __/ | | (_| | | | |_| | |_) | |_| | (_) | | | \__ \
"  \____|\___|_| |_|\___|_|  \__,_|_|  \___/| .__/ \__|_|\___/|_| |_|___/
"                                           |_|
"
if has ('autocmd') " Remain compatible with earlier versions
  augroup vimrc " Source vim configuration upon save
    autocmd! BufWritePost $MYVIMRC source % | echom "Reloaded " . $MYVIMRC | redraw
    autocmd! BufWritePost $MYGVIMRC if has('gui_running') | so % | echom "Reloaded " . $MYGVIMRC | endif | redraw
  augroup END
endif " has autocmd
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
" Fixes syntax highlighting from stopping
autocmd BufEnter * :syntax sync fromstart | set nohlsearch
autocmd FileType mail set textwidth=0 wrapmargin=0
autocmd BufEnter,BufWinEnter,BufNewFile,BufRead *.jsfx set filetype=eel2

" Alacritty full size
autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID"

au BufNewFile,BufFilePre,BufRead *.md set filetype=markdown | set nospell

"here a function was defined
function! s:twitvim_my_settings()
  "this function just do one thing, set nowrap option. (text is gonna be displayed without wrap.)
  set nowrap
endfunction

let g:vimwiki_list = [{'path': '~/Dropbox/NOTES/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
" Yank and paste with the system clipboard
set clipboard+=unnamedplus
" set transparent background
" Set floating window to be slightly transparent
" Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes
filetype indent on
" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256
set smartcase
set ignorecase
set smartindent
set noswapfile
set nobackup
" this directory needs to be created
set undodir=~/.config/nvim/undodir
" incremental searching
set incsearch
" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set cmdheight=1
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" Splits open at the bottom and right, which is non-retarded, unlike vim defaults.
set splitbelow splitright
" Color
" hi=NONE guibg=NONE ctermbg=NONE
colorscheme dracula
highlight Normal ctermbg=none guibg=none guifg=White
highlight NonText ctermbg=none guibg=none guifg=White
highlight EndOfBuffer ctermbg=none ctermfg=none guibg=none guifg=none
highlight CursorLine ctermbg=Black
highlight SignColumn ctermbg=none guibg=none guifg=White
" set winbl=10
" highlight Normal guibg=none
" highlight NonText guibg=none
" highlight Normal ctermbg=Black
" highlight NonText ctermbg=Black
" set winbl=10

if (has("termguicolors"))
	set termguicolors
endif
"  _  __          _     _           _ _
" | |/ /___ _   _| |__ (_)_ __   __| (_)_ __   __ _ ___
" | ' // _ \ | | | '_ \| | '_ \ / _` | | '_ \ / _` / __|
" | . \  __/ |_| | |_) | | | | | (_| | | | | | (_| \__ \
" |_|\_\___|\__, |_.__/|_|_| |_|\__,_|_|_| |_|\__, |___/
"           |___/                             |___/
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
" nnoremap <silent> <nowait> <leader>l :g/^\s\+$/s/\s\+//<CR><c-o>
" nnoremap <silent> <nowait> <leader>l :%s/\s\+$//e <CR> <bar> %s/\n\{3,}/\r\r/e<CR><c-o>
" tabs
nnoremap <silent> <nowait> <leader><tab> :tabn<CR>
" nnoremap <silent> <nowait> <leader>t :tabedit<CR>
nnoremap <silent> <nowait> <leader>t :s/\v<(.)(\w*)/\u\1\L\2/g<CR>
" vnoremap J :m '>+1<CR>gv=gv
" vnoremap K :m '<-2<CR>gv=gv
" nnoremap <leader>rw :CocSearch <C-R>=expand("<cword>")<CR><CR>
" center matches on screen
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
" Because double pressing key is slow
nmap <silent> <nowait> <leader>d dd
vmap <silent> <nowait> <leader>d dd
nmap <silent> <nowait> <leader>g gg
vmap <silent> <nowait> <leader>g gg
nmap <silent> <nowait> <leader>y yy
vmap <silent> <nowait> <leader>y yy
nmap <silent> <nowait> <leader>z zz
vmap <silent> <nowait> <leader>z zz
" remove previous WORD without exiting insert mode
inoremap <silent> <C-h> <esc>bcaW
" accept suggestion
" inoremap <C-space> <C-y>
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
" remove empty lines in selection
" vmap <leader>e :s/\n\n/\r/g<CR>
" nmap <leader>n <Plug>VimwikiNextLink
" nmap <leader>p <Plug>VimwikiPrevLink
nmap <F13> <Plug>VimwikiNextLink
nmap <F14> <Plug>VimwikiPrevLink
nmap <leader>i <Plug>VimwikiIndex
" nmap <F15> <Plug>VimwikiAddHeaderLevel

" Fugitive bindings
nmap <leader>gs :G<CR>
nmap <leader>gh :diffget //2<CR>
nmap <leader>gl :diffget //3<CR>
" mobile screenshot renaming
let @s='dt_xllla-lla-lllr lla_lla_0j'
let @u='f/;;;lD0jf+f=pldf i l0kddci"~ q€kb'
let @f='5Wdt;ofont-family: pa;k0wWWWWdwjofont-size: pa;kkf/ldwjjofont€kb€kb€kb€kbline-height: pi;kkk0WWWWdw3jofont-weight:a pi;kkkkdd'
" resizing splits
" autocmd VimResized * wincmd =

" autocmd VimResized * :exe 'vertical resize' . float2nr(&columns * 0.5) | exe resize . float2nr(&lines * 0.75)
autocmd WinEnter *.sc,*.scd :exe 'vertical resize' . float2nr(&columns * 0.5) | exe 'resize' . float2nr(&lines * 0.75)
autocmd VimResized *.sc,*.scd :exe 'vertical resize' . float2nr(&columns * 0.5) | exe 'resize' . float2nr(&lines * 0.75)

" autocmd WinResize * :exe 50wincmd |

" autocmd WinResize * 50wincmd
" autocmd WinResize * :exe vertical resize  . float2nr(&columns * 0.5) | exe resize  . float2nr(&lines * 0.75)
" autocmd WinEnter * :call ResizeSplits()
" autocmd WinResize * call ResizeSplits()

nmap <silent> <leader>ww <C-w>=
nnoremap <silent> <leader>wk :exe "resize " . float2nr(&lines * 0.75)<CR>
nnoremap <silent> <leader>wj :exe "resize " . float2nr(&lines * 0.25)<CR>
nnoremap <silent> <leader>w= :res 50<CR>
nmap <silent> <Leader>wh :vertical resize -20<CR>
nmap <silent> <Leader>wl :vertical resize +20<CR>

" exe "vertical resize " . float2nr(&columns * 0.5)

" jump to first / last of paragraph
set whichwrap+=b,s
set virtualedit=onemore
nnoremap { k{<Space>0
vnoremap { k{<Space>0
nnoremap } j}<BS>0
vnoremap } j}<BS>0
"
map <C-p> :Telescope find_files<CR>

"  _   _ _____ ____  ____ _____
" | \ | | ____|  _ \|  _ \_   _| __ ___  ___
" |  \| |  _| | |_) | | | || || '__/ _ \/ _ \
" | |\  | |___|  _ <| |_| || || | |  __/  __/
" |_| \_|_____|_| \_\____/ |_||_|  \___|\___|
"
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
"       _        _
"   ___| |_ _ __| |_ __
"  / __| __| '__| | '_ \
" | (__| |_| |  | | |_) |
"  \___|\__|_|  |_| .__/
"                 |_|
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
"  ____            _         ____      _            _       _
" | __ )  __ _ ___(_) ___   / ___|__ _| | ___ _   _| | __ _| |_ ___  _ __
" |  _ \ / _` / __| |/ __| | |   / _` | |/ __| | | | |/ _` | __/ _ \| '__|
" | |_) | (_| \__ \ | (__  | |__| (_| | | (__| |_| | | (_| | || (_) | |
" |____/ \__,_|___/_|\___|  \____\__,_|_|\___|\__,_|_|\__,_|\__\___/|_|
"
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
"   ____                                           __    ____                      _      _   _
"  / ___|___  _ __   __ _ _   _  ___ _ __    ___  / _|  / ___|___  _ __ ___  _ __ | | ___| |_(_) ___  _ __
" | |   / _ \| '_ \ / _` | | | |/ _ \ '__|  / _ \| |_  | |   / _ \| '_ ` _ \| '_ \| |/ _ \ __| |/ _ \| '_ \
" | |__| (_) | | | | (_| | |_| |  __/ |    | (_) |  _| | |__| (_) | | | | | | |_) | |  __/ |_| | (_) | | | |
"  \____\___/|_| |_|\__, |\__,_|\___|_|     \___/|_|    \____\___/|_| |_| |_| .__/|_|\___|\__|_|\___/|_| |_|
"                      |_|                                                  |_|
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
" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
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

" latex
let g:livepreview_previewer = 'zathura'

"  ____                         ____      _ _ _     _
" / ___| _   _ _ __   ___ _ __ / ___|___ | | (_) __| | ___ _ __
" \___ \| | | | '_ \ / _ \ '__| |   / _ \| | | |/ _` |/ _ \ '__|
"  ___) | |_| | |_) |  __/ |  | |__| (_) | | | | (_| |  __/ |
" |____/ \__,_| .__/ \___|_|   \____\___/|_|_|_|\__,_|\___|_|
"             |_|
"
au BufEnter,BufWinEnter,BufNewFile,BufRead *.sc,*.scd set filetype=supercollider
" au Filetype supercollider packadd scvim
let g:sclangTerm = "st -e zsh -ic"
" let g:scFlash = 1
nmap <silent><nowait> <CR> <Plug>(scnvim-send-block)
vmap <silent><nowait> <CR> <Plug>(scnvim-send-selection)
nmap <silent><nowait> <leader>. <Plug>(scnvim-hard-stop)
" map <silent><nowait> <leader>p <Plug>(scnvim-postwindow-toggle)
map <silent><nowait> <leader>b <Plug>(scnvim-hard-stop)
nmap <silent><nowait> <leader>p <Plug>(scnvim-postwindow-clear)
map <silent><nowait> <leader>s :SCNvimStart<CR>
" vertical 'v' or horizontal 'h' split
let g:scnvim_postwin_orientation = 'h'
" position of the post window 'right' or 'left'
let g:scnvim_postwin_direction = 'right'
" default is half the terminal size for vertical and a third for horizontal
let g:scnvim_postwin_size = 15
" automatically open post window on a SuperCollider error
let g:scnvim_postwin_auto_toggle = 1
" duration of the highlight
let g:scnvim_eval_flash_duration = 25
" set this variable to browse SuperCollider documentation in nvim (requires `pandoc`)
let g:scnvim_scdoc = 1
" number of flashes. A value of 0 disables this feature.
let g:scnvim_eval_flash_repeats = 1
" configure the color
highlight SCNvimEval guifg=black guibg=cyan ctermfg=black ctermbg=cyan
autocmd BufRead,BufWritePre *.sc normal magg=G`a
autocmd BufRead,BufWritePre *.scd normal magg=G`a
" path to the sclang executable
" scnvim will look in some known locations for sclang, but if it can't find it use this variable instead
" (also improves startup time slightly)
let g:scnvim_sclang_executable = ''
" update rate for server info in status line (seconds)
" (don't set this to low or vim will get slow)
let g:scnvim_statusline_interval = 1
" set this variable if you don't want the "echo args" feature
let g:scnvim_echo_args = 0
" set this variable if you don't want any default mappings
let g:scnvim_no_mappings = 1
" set this variable to browse SuperCollider documentation in nvim (requires `pandoc`)
let g:scnvim_scdoc = 1
" pass flags directly to sclang - see help file for more details, caveats, and further examples
let g:scnvim_sclang_options = ['-u', 9999]
" help
let g:scnvim_scdoc_render_prg = '/usr/bin/pandoc'
" let g:scnvim_scdoc_render_args = '% -o %'
"
" tidalcycles
let g:tidal_target = "terminal"
let g:Hexokinase_highlighters = ['backgroundfull']
