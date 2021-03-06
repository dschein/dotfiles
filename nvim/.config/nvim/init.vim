set nocompatible
let mapleader=","
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
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-tbone'
Plug 'francoiscabrol/ranger.vim'
Plug 'vim-scripts/LargeFile'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'scrooloose/syntastic'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-scripts/indentpython'
Plug 'tmhedberg/SimpylFold'
Plug 'nvie/vim-flake8'
Plug 'bronson/vim-trailing-whitespace'
Plug 'christoomey/vim-tmux-navigator'
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'JuliaLang/julia-vim'
Plug 'elmcast/elm-vim'
Plug 'airblade/vim-rooter'
Plug 'rbgrouleff/bclose.vim'  " required by ranger.vim
call plug#end()

abbreviate ipy from IPython import embed; embed()
inoremap jk <Esc>
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
set statusline=%{substitute(getcwd(),'/home/davids','~','')}\ -\ %F%M%R%=%-14.(%l,%c%V%)\ %P
if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif
set cursorline
set hidden
set hlsearch
set nowrapscan
nnoremap <leader>t :%s/\s\+$//e
autocmd Filetype html setlocal ts=4 sts=4 sw=4 omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType javascript setlocal ts=4 sts=4 sw=4
autocmd FileType python setlocal ts=4 sts=4 sw=4
autocmd FileType ruby setlocal ts=2 sts=2 sw=2
autocmd FileType css setlocal ts=4 noet sw=4 omnifunc=csscomplete#CompleteCSS
autocmd bufread *.less set ft=less
autocmd bufread *.md set ft=markdown
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

" Ranger!
map - :call OpenRanger()<CR>

" CtrlSF
let g:ctrlsf_position = 'top'
autocmd FileType ctrlsf highlight ExtraWhitespace ctermbg=None
" nmap     <Leader>f <Plug>CtrlSFPrompt  ... overwritten by plugin so this
" works
autocmd VimEnter * nmap     <Leader>f <Plug>CtrlSFPrompt
vmap     <Leader>f <Plug>CtrlSFVwordPath
vmap     <Leader>F <Plug>CtrlSFVwordExec
nmap     <Leader>n <Plug>CtrlSFCwordPath
nmap     <Leader>p <Plug>CtrlSFPwordPath
nnoremap <Leader>o :CtrlSFOpen<CR>
nnoremap <Leader>t :CtrlSFToggle<CR>

nmap    <Leader>s :write<CR>

" c-w-| to have window take over (if using vsplits). c-w-= to restore. c-w-_ for horizontal splits

" vim-easy-align
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)"

" fzf settings
if has('nvim')
  let $FZF_DEFAULT_OPTS .= ' --inline-info'
endif

nnoremap <silent> <Leader><Leader> :Files<CR>
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
" nnoremap <silent> q: :History:<CR>
" nnoremap <silent> q/ :History/<CR>

inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" ------------------------------------------------------------------
" Solarized Colorscheme Config
" ------------------------------------------------------------------
let g:solarized_contrast="high"    "default value is normal
let g:solarized_visibility="high"    "default value is normal
syntax enable
set background=dark
colorscheme solarized
" ------------------------------------------------------------------
" End Solarized Colorscheme Config
" ------------------------------------------------------------------

nmap <leader>date :read! date +'\%a \%d \%b \%Y'<CR>
