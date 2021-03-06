set nocompatible
filetype on


set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
" original repos on github
Plugin 'airblade/vim-gitgutter'
"Plugin 'cespare/vim-toml'
Plugin 'elixir-lang/vim-elixir'
"Plugin 'groenewege/vim-less'
"Plugin 'Shougo/neocomplete.vim'
"Plugin 'marijnh/tern_for_vim'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'millermedeiros/vim-esformatter'
Plugin 'Raimondi/delimitMate'
Plugin 'Chiel92/vim-autoformat'
Plugin 'jnwhiteh/vim-golang'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'kchmck/vim-coffee-script'
Plugin 'ngmy/vim-rubocop'
let g:ackprg = 'ag --vimgrep'
Plugin 'mileszs/ack.vim'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'moll/vim-node'
Plugin 'mutexkid/nerdtree'
Plugin 'YankRing.vim'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
"Plugin 'wookiehangover/jshint.vim'
Plugin 'junegunn/vim-easy-align'
" Use gem-ctags to generate CTags for all gems in the Bundle
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-ragtag'
let g:rails_ctags_arguments = '--languages=-javascript --exclude=tmp'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-ruby/vim-ruby'
Plugin 'wincent/Command-T'

call vundle#end()
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" BASIC EDITING CONFIGURATION
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allow unsaved background buffers and remember marks/undo for them
"set re=1
set hidden
" Remember more commands and search history
set history=10000
set lazyredraw
" Tab defaults
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set autoindent
"set foldmethod=syntax
set nofoldenable
" Insert only one space when joining lines that contain sentence-terminating
" punctuation like `.`, `?`, and `!`.
set nojoinspaces
set norelativenumber
set nocursorline
set nocursorcolumn
syntax sync minlines=256
set showmatch
set incsearch
set hlsearch
" Case-insensitive searching
set ignorecase
" Unless expression contains a capital letter.
set smartcase
set mouse=a
set ruler
set number
" Highlight current line
set cursorline
set title
set switchbuf=useopen
set winwidth=79
set shell=zsh
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
"set t_ti= t_te=
" Show 3 lines of context around the cursor.
set scrolloff=3
set nobackup
set nowritebackup
"set backupdir=./tmp,$HOME/.vim/tmp/,$TEMP/,.
"set directory=./tmp,$HOME/.vim/tmp/,$TEMP/,.
set tags^=./tmp/tags
" Intuitive backspacing in insert mode.
set backspace=indent,eol,start
" custom whitespace characters
set listchars=tab:▸\ ,eol:¬,trail:☹,extends:>,precedes:<
" Display incomplete commands.
set showcmd
" sane split directions
set splitright
set splitbelow
" Set to auto read when a file is changed from the outside
set autoread
" No beeping.
set visualbell
" Spell checking, including automagically for git & markdown
set spellfile=$HOME/.vim/spell/en.utf-8.add
autocmd FileType gitcommit,markdown setlocal spell
autocmd FileType gitcommit,markdown set complete+=kspell

let g:syntastic_javascript_jshint_args = '--config /Users/joshskeen/.jshintrc'
let g:syntastic_javascript_checkers = ['jshint']

autocmd BufWinLeave * call clearmatches()
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
set wildmode=list:longest
set wildignore+=tmp,bower_components,dist,node_modules
" make tab completion for files/buffers act like bash
set wildmenu


let g:vimrubocop_keymap=0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CUSTOM AUTOCMDS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!
  autocmd FileType text setlocal textwidth=78
  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  "for ruby, autoindent with two spaces, always expand tabs
  autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
  autocmd FileType python set sw=4 sts=4 et
  autocmd FileType go setlocal noexpandtab

augroup END

" Zoom / Restore window.
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COLORS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let the terminal determine the colors to use
set background=dark
if has("gui_running") || &t_Co >= 256
  :color molokai
else
  set t_Co=16     " every terminal I use supports at least 16, right?
  :color solarized  " a 16-color safe theme
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline=[%n]     "current buffer number
set statusline+=\ %f    "tail of the filename

"display a warning if fileformat isn't Unix
set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

"display a warning if file encoding isn't utf-8
set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=\ %h      "help file flag
set statusline+=%w      "preview
set statusline+=%y      "filetype
set statusline+=%r      "read only flag
set statusline+=%m      "modified flag
"set statusline+=%{rvm#statusline()}
set statusline+=\ %{fugitive#statusline()}

"display a warning if &et is wrong, or we have mixed-indenting
set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%#error#
set statusline+=%{StatuslineTrailingSpaceWarning()}
set statusline+=%*

"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set autoread
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_signs=1
let g:syntastic_ruby_checkers = ['mri']

"display a warning if &paste is set
set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file
set laststatus=2        " Show the status line all the time
"hi CursorLine cterm=none ctermbg=black

"recalculate the trailing whitespace warning when idle, and after saving
autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

"return '[\s]' if trailing white space is detected
"return '' otherwise
function! StatuslineTrailingSpaceWarning()
  if !exists("b:statusline_trailing_space_warning")
    if search('\s\+$', 'nw') != 0
      let b:statusline_trailing_space_warning = '[\s]'
    else
      let b:statusline_trailing_space_warning = ''
    endif
  endif
  return b:statusline_trailing_space_warning
endfunction

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
  let name = synIDattr(synID(line('.'),col('.'),1),'name')
  if name == ''
    return ''
  else
    return '[' . name . ']'
  endif
endfunction

"recalculate the tab warning flag when idle and after writing
autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

"return '[&et]' if &et is set wrong
"return '[mixed-indenting]' if spaces and tabs are used to indent
"return an empty string if everything is fine
function! StatuslineTabWarning()
  if !exists("b:statusline_tab_warning")
    let tabs = search('^\t', 'nw') != 0
    let spaces = search('^ ', 'nw') != 0

    if tabs && spaces
      let b:statusline_tab_warning =  '[mixed-indenting]'
    elseif (spaces && !&et) || (tabs && &et)
      let b:statusline_tab_warning = '[&et]'
    else
      let b:statusline_tab_warning = ''
    endif
  endif
  return b:statusline_tab_warning
endfunction

function! FileEncodingAndBomb()
  let enc = (&fenc=="" ? &enc : &fenc)
  let bomb = ((exists("+bomb")) && &bomb) ? ",B" : ""
  return '['.enc.bomb.']'
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<tab>"
  else
    return "\<c-p>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""
" OPEN FILES IN DIRECTORY OF CURRENT FILE
" """"""""""""""""""""""""""""""""""""""""""""""
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%
let mapleader=","


"""""""""""""""
"""""""KEYMAPS!
"""""""""""""""
"Seriously, it's not like :W is bound to anything anyway.
command! W :w

" redo with U
nmap U :redo<cr>

" easy wrap toggling
nmap <Leader>w :set wrap<cr>
nmap <Leader>W :set nowrap<cr>
nmap <Leader>E :ZoomToggle<cr>

nmap<Leader>0 :w<cr>:RuboCop --auto-correct<cr>
" move around splits with ctrl+movement
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" resize the window by 5 lines/columns
nnoremap <S-left> :vertical resize -5<cr>
nnoremap <S-down> :resize -5<cr>
nnoremap <S-up> :resize +5<cr>
nnoremap <S-right> :vertical resize +5<cr>

" swap windows
nmap gS <C-W><C-R>

" close all other windows (in the current tab)
nmap gW :only<cr>

" Reopen the last buffer in the current window
nnoremap <leader><leader> <c-^>

" keep .swp files in tmp dir
set swapfile
set dir=~/tmp

" NERDTree
map <Leader>n :NERDTreeToggle<cr>
noremap <F5> :CommandTFlush<CR>

" previous/next buffer (for going without tabs)
nmap g[ :bp<cr>
nmap g] :bn<cr>

" ack for project-wide searching (TRAILING WHITESPACE IS INTENTIONAL)

nmap g/ :Ack!
nmap g* :Ack! -w <C-R><C-W>
nmap gA :AckAdd!
nmap gj :cnext<cr>
nmap gk :cprev<cr>
nmap gc :ccl<cr>
"
nmap <Leader>$ !ripper-tags -R --exclude=vendor

vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

" search and replace the word under the cursor
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/
" rapidly toggle `set list`
nmap <leader>l :set list!<CR>
set guioptions+=a
" clear up trailing white space
nmap <leader>s :%s/\s\+$//<CR>
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" insert blank lines without going into insert mode
nmap go o<esc>
nmap gO O<esc>
" Bubble single lines (uses unimpaired.vim)
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" scroll up/down one line at a time
nmap <Up> <C-Y>
nmap <Down> <C-E>
" scroll up/down 3 lines at a time
nnoremap <C-Y> 3<C-Y>
nnoremap <C-E> 3<C-E>


" scroll left/right
nmap <Left> zh
nmap <Right> zl

nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
" Insert mode
inoremap <C-j> <ESC>:m .+1<CR>==gi
inoremap <C-k> <ESC>:m .-2<CR>==gi
" Visual mode
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" TAB CONTROLS
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"map <leader>tn :tabnew<cr>:NERDTreeFind
nmap <Leader>R :NERDTreeFind<CR>
"map <leader>to :tabonly<cr>
"map <leader>tm :tabmove
"map <leader>t] :tabnext<cr>
"map <leader>t[ :tabprev<cr>

set clipboard=unnamed

let NERDTreeShowHidden=1
nnoremap <silent> gs i<cr><esc>k$:s/\s\+$//e <bar> noh<cr>j^
nnoremap <silent> gS mZj:s/^\s\+//e <bar> noh<cr>^yg_kA <esc>pjdd`Z
"LETS DO THIS
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
"arrow keys from home row
" In all modes!
imap ˙ <Left>
imap ∆ <Down>
imap ˚ <Up>
imap ¬ <Right>
set ttimeout
set ttimeoutlen=250
set notimeout

:nmap <F1> <nop>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER MACROS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
runtime macros/matchit.vim

highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

"match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
hi NonText cterm=NONE ctermfg=NONE

augroup CommandTExtension
  autocmd!
  autocmd FocusGained * CommandTFlush
  autocmd BufWritePost * CommandTFlush
augroup END

" remove search hilighting
nmap <silent> <Leader>h :silent :nohlsearch<CR>
nnoremap <silent> <leader>F :Esformatter<CR>
au BufNewFile,BufRead *.es6 set filetype=javascript
set complete-=i
let g:gitgutter_max_signs = 5000
nnoremap Q <Nop>
