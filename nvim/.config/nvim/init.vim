set nocompatible
let mapleader=" "
" set init.vim/vimrc depending on whether using vim or neovim
if has('nvim')
    let s:editor_root=expand("~/.nvim")
    nnoremap <leader>v :e ~/.config/nvim/init.vim
    nnoremap <leader>V :so ~/.config/nvim/init.vim
else
    let s:editor_root=expand("~/.vim")
    nnoremap <leader>v :e ~/.vimrc
    nnoremap <leader>V :so ~/.vimrc
endif
let &rtp = &rtp . ',' . s:editor_root

" auto-install vim-plug
if empty(glob(s:editor_root . '/autoload/plug.vim'))
    echo "Installing vim-plug."
    echo ""
    execute('silent !curl -fLo ' . s:editor_root . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  autocmd VimEnter * PlugInstall
endif

call plug#begin(s:editor_root . '/bundle')
Plug 'VundleVim/Vundle.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-eunuch'  " gives you :SudoWrite
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'vim-scripts/L9'
Plug 'vim-scripts/FuzzyFinder'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align'
Plug 'scrooloose/syntastic'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-scripts/indentpython'
Plug 'tmhedberg/SimpylFold'
Plug 'nvie/vim-flake8'
Plug 'szw/vim-ctrlspace'
Plug 'bronson/vim-trailing-whitespace'
Plug 'christoomey/vim-tmux-navigator'
Plug 'simnalamburt/vim-mundo'
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'JuliaLang/julia-vim'
Plug 'elmcast/elm-vim'
call plug#end()

abbreviate ipy from IPython import embed; embed()
inoremap jj <Esc>
nmap Y y$
set showtabline=0
set hidden
let python_highlight_all=1
syntax enable

set ignorecase
set smartcase
set tabstop=4
set shiftwidth=4
set expandtab
set mouse=a
set statusline=%F%M%R
if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif
set cursorline
set hidden
set hlsearch
nnoremap <leader>t :%s/\s\+$//e
autocmd Filetype html setlocal ts=4 sts=4 sw=4 omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType javascript setlocal ts=4 sts=4 sw=4
autocmd FileType python setlocal ts=4 sts=4 sw=4
autocmd FileType ruby setlocal ts=2 sts=2 sw=2
autocmd FileType css setlocal ts=4 noet sw=4 omnifunc=csscomplete#CompleteCSS
autocmd bufread *.less set ft=less
autocmd bufread *.md set ft=markdown

let g:CtrlSpaceSymbols = {"WLoad": "L", "WSave": "S"}
let g:CtrlSpaceLoadLastWorkspaceOnStart = 1
let g:CtrlSpaceSaveWorkspaceOnSwitch = 1
let g:CtrlSpaceSaveWorkspaceOnExit = 1
if executable("ag")
    let g:CtrlSpaceGlobCommand = 'ag -l --nocolor -g ""'
endif

nmap <leader>nt :NERDTree<cr>
nmap <leader>nq :NERDTreeClose<cr>
"
let g:syntastic_check_on_open = 1
"
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'
let g:syntastic_eruby_ruby_quiet_messages =
    \ {"regex": "possibly useless use of a variable in void context"}
"
hi MatchParen cterm=underline

set undofile
set undodir=~/.vim/undo_history
"
" tmux navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>
nnoremap <silent> <A-\> :TmuxNavigatePrevious<cr>

if has('nvim')
    " Terminal settings
    highlight TermCursor ctermfg=3 guifg=red
    nnoremap <Leader><x> :vsplit \| terminal<CR>
    tnoremap <Leader><ESC> <C-\><C-n>
    " This configuration allows using `Alt+{h,j,k,l}` to navigate between windows no
    " matter if they are displaying a normal buffer or a terminal buffer in terminal mode.
    tnoremap <A-h> <C-\><C-n><C-w>h
    tnoremap <A-j> <C-\><C-n><C-w>j
    tnoremap <A-k> <C-\><C-n><C-w>k
    tnoremap <A-l> <C-\><C-n><C-w>l
    "nnoremap <A-h> <C-w>h
    "nnoremap <A-j> <C-w>j
    "nnoremap <A-k> <C-w>k
    "nnoremap <A-l> <C-w>l
    " Enter insert mode in terminal instead of default normal mode.
    :au TermOpen * :startinsert
endif

" CtrlSF
nmap     <Leader>f <Plug>CtrlSFPrompt
vmap     <Leader>f <Plug>CtrlSFVwordPath
vmap     <Leader>F <Plug>CtrlSFVwordExec
nmap     <Leader>n <Plug>CtrlSFCwordPath
nmap     <Leader>p <Plug>CtrlSFPwordPath
nnoremap <Leader>o :CtrlSFOpen<CR>
nnoremap <Leader>t :CtrlSFToggle<CR>

nmap    <Leader>s :write<CR>

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)"
" ------------------------------------------------------------------
" Solarized Colorscheme Config
" ------------------------------------------------------------------
let g:solarized_contrast="high"    "default value is normal
let g:solarized_visibility="high"    "default value is normal
syntax enable
set background=dark
colorscheme solarized

