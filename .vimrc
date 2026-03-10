" ============================================================================
" Bootstrap vim-plug (auto-install on any system)
" ============================================================================
let s:data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(s:data_dir . '/autoload/plug.vim'))
    silent execute '!curl -fLo ' . s:data_dir . '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | source $MYVIMRC | endif

" ============================================================================
" Plugins
" ============================================================================
call plug#begin()
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'

    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-vinegar'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-commentary'

    Plug 'qpkorr/vim-bufkill'
    Plug 'jiangmiao/auto-pairs'
    Plug 'ervandew/supertab'
    Plug 'ap/vim-css-color'
    Plug 'mhinz/vim-signify'
    Plug 'mbbill/undotree'
    Plug 'wellle/targets.vim'

    Plug 'fatih/vim-go'
    Plug 'rust-lang/rust.vim'
call plug#end()

" ============================================================================
" General
" ============================================================================
set nocompatible
set encoding=utf8
filetype plugin indent on
set nobackup noswapfile nowritebackup
set shortmess=aoOtIF
set backspace=indent,eol,start
set clipboard^=unnamed,unnamedplus
set autochdir
set hidden
set laststatus=2
set belloff=all
set scrolloff=8
set wildmenu
set wildmode=longest:full,full
set signcolumn=yes

if has('persistent_undo')
    let &undodir = expand('~/.vim/undo-dir')
    if !isdirectory(&undodir) | call mkdir(&undodir, 'p') | endif
    set undofile
endif

" ============================================================================
" Search
" ============================================================================
set incsearch
set nohlsearch
set ignorecase
set smartcase

" ============================================================================
" Interface
" ============================================================================
if has('syntax') | syntax enable | endif
set background=dark
if has('termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif
set number
set cursorline
set fillchars+=vert:│

" ============================================================================
" Indentation
" ============================================================================
set tabstop=4
set shiftwidth=4
set softtabstop=0
set autoindent
set expandtab
set smarttab

" ============================================================================
" Splits & Tabs
" ============================================================================
set splitbelow
set splitright

" ============================================================================
" Keybindings
" ============================================================================
let mapleader=' '

" Escape
imap jk <ESC>
nmap <Del> <Esc>
vmap <Del> <Esc>gV
omap <Del> <Esc>
cmap <Del> <C-C><Esc>
imap <Del> <Esc>`^
tmap <Del> <C-\><C-n>

" Splits
map <Leader>v :vsp<CR>
map <Leader>h :sp<CR>
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>
tmap <C-J> <C-W><C-J>
tmap <C-K> <C-W><C-K>
tmap <C-L> <C-W><C-L>
tmap <C-H> <C-W><C-H>
tmap <C-N> <C-W>N
nmap <C-down> <C-w><
nmap <C-up> <C-w>>
nmap <M-,> <C-w>R
nmap <Leader>0 <C-W>\|
nmap <Leader>- <C-W>_
nmap <Leader>= <C-W>=
nmap <Leader>T <C-W>T

" Tabs
nmap <leader>1 1gt
nmap <leader>2 2gt
nmap <leader>3 3gt
nmap <leader>4 4gt
nmap <leader>5 5gt
nmap <leader>6 6gt
nmap <leader>7 7gt
nmap <leader>8 8gt
nmap <leader>9 9gt
nmap <C-right> :tabnext<CR><CR>
nmap <C-left> :tabprevious<CR><CR>
nnoremap <leader>m :tab<Space>
nmap <leader>n :tabnew<CR>

" Terminal
if has('terminal')
    nmap <C-t> :tab terminal<CR>
    nmap <M-t> :vert terminal<CR>
    tmap <C-p> <C-W>"+
endif

" General
nmap <Leader>rc :e $MYVIMRC<CR>
nmap <Leader>Rc :tabe $MYVIMRC<CR>
nmap <Leader>rv :source $MYVIMRC<CR>
nmap <Leader>w :up<CR>
nmap <Leader>q :q<CR>
nmap <silent> <Leader>db :BD<CR>
nmap <Leader>c zz
nmap gF <C-W>gf

" Improved motions
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap J mzJ`z

" Move lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Stay in visual after indent
vnoremap < <gv
vnoremap > >gv

" Platform file explorer
if has('win32')  | nmap <Leader>e :!start explorer /select,%:p<CR><CR> | endif
if has('unix')   | nmap <Leader>e :!thunar .<CR><CR>                  | endif

" Netrw
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
nmap <Leader>V :Vex!<CR>
nmap <Leader>H :Sex<CR>
nmap <Leader>y :Tex<CR>

" ============================================================================
" Plugin: fzf
" ============================================================================
nmap <silent> <Leader>F :Files ~<CR>
nmap <silent> <Leader>f :Files %:p:h<CR>
nmap <silent> <Leader>g :Files ../<CR>
nmap <Leader>b :Buffers<CR>
nmap <Leader>a :Rg<CR>
let g:fzf_layout = { 'down': '50%' }

" ============================================================================
" Plugin: fugitive
" ============================================================================
nmap <Leader>Ga :Git add %:p<CR><CR>
nmap <Leader>Gs :G<CR>
nmap <Leader>Gc :Git commit -v -q<CR>
nmap <Leader>Gt :Git commit -v -q %:p<CR>
nmap <Leader>Gd :Git diff<CR>
nmap <Leader>Ge :Git edit<CR>
nmap <Leader>Gr :Git read<CR>
nmap <Leader>Gw :Git write<CR><CR>
nmap <Leader>Gl :silent! Git log<CR>:bot copen<CR>
nmap <Leader>Gp :Git grep<Space>
nmap <Leader>Gm :Git move<Space>
nmap <Leader>Gb :Git branch<Space>
nmap <Leader>Go :Git checkout<Space>
nmap <Leader>Gps :Git push<CR>
nmap <Leader>Gpl :Git pull<CR>

" ============================================================================
" Plugin: undotree
" ============================================================================
nmap <Leader>u :UndotreeToggle<CR>

" ============================================================================
" Language: Go
" ============================================================================
let g:go_fmt_command = 'goimports'
let g:go_def_mapping_enabled = 0

augroup ft_go
    autocmd!
    autocmd FileType go nmap <buffer> <M-m> :w<CR>:!clear; go run %<CR>
    autocmd FileType go nmap <buffer> <M-n> :w<CR>:!clear; go run .<CR>
    autocmd FileType go nmap <buffer> gd :GoDef<CR>
    autocmd FileType go nmap <buffer> gD :vsp<bar>GoDef<CR>
augroup END

" ============================================================================
" GUI
" ============================================================================
if has('gui_running')
    set guifont=FiraMono_NF:h14:W500
    set guioptions-=m guioptions-=T guioptions-=r guioptions-=L guioptions-=e
    autocmd GUIEnter * set belloff=all
    autocmd GUIEnter * simalt ~x
endif

" ============================================================================
" Tabline
" ============================================================================
set showtabline=2
set tabline=%!MyTabLine()

function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        let s .= (i + 1 == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#')
        let s .= '%' . (i + 1) . 'T %{MyTabLabel(' . (i + 1) . ')} '
    endfor
    return s . '%#TabLineFill#%T'
endfunction

function! MyTabLabel(n)
    let l:name = bufname(tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1])
    return empty(l:name) ? '[No Name]' : fnamemodify(l:name, ':t')
endfunction

" ============================================================================
" Cursor shape (line in insert, block in normal)
" ============================================================================
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" ============================================================================
" Terminal alt-key fix (Linux/Gnome)
" ============================================================================
if !has('gui_running') && !has('nvim')
    let s:c = 'a'
    while s:c <= 'z'
        exec 'set <A-' . s:c . ">=\e" . s:c
        exec "imap \e" . s:c . ' <A-' . s:c . '>'
        let s:c = nr2char(1+char2nr(s:c))
    endwhile
endif
set timeout ttimeoutlen=50

" ============================================================================
" Colorscheme: s9 (modified ayu dark)
" ============================================================================
hi clear
if exists('syntax_on') | syntax reset | endif

let s:p = {
    \ 'bg':        '#00000a',
    \ 'comment':   '#5C6773',
    \ 'markup':    '#F07178',
    \ 'constant':  '#FFEE99',
    \ 'operator':  '#E7C547',
    \ 'tag':       '#36A3D9',
    \ 'regexp':    '#95E6CB',
    \ 'string':    '#86B300',
    \ 'function':  '#FFB454',
    \ 'special':   '#E6B673',
    \ 'keyword':   '#FF7733',
    \ 'error':     '#FF3333',
    \ 'accent':    '#F29718',
    \ 'panel':     '#14191F',
    \ 'guide':     '#2D3640',
    \ 'line':      '#151A1E',
    \ 'selection': '#253340',
    \ 'fg':        '#E6E1CF',
    \ 'fg_idle':   '#3E4B59',
    \ }

function! s:hi(group, fg, bg, fmt)
    let l:cmd = 'hi! ' . a:group
    let l:cmd .= ' guifg=' . (a:fg ==# '' ? 'NONE' : s:p[a:fg])
    let l:cmd .= ' guibg=' . (a:bg ==# '' ? 'NONE' : s:p[a:bg])
    let l:cmd .= ' gui='   . (a:fmt ==# '' ? 'NONE' : a:fmt)
    let l:cmd .= ' cterm=' . (a:fmt ==# '' ? 'NONE' : a:fmt)
    exe l:cmd
endfunction

" Editor
call s:hi('Normal',           'fg',      'bg',        '')
call s:hi('ColorColumn',      '',        'line',      '')
call s:hi('CursorColumn',     '',        'line',      '')
call s:hi('CursorLine',       '',        'line',      '')
call s:hi('CursorLineNr',     'accent',  'line',      '')
call s:hi('LineNr',           'guide',   '',          '')
call s:hi('Directory',        'fg_idle', '',          '')
call s:hi('DiffAdd',          'string',  'panel',     '')
call s:hi('DiffChange',       'tag',     'panel',     '')
call s:hi('DiffText',         'fg',      'panel',     '')
call s:hi('ErrorMsg',         'fg',      'error',     'standout')
call s:hi('VertSplit',        'bg',      '',          '')
call s:hi('Folded',           'fg_idle', 'panel',     '')
call s:hi('FoldColumn',       '',        'panel',     '')
call s:hi('SignColumn',       '',        'panel',     '')
call s:hi('MatchParen',       'fg',      'bg',        'underline')
call s:hi('ModeMsg',          'string',  '',          '')
call s:hi('MoreMsg',          'string',  '',          '')
call s:hi('NonText',          'guide',   '',          '')
call s:hi('Pmenu',            'fg',      'selection', '')
call s:hi('PmenuSel',         'fg',      'selection', 'reverse')
call s:hi('Question',         'string',  '',          '')
call s:hi('Search',           'bg',      'constant',  '')
call s:hi('SpecialKey',       'selection','',         '')
call s:hi('SpellCap',         'tag',     '',          'underline')
call s:hi('SpellLocal',       'keyword', '',          'underline')
call s:hi('SpellBad',         'error',   '',          'underline')
call s:hi('SpellRare',        'regexp',  '',          'underline')
call s:hi('StatusLine',       'fg',      'panel',     '')
call s:hi('StatusLineNC',     'fg_idle', 'panel',     '')
call s:hi('StatusLineTerm',   'bg',      'function',  '')
call s:hi('StatusLineTermNC', 'fg_idle', 'panel',     '')
call s:hi('WildMenu',         'bg',      'markup',    '')
call s:hi('TabLine',          'fg',      '',          '')
call s:hi('TabLineFill',      'bg',      '',          '')
call s:hi('TabLineSel',       'bg',      'function',  '')
call s:hi('Title',            'keyword', '',          '')
call s:hi('Visual',           '',        'selection', '')
call s:hi('WarningMsg',       'error',   '',          '')

" Syntax
call s:hi('Comment',     'comment',  '', '')
call s:hi('Constant',    'constant', '', '')
call s:hi('String',      'string',   '', '')
call s:hi('Identifier',  'tag',      '', '')
call s:hi('Function',    'function', '', '')
call s:hi('Statement',   'keyword',  '', '')
call s:hi('Operator',    'operator', '', '')
call s:hi('PreProc',     'special',  '', '')
call s:hi('Type',        'tag',      '', '')
call s:hi('Structure',   'special',  '', '')
call s:hi('Special',     'special',  '', '')
call s:hi('Underlined',  'tag',      '', 'underline')
call s:hi('Error',       'fg',       'error', '')
call s:hi('Todo',        'markup',   '', '')
call s:hi('qfLineNr',    'keyword',  '', '')
call s:hi('Conceal',     'guide',    '', '')
call s:hi('CursorLineConceal', 'guide', 'line', '')
hi! Ignore guifg=NONE guibg=NONE gui=NONE cterm=NONE
hi  LongLineWarning guifg=NONE guibg=#371F1C gui=underline cterm=underline

" Terminal colors
let g:terminal_ansi_colors = [
    \ s:p.bg,      s:p.markup,  s:p.string,  s:p.accent,
    \ s:p.tag,     s:p.constant,s:p.regexp,  '#FFFFFF',
    \ s:p.fg_idle, s:p.error,   s:p.string,  s:p.accent,
    \ s:p.tag,     s:p.constant,s:p.regexp,  s:p.comment,
    \ ]
