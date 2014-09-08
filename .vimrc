set nocompatible                " be iMproved

" Bundle Start
filetype off                    " Required! for vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" Required!
Plugin 'gmarik/Vundle.vim'
" My bundles here:

" Syntax Highlighting
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'
Plugin 'vim-scripts/Wombat'
Plugin 'vim-scripts/wombat256.vim'
Plugin 'vim-scripts/Zenburn'

" Auto functions
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sleuth'
Plugin 'Valloric/YouCompleteMe'

" File Navigation
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'

" Navigation
Plugin 'semihelix/vim-plugin-minibufexpl'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'mbbill/undotree'

" Misc
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'jpalardy/vim-slime.git'

" Visual improvements
Plugin 'bling/vim-airline'
Plugin 'gregsexton/MatchTag'
Plugin 'Rykka/colorv.vim'

call vundle#end()
" End of bundles

" Settings

" Filetype recognition
filetype plugin indent on       " Required!
filetype indent on
filetype plugin on

" Terminal
if !has("gui_running")
  set ttyfast                   " We have fast terminal
  set background=dark
  color elflord

  if &t_Co == 256
    let g:rehash256 = 1         " Improves color of Molokai
    color zenburn
  endif
endif

" GVIM
if has("gui_running")
  set lines=999 columns=999
  set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 10
  color molokai
  " Clean GUI
  set guioptions-=m
  set guioptions-=T
  set guioptions-=r
  set guioptions-=L
  set guioptions-=c
  set guioptions-=a
  " Remove bell
  au GUIEnter * set t_vb=
endif

" Misc
set autoread                    " Check if file has been changed and reloads
set encoding=utf-8
set wildmenu                    " Enable wildmode, commandline autocomplete
set wildmode=full               " Sets behaviour to 'full'
set modelines=5                 " Enable modelines, # vim: option=setting :
set clipboard=unnamed,unnamedplus " Set clipboard to X clipboard

" Display
syntax on                       " Set syntax highlight
set lazyredraw                  " Improves scrolling down/up the screen
set scrolloff=2                 " 2 lines above/below cursor when scrolling
set number                      " Line number
set relativenumber              " Set line numer on
set cursorline                  " Mark current line
set laststatus=2                " Set status line to two rows
set ruler                       " Set position in statusline
set showmode                    " Show INSERT/NORMAL/REPLACE in statusline
set showcmd                     " Show partial command in statusline
set title                       " Set title in console

" Bracket matching
set showmatch                   " Show matching brackets, quick jumps
set matchtime=2                 " Sets time for showmatch default 5

" Tabs
set backspace=indent,eol,start  " Makes backspace behave like it should
set expandtab                   " Insert spaces instead of tabs in insert mode. Use spaces for indents"
set smarttab
set tabstop=8                   " Number of spaces that a <Tab> in the file counts for, 8 is default
set softtabstop=4               " set virtual tab stop (compat for 8-wide tabs)
set autoindent                  " Set indent similiar to line above
set shiftwidth=4                " Number of spaces to use for each step of (auto)indent
set shiftround                  " always round indents to multiple of shiftwidth
set copyindent                  " use existing indents for new indents

" Search option
set ignorecase                  " Case insensitive search
set smartcase                   " but become case sensitive if you type uppercase characters
set incsearch                   " Increamental searching
set hlsearch                    " Highlights search results

" Remove bell and visualbell
set noerrorbells
set visualbell
set t_vb=

" Backup
set nobackup
set nowritebackup
set noswapfile

" History & Undo
set undolevels=1000
set undofile
set undodir=~/.vim/undo         " Set a directory to store the undo history, create manually
set history=1000

" Windows split behavior
set splitright                  " Open new vertical split windows to the right of the current one, not the left.
set splitbelow                  " See above description. Opens new windows below, not above.

" Display trailing whitespace
set list
set listchars=tab:↹·,extends:⇉,precedes:⇇,nbsp:␠,trail:␠,nbsp:␣

" Running Windows
if has ("win32")
  if has("gui_running")
    au GUIEnter * simalt ~x
  endif
  set shell=C:\RailsInstaller\Git\bin\bash.exe\ --login\ -i
endif

" Vim aliases
" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Vim Mappings
let mapleader = ","
let g:mapleader = ","

" Normal modemap
nnoremap <Leader>ev :vs ~/.vimrc<CR>
nnoremap <Leader>sv :so ~/.vimrc<CR>
nnoremap <Leader><Leader> :noh<CR>
nnoremap : ;
nnoremap ; :
nnoremap <Down> o<Esc>
nnoremap <Up> O<Esc>
nnoremap <Leader><Space> i<Space><Esc>

" Window movement not used => tmux nav plugin
"nnoremap <silent> <C-k> :wincmd k<CR>
"nnoremap <silent> <C-j> :wincmd j<CR>
"nnoremap <silent> <C-h> :wincmd h<CR>
"nnoremap <silent> <C-l> :wincmd l<CR>

" Visual modemap
" Indent as many times as you want in visual mode without losing focus
vnoremap < <gv
vnoremap > >gv

" Plugin keybinds
nnoremap <Leader>bd :MBEbd<CR>
nnoremap <Leader>p :CtrlPBuffer<CR>
nnoremap <Leader>m :CtrlPMRU<CR>
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :Tagbar<CR>
nnoremap <F4> :UndotreeToggle<CR>
nnoremap <F5> :MBEToggle<CR>

" Plugin Settings
" Airline enable tabs and dont show buffs, min 2 tabs needed added powerline fonts!
"let g:airline_theme="monochrome"
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tmuxline#enabled = 0
set ttimeoutlen=50              "Get rid of pause when exiting insert mode

" MBE
" Buffers needed to autostart MBE
let g:miniBufExplBuffersNeeded = 0
" Position top
let g:miniBufExplBRSplit=0
"
" MiniBufExpl molokai 256 Colors
" hi MBEChanged guibg=darkblue ctermbg=darkblue termbg=white
if &t_Co == 256 || has("gui_running")
  hi MBENormal               guifg=#808080 guibg=bg ctermfg=244 ctermbg=bg
  hi MBEChanged              guifg=#CD5907 guibg=bg ctermfg=208 ctermbg=bg
  hi MBEVisibleNormal        guifg=#5DC2D6 guibg=bg ctermfg=81 ctermbg=bg
  hi MBEVisibleChanged       guifg=#F1266F guibg=bg ctermfg=199 ctermbg=bg
  hi MBEVisibleActiveNormal  guifg=#A6DB29 guibg=bg ctermfg=118 ctermbg=bg
  hi MBEVisibleActiveChanged guifg=#F1266F guibg=bg ctermfg=199 ctermbg=bg
endif

" Easymotion, set to single leader key
let g:EasyMotion_leader_key = '<Leader>'
let g:EasyMotion_keys = 'abcdefghijklmnopqrstuvwxyz'

" Eclim YCM integration
"let g:EclimCompletionMethod = 'omnifunc'

" NERDTree keybind and autoclose
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" TMUX-Slime
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1"}

" UltiSnips keybinds
let g:UltiSnipsExpandTrigger="<C-J>"
let g:UltiSnipsJumpForwardTrigger="<C-J>"
let g:UltiSnipsJumpBackwardTrigger="<C-K>"

"  TMUX line use powerline font
"let g:tmuxline_powerline_separators = 1
"let g:tmuxline_preset = {
"\'a'    : '#S',
"\'cwin' : ['#I #W'],
"\'win'  : ['#I #W'],
"\'y'    : [' %a %d %b %Y'],
"\'z'    : '#H',
"\'options' : {'status-justify' : 'left'}}

"call tmuxline#api#set_theme({
"\ 'a': ['232', '208', ''],
"\ 'b': ['253', '16', ''],
"\ 'bg': ['240', '234', ''],
"\ 'c': ['253', '238', ''],
"\ 'cwin': ['253', '16', ''],
"\ 'win': ['253', '238', ''],
"\ 'x': ['253', '236', ''],
"\ 'y': ['253', '16', ''],
"\ 'z': ['232', '208', '']})

" VIM functions
if !exists("*TrimWhiteSpace")
  function TrimWhiteSpace()
    %s/\s\+$//e
  endfunction
endif
