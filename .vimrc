set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf',              {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdtree'
Plug 'wincent/pinnacle'
Plug 'chriskempson/base16-vim'
Plug 'machakann/vim-highlightedyank'
Plug 'SirVer/ultisnips'
Plug 'tpope/vim-unimpaired',
Plug 'tpope/vim-surround',
Plug 'jpalardy/vim-slime'
"Plug 'honza/vim-snippets'
Plug 'Valloric/YouCompleteMe',    {'on': [], 'do': './install.py --clang-completer'}
Plug 'w0rp/ale',                  {'on': []}
Plug 'scrooloose/nerdcommenter',  {'on': []}
Plug 'hdima/python-syntax',       {'on': []}
Plug 'tpope/vim-fugitive',        {'on': []}
Plug 'airblade/vim-gitgutter',    {'on': []}
"Plug 'python-mode/python-mode'
"Plug 'qualiabyte/vim-colorstepper'
"Plug 'flazz/vim-colorschemes'
call plug#end()

augroup DeferredPlugins
    autocmd!
    autocmd CursorHold,CursorHoldI * call plug#load('YouCompleteMe')
    autocmd CursorHold,CursorHoldI * call plug#load('ale')
    autocmd CursorHold,CursorHoldI * call plug#load('nerdcommenter')
    autocmd CursorHold,CursorHoldI * call plug#load('python-syntax')
    autocmd CursorHold,CursorHoldI * call plug#load('vim-fugitive')
    autocmd CursorHold,CursorHoldI * call plug#load('vim-gitgutter')
augroup end

filetype plugin indent on
syntax on

" ------------------------------------------------------------------------------
"  Global options
" ------------------------------------------------------------------------------

" Allow modified buffers in the background
set hidden

" Use the clipboard register '*' by default
set clipboard=unnamed

" Wrap settings
set nowrap
set breakindent
set breakindentopt=shift:2

" Default fold level
set foldlevel=2

" Default textwidth
set tw=100  " Default textwidth

" Avoid that vim is resizing other windows when closing one
set noequalalways

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
" set relativenumber

" Search options
set hlsearch
set ignorecase
set smartcase
set inccommand=split

" Use decimal number format, always
set nrformats=

" Enable mouse in all modes
set mouse=a

" Timeout settings
set timeoutlen=750
set ttimeoutlen=0

" Time until CursorHold/CursorHoldI events
set updatetime=2000

" Color scheme
let g:airline_theme='minimalist'
colors base16-tomorrow-night
if has('unix') && has('termguicolors')
  " Workaround for wrong/green colors on Linux. However, this messes up the background color. See
  " - https://github.com/chriskempson/base16-vim/issues/110
  " - https://github.com/chriskempson/base16-vim#green-line-numbers
  set termguicolors
endif

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

"Ultisnips
let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsEditSplit="vertical"
"https://github.com/SirVer/ultisnips/issues/711
let g:UltiSnipsSnippetDirectories = ['~/.vim/UltiSnips', 'UltiSnips']


" ALE
let g:ale_python_flake8_options='--ignore=E501'
nmap [w <Plug>(ale_previous)
nmap ]w <Plug>(ale_next)

" fzf
" See https://github.com/junegunn/fzf.vim#global-options
let g:fzf_history_dir = '~/.local/share/fzf-history'
nnoremap <silent> <leader>f :Files<cr>
nnoremap <silent> <leader>l :Lines<cr>
nnoremap <silent> <leader>, :History<cr>
nnoremap <silent> <leader>c :Commits<cr>
nnoremap <silent> <leader>; :Buffers<cr>
nnoremap <silent> <leader>a :Ag<cr>
command! -bang -nargs=* Ag
  \ call fzf#vim#ag(<q-args>,
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
  \                 <bang>0)

" YCM
let g:ycm_python_binary_path='python'
let g:ycm_max_num_candidates=20
let g:ycm_auto_trigger=1
let g:ycm_complete_in_comments=0
let g:ycm_collect_identifiers_from_comments_and_strings=1
let g:ycm_always_populate_location_list = 1
nnoremap <silent> <leader>d :YcmCompleter GetDoc<cr>
nnoremap <silent> <leader>g :YcmCompleter GoTo<cr>

" python-syntax
let python_highlight_all1=1

" highlighted-yank
let g:highlightedyank_highlight_duration=400

" Nerdtree
map <leader>n :NERDTreeToggle<CR>

" vim-slime
if has('nvim')
  let g:slime_target = "neovim"
else
  let g:slime_target = "vim-terminal"
end
let g:slime_dont_ask_default = 1
let g:slime_no_mappings = 1
let g:slime_python_ipython = 1

function! SlimeReplPython() abort
  vsplit | enew | call termopen('ipython')
  execute 'normal!' . "\<c-w>p"
endfunction

nnoremap <silent> <leader>R :call SlimeReplPython()<cr>
xmap <silent> <leader>r <Plug>SlimeRegionSend
nmap <silent> <leader>r <Plug>SlimeParagraphSend

" Keep track of last accessed terminal for vim-slime
let g:last_terminal_job_id = -1
augroup vim-slime
  autocmd!
  autocmd BufLeave term://* let g:last_terminal_job_id = b:terminal_job_id
  autocmd WinEnter,BufWinEnter * let b:slime_config = {"jobid": g:last_terminal_job_id}
augroup END

" ------------------------------------------------------------------------------
"  Mappings
" ------------------------------------------------------------------------------

" Highlight search results without changing the cursor position
nnoremap <silent> * :let @/='\<<C-r><C-w>\>' \| :set hlsearch<cr>

" Disabled search highlighting
nnoremap <silent> <expr> <cr> empty(&buftype) ? ':nohlsearch<cr>' : '<cr>'

" Replace word under cursow
nnoremap <leader>s :%s/\<<C-r><C-w>\>//g<Left><Left>

" Quick write session with F2, restore with F3
map <F2> :mksession! .vim_session<cr>
map <F3> :source .vim_session<cr>

" Window splits
noremap <silent> <leader>W<left>  :topleft  vnew<cr>
noremap <silent> <leader>W<right> :botright vnew<cr>
noremap <silent> <leader>W<up>    :topleft  new<cr>
noremap <silent> <leader>W<down>  :botright new<cr>

" Buffer splits
noremap <silent> <leader>w<left>   :leftabove  vnew<cr>
noremap <silent> <leader>w<right>  :rightbelow vnew<cr>
noremap <silent> <leader>w<up>     :leftabove  new<cr>
noremap <silent> <leader>w<down>   :rightbelow new<cr>

" Move lines up or down
vnoremap <S-j> :m '>+1<cr>gv=gv
vnoremap <S-k> :m '<-2<cr>gv=gv

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

" "Zoom" current windwow, i.e. open in a new tab
nnoremap <leader>z :tabe %<cr>

" Open files in the same directory
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>

" Don't loose selection when indenting blocks of code
vnoremap < <gv
vnoremap > >gv

" Use Tab to navigate buffers (in normal mode tab doesn't do anything)
nnoremap <silent> <Tab> :bnext!<CR>
nnoremap <silent> <S-Tab> :bprev!<CR>

" Quick-close window/buffer
nnoremap <leader>e :close<cr>
nnoremap <leader>E :bdelete<cr>

" Insert CWD in command line
cnoremap %% <c-r>=fnameescape(expand('%:h')).'/'<cr>

" Open vimrc in vertical split
nnoremap <leader>V :80vsp ~/.vimrc<cr>

" Leave terminal mode with ESC
tnoremap <Esc> <C-\><C-N>
tnoremap <C-v><Esc> <Esc>

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

augroup vimrc
  autocmd!

  " Automatically source .vimrc on save
  autocmd BufWritePost .vimrc source %

  " Automatically remove trailing whitespace before saving
  autocmd BufWritePre * %s/\s\+$//e

  " Highlight current line in current window
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline

  " Cursorline in focused window
  autocmd BufEnter,FocusGained,VimEnter,WinEnter * let &l:colorcolumn='+' . join(range(1, 254), ',+')
  autocmd FocusLost,WinLeave * let &l:colorcolumn=join(range(1,255), ',')

  " Automatically check for filesystem changes outside vim
  autocmd BufEnter,FocusGained * :silent! !

  " Autowrite
  autocmd FocusLost,WinLeave * :silent! noautocmd update

  " Fzf
  autocmd  FileType fzf tnoremap <buffer> <Esc> <Esc>
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

