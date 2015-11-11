set nocompatible
let mapleader=" "
if has('nvim')
    let s:editor_root=expand("~/.nvim")
    nnoremap <leader>v :e ~/.config/nvim/init.vim
    nnoremap <leader>V :so ~/.config/nvim/init.vim
else
    let s:editor_root=expand("~/.vim")
    nnoremap <leader>v :e ~/.vimrc
    nnoremap <leader>V :so ~/.vimrc
endif
filetype off                  " required for Vundle

let &rtp = &rtp . ',' . s:editor_root . '/bundle/Vundle.vim'
call vundle#begin(s:editor_root . '/bundle')

" Setting up Vundle - the vim plugin bundler
let vundle_installed=1
let vundle_readme=s:editor_root . '/bundle/Vundle.vim/README.md'
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent call mkdir(s:editor_root . '/bundle', "p")
    silent execute "!git clone https://github.com/VundleVim/Vundle.vim.git " . s:editor_root . "/bundle/Vundle.vim"
    let vundle_installed=0
endif
let &rtp = &rtp . ',' . s:editor_root . '/bundle/vundle/'
call vundle#rc(s:editor_root . '/bundle')

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-eunuch'  " gives you :SudoWrite
Plugin 'tpope/vim-abolish'
Plugin 'vim-scripts/L9'
Plugin 'vim-scripts/FuzzyFinder'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'nvie/vim-flake8'
Plugin 'szw/vim-ctrlspace'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'simnalamburt/vim-mundo.git'
Plugin 'editorconfig/editorconfig-vim'

if vundle_installed == 0
    echo "Installing Plugins, please ignore key map error messages"
    echo ""
    :PluginInstall
endif
call vundle#end()            " required
filetype plugin indent on    " required

abbreviate ipy from IPython import embed; embed()
inoremap jj <Esc>
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
autocmd FileType css setlocal ts=4 noet sw=4 omnifunc=csscomplete#CompleteCSS
autocmd bufread *.less set ft=less
autocmd bufread *.md set ft=markdown

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
    highlight TermCursor ctermfg=red guifg=red
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

" ------------------------------------------------------------------
" Solarized Colorscheme Config
" ------------------------------------------------------------------
let g:solarized_contrast="high"    "default value is normal
let g:solarized_visibility="high"    "default value is normal
syntax enable
set background=dark
colorscheme solarized

