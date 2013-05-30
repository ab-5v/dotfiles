set nocompatible

set showmode                    " always show what mode we're currently editing in
set nowrap                      " don't wrap lines
set tabstop=4                   " a tab is four spaces
set softtabstop=4               " when hitting <BS>, pretend like a tab is removed, even if spaces
set expandtab                   " expand tabs by default (overloadable per file type later)
set shiftwidth=4                " number of spaces to use for autoindenting
set shiftround                  " use multiple of shiftwidth when indenting with '<' and '>'
set autoindent                  " always set autoindenting on
set copyindent                  " copy the previous indentation on autoindenting
set number                      " always show line numbers
set showmatch                   " set show matching parenthesis
set smarttab                    " insert tabs on the start of a line according to shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set virtualedit=all             " allow the cursor to go in to "invalid" places
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type
set laststatus=2                " Always show the statusline

set list                        " show invisible chars
set listchars=tab:>.,trail:.,extends:#,nbsp:.

set termencoding=utf-8
set encoding=utf-8

set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
set nobackup                    " do not keep backup files, it's 70's style cluttering
set noswapfile                  " do not write annoying intermediate swap files,
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:longest       " show a list when pressing tab and complete first full match
set wildignore=*.swp,*.bak,*.pyc,*.class

set visualbell                  " don't beep
set noerrorbells                " don't beep
set showcmd                     " show (partial) command in the last line of the screen and visual selection info
set nomodeline                  " disable mode lines (security measure)

set tabpagemax=50               " allow to open more than 10 tabs

set showtabline=2               " always show tabline

set synmaxcol=500               " Syntax coloring lines that are too long just slows down the world

set statusline=%f\ %m\ %r%=%c\ %l\ [%p%%]\ %L   " statusline format

" disable arrows
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

let mapleader=","

" Toggle paste mode
nmap <leader>p :set invpaste<CR>
" Set text wrapping toggles
nmap <leader>w :set invwrap<CR>
" Open new tab from the current folder
nmap <leader>t :tabe <C-r>=expand('%:p:h')<CR>/
" Edit file from the current folder
nmap <leader>e :e <C-r>=expand('%:p:h')<CR>/

" remap macro to ,q
nnoremap ,q q

" Quickly close the current window
nnoremap q :q<CR>

" Avoid accidental hits of <F1> while aiming for <Esc>
map! <F1> <Esc>

" Clears the search register
nmap <silent> <leader>/ :nohlsearch<CR>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Strip all trailing whitespace from a file, using ,w
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<CR>

" highlight conflict markers
match ErrorMsg '[<=>]\\{7}.*$'

" shortcut to jump to next conflict marker
nmap <silent> <leader>c /[<=>]\\{7}.*$<CR>

nmap <space> za

syntax on

filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'


Bundle 'Shougo/neosnippet'

Bundle 'wavded/vim-stylus.git'
Bundle 'maksimr/vim-yate.git'
Bundle 'artjock/vim-javascript.git'

filetype plugin indent on

if (&t_Co > 16)
    colorscheme lucius2
else
    colorscheme default
endif

let g:neosnippet#snippets_directory='~/.vim/snippets'
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"


" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78
" clone comment leader on "Return" or "o"
autocmd FileType javascript setlocal fo+=ro

" speed up opening large files
autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f) > 1024*1024 | set eventignore+=FileType | else | set eventignore-=FileType | endif

if exists("+showtabline")
     function MyTabLine()
         let s = ''
         let t = tabpagenr()
         let i = 1
         while i <= tabpagenr('$')
             let buflist = tabpagebuflist(i)
             let winnr = tabpagewinnr(i)
             let s .= '%' . i . 'T'
             let s .= (i == t ? '%1*' : '%2*')
             let s .= ' ' . i
             let s .= ' %*'
             let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
             let file = bufname(buflist[winnr - 1])
             let file = fnamemodify(file, ':p:t')
             if file == ''
                 let file = '[No Name]'
             endif
             let s .= file
             let i = i + 1
         endwhile
         let s .= '%T%#TabLineFill#%='
         let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
         return s
     endfunction
     set stal=2
     set tabline=%!MyTabLine()
endif
