set nocompatible
filetype plugin indent on
syntax on

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'
"Plug 'python-mode/python-mode'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'qualiabyte/vim-colorstepper'
Plug 'chriskempson/base16-vim'
Plug 'zcesur/slimux'
Plug 'scrooloose/nerdcommenter'
Plug 'hdima/python-syntax'
"Plug 'flazz/vim-colorschemes'
Plug 'wincent/pinnacle'
call plug#end()

" ------------------------------------------------------------------------------
"  Global options
" ------------------------------------------------------------------------------

set hidden

" Wrap with indent
set wrap
set breakindent
set breakindentopt=shift:2

" Default textwidth
set tw=100  " Default textwidth

" Avoid that vim is resizing other windows when closing one
set noea

" Do not update the screen during macro playback
set lazyredraw

" Persistent undo
set undofile
set undodir=~/.vim/undodir

" Set mapleader
let mapleader="\<space>"
nnoremap <space> <nop>

" Enable line numbers
set number
set relativenumber

" Search options
set hlsearch
nnoremap <expr> <cr> empty(&buftype) ? ':nohlsearch<cr>' : '<cr>'
set ignorecase
set smartcase

" Highlight search results without changing the cursor position
nnoremap * :let @/='\<<C-r><C-w>\>' \| :hlsearch<cr>

" Replace word under cursow
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Use decimal number format, always
set nrformats=

" Enable mouse in all modes
set mouse=a

" Make vim more responsive (default 1000)
set timeoutlen=500

" Set color scheme
let g:airline_theme='minimalist'
colors base16-ocean
set termguicolors  " see https://github.com/chriskempson/base16-vim/issues/110

" Use `ColorColumn` color for EndOfBuffer
let eob_color=pinnacle#extract_bg('ColorColumn')
let eob_highlight=pinnacle#highlight({'bg': eob_color, 'fg': eob_color})
execute 'highlight EndOfBuffer ' . eob_highlight

" Tab settings
set expandtab
set shiftwidth=2
set softtabstop=2

" Open splits to the right and below
set splitbelow
set splitright

" Whitespace settings
set list
set listchars=nbsp:⦸
set listchars+=tab:▷┅
set listchars+=trail:•
set listchars+=extends:»
set listchars+=precedes:«

set nojoinspaces

" ------------------------------------------------------------------------------
"  Plugin settings
" ------------------------------------------------------------------------------

" Slimux
nnoremap <Leader>r :SlimuxREPLSendLine<cr>
vnoremap <Leader>r :SlimuxREPLSendSelection<cr>
nnoremap <Leader>B :SlimuxREPLSendBuffer<cr>

" ALE
let g:ale_python_flake8_options='--ignore=E501'
nmap [w <Plug>(ale_previous)
nmap ]w <Plug>(ale_next)

" fzf
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>b :BLines<cr>
nnoremap <silent> <leader>l :Lines<cr>
nnoremap <silent> <leader>h :Helptags<cr>
nnoremap <silent> <leader>c :Commits<cr>
nnoremap <silent> <leader>; :Buffers<cr>
nnoremap <silent> <leader>a :Ag<cr>

" YCM
let g:ycm_python_binary_path='python'
let g:ycm_max_num_candidates=20
let g:ycm_auto_trigger=1
let g:ycm_complete_in_comments=0
let g:ycm_collect_identifiers_from_comments_and_strings=1
nnoremap <silent> <leader>d :YcmCompleter GetDoc<cr>
nnoremap <silent> <leader>g :YcmCompleter GoTo<cr>

" python-syntax
let python_highlight_all1=1

" ------------------------------------------------------------------------------
"  Mappings
" ------------------------------------------------------------------------------

" Quick write session with F2, restore with F3
map <F2> :mksession! ~/.vim_session<cr>
map <F3> :source ~/.vim_session<cr>

" Window splits
noremap <leader>sw<left>  :topleft  vnew<cr>
noremap <leader>sw<right> :botright vnew<cr>
noremap <leader>sw<up>    :topleft  new<cr>
noremap <leader>sw<down>  :botright new<cr>

" Buffer splits
noremap <leader>s<left>   :leftabove  vnew<cr>
noremap <leader>s<right>  :rightbelow vnew<cr>
noremap <leader>s<up>     :leftabove  new<cr>
noremap <leader>s<down>   :rightbelow new<cr>

" Move lines up or down
nnoremap <S-j> :m+1<cr>==
nnoremap <S-k> :m-2<cr>==
vnoremap <S-j> :m '>+1<cr>gv=gv
vnoremap <S-k> :m '<-2<cr>gv=gv

" Join lines
nnoremap <leader>j :join<cr>
vnoremap <leader>j :join<cr>

" Open/close fold
nnoremap <S-tab> za

" Avoid unintentionally entering Ex mode
nmap Q q

" Yank to the end of the line
noremap Y y$

"Move between windows in the same tab
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-left> <C-w>h
noremap <C-down> <C-w>j
noremap <C-up> <C-w>k
noremap <C-right> <C-w>l

" Open files in the same directory
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

" Don't loose selection when indenting blocks of code
vnoremap < <gv
vnoremap > >gv

" Move between tabs
noremap <leader>w gt
noremap <leader>q gT
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9ga

" Quick-close file
nnoremap <leader>e :close<cr>
nnoremap <leader>E :close!<cr>

" Insert CWD in command line
cnoremap %% <c-r>=fnameescape(expand('%:h')).'/'<cr>

" Open vimrc in vertical split
nnoremap <leader>V :80vsp ~/.vimrc<cr>

" ------------------------------------------------------------------------------
"  Functions
" ------------------------------------------------------------------------------

" Diff the buffer against the last saved file
function! s:DiffWithSaved()
  let filetype=&ft
  diffthis
  vnew | r # | normal! 1Gdd
  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

" Helper for python debugging
func! s:SetBreakpoint()
    cal append(line('.')-1, repeat(' ', strlen(matchstr(getline('.'), '^\s*'))) . 'import ipdb; ipdb.set_trace()')
endf

func! s:RemoveBreakpoint()
    exe 'silent! g/^\s*import\sipdb\;\?\n*\s*ipdb.set_trace()/d'
endf

func! s:ToggleBreakpoint()
    if getline('.')=~#'^\s*import\sipdb' | cal s:RemoveBreakpoint() | el | cal s:SetBreakpoint() | en
endf

nnoremap <F6> :call <SID>ToggleBreakpoint()<cr>

" ------------------------------------------------------------------------------
"  Autocomds
" ------------------------------------------------------------------------------

if has ("autocmd")
  augroup vimrc
    autocmd!

    " Automatically source .vimrc on save
    autocmd BufWritePost .vimrc source %

    " Automatically remove trailing whitespace before saving
    autocmd BufWritePre * %s/\s\+$//e

    " Highlight current line in current window
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline

    " Cursorline in focused window
    autocmd BufEnter,FocusGained,VimEnter,WinEnter * let &l:colorcolumn='+' . join(range(1, 254), ',+')
    autocmd FocusLost,WinLeave * let &l:colorcolumn=join(range(1,255), ',')

  augroup END
endif
