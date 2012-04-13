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
set smarttab                    " insert tabs on the start of a line according to
                                "    shiftwidth, not tabstop
set scrolloff=4                 " keep 4 lines off the edges of the screen when scrolling
set virtualedit=all             " allow the cursor to go in to "invalid" places
set hlsearch                    " highlight search terms
set incsearch                   " show search matches as you type

set list                        " show invisible chars
set listchars=tab:>.,trail:.,extends:#,nbsp:.

set termencoding=utf-8
set encoding=utf-8

set history=1000                " remember more commands and search history
set undolevels=1000             " use many muchos levels of undo
set nobackup                    " do not keep backup files, it's 70's style cluttering
set noswapfile                  " do not write annoying intermediate swap files,
                                "    who did ever restore from swap files anyway?
set wildmenu                    " make tab completion for files/buffers act like bash
set wildmode=list:longest       " show a list when pressing tab and complete first full match
set wildignore=*.swp,*.bak,*.pyc,*.class

set visualbell                  " don't beep
set noerrorbells                " don't beep
set showcmd                     " show (partial) command in the last line of the screen
                                "    this also shows visual selection info
set nomodeline                  " disable mode lines (security measure)

set showtabline=2               " always show tabline

set synmaxcol=256               " Syntax coloring lines that are too long just slows down the world

set stl=%f\ %m\ %r%=%c\ %l\ [%p%%]\ %L

set cpoptions=ces$

" Toggle paste mode
nmap  ,p :set invpaste:set paste?
" Set text wrapping toggles
nmap  ,w :set invwrap:set wrap?

nmap ,t :tabe <C-r>=expand('%:p:h')<CR>/

" Avoid accidental hits of <F1> while aiming for <Esc>
map! <F1> <Esc>

" Quickly close the current window
nnoremap q :q<CR>

" make p in Visual mode replace the selected text with the yank register
vnoremap p <Esc>:let current_reg = @"<CR>gvdi<C-R>=current_reg<CR><Esc>

" Use ,d (or ,dd or ,dj or 20,dd) to delete a line without adding it to the
" yanked stack (also, in visual mode)
nmap <silent> ,d "_d
vmap <silent> ,d "_d

" Clears the search register
nmap <silent> ,/ :nohlsearch<CR>

" Sudo to write
cmap w!! w !sudo tee % >/dev/null

" Strip all trailing whitespace from a file, using ,w
nnoremap ,w :%s/\s\+$//<cr>:let @/=''<CR>

" highlight conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" shortcut to jump to next conflict marker
nmap <silent> ,c /^\(<\\|=\\|>\)\{7\}\([^=].\+\)\?$<CR>

nmap <space> za

syntax on

if (&t_Co > 16)
    colorscheme lucius
else
    colorscheme default
endif

filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'git://github.com/mattn/zencoding-vim.git'
Bundle 'git://github.com/pangloss/vim-javascript.git'
Bundle 'git://github.com/othree/html5.vim.git'
Bundle 'git://github.com/miripiruni/csscomb-for-vim.git'

filetype plugin indent on

let g:user_zen_expandabbr_key = '§'
let g:user_zen_settings = {
\  'indentation': '    ',
\  'javascript': {
\      'snippets': {
\          'cla': 'console.log(arguments);',
\          'cl': 'console.log(|);',
\          'cd': 'console.dir(|);',
\          'cdx': 'console.dirxml(|);',
\          'ct': 'console.time(|);',
\          'cte': 'console.timeEnd(|);',
\          'jstr': 'JSON.stringify(|);'
\      }
\   },
\   'xsl': {
\       'extends': 'html',
\       'snippets': {
\           '!': '<!-- | -->'
\       },
\       'default_attributes': {
\           'tm': [{'match': ''}],
\           'tmm': [{'match': ''}, {'mode': ''}],
\           'if': {'test': ''},
\           'when': {'test': ''},
\           'vn': [{'name': ''}],
\           'vns': [{'name': ''}, {'select': ''}],
\           'wpn': [{'name': ''}],
\           'wpns': [{'name': ''}, {'select': ''}],
\           'pn': [{'name': ''}],
\           'pns': [{'name': ''}, {'select': ''}],
\           'vos': {'select': ''},
\           'atn': {'name': ''},
\           'ats': [{'select': ''}],
\           'atsm': [{'select': ''}, {'mode': ''}]
\       },
\       'aliases': {
\           'tm': 'xsl:template',
\           'tmm': 'xsl:template',
\           'if': 'xsl:if',
\           'when': 'xsl:when',
\           'vn': 'xsl:variable',
\           'vns': 'xsl:variable',
\           'wpn': 'xsl:with-param',
\           'wpns': 'xsl:with-param',
\           'pn': 'xsl:param',
\           'pns': 'xsl:param',
\           'vos': 'xsl:value-of',
\           'atn': 'xsl:attribute',
\           'ats' : 'xsl:apply-templates',
\           'atsm' : 'xsl:apply-templates',
\           'tt': 'xsl:text'
\       },
\       'expandos': {
\           'ch': 'xsl:choose>when+xsl:otherwise'
\       },
\       'empty_elements': 'vos'
\   }
\}


" For all text files set 'textwidth' to 78 characters.
autocmd FileType text setlocal textwidth=78
" clone comment leader on "Return" or "o"
autocmd FileType javascript setlocal fo+=ro

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
autocmd BufReadPost *
\ if line("'\"") > 0 && line("'\"") <= line("$") |
\   exe "normal g`\"" |
\ endif
