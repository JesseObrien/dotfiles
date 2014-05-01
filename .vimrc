" Use Vim settings
set nocompatible

" Pathogen!
call pathogen#infect()

" Syntastic settings
" Enable the status line
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Let the :Error window pop up automatically
let g:syntastic_auto_loc_list=1
let g:syntastic_auto_jump=1

" Turn the ruler on
set ruler

" Timeout for leader commands
set timeoutlen=500

set linespace=3

set incsearch
set hlsearch

set wrap
set textwidth=79
set formatoptions=qrn1


" Command completion
set wildmenu
set wildmode=list:longest


" Enable powerline symbols
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256

" Turn on syntax highlighting, auto indent
syntax on
filetype plugin indent on

" Make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase

" Move all backups to one directory
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

set backspace=indent,eol,start

" Tab settings and autoindent
set tabstop=4
set shiftwidth=4
"set softtabstop=4
set noexpandtab
set autoindent

set laststatus=2
set showmatch
set incsearch

" Solarized colorscheme
set background=dark
colorscheme solarized


" Line numbers
set number

" Switch between relative and no relative number in command/insert
au FocusLost * :set norelativenumber
au FocusGained * :set relativenumber
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber


" Don't show scroll bars in the GUI
set guioptions-=L
set guioptions-=r

" Use tab for auto complete
function! SuperTab()
    if (strpart(getline('.'),col('.')-2,1)=~'^\W\?$')
        return "\<Tab>"
    else
        return "\<C-n>"
    endif
endfunction
imap <Tab> <C-R>=SuperTab()<CR>

" Maps jj to <esc>
inoremap jj <esc>
map <c-f> :CtrlPClearAllCaches <enter>

" Laravel Blade Syntax
au BufRead,BufNewFile *.blade.php set filetype=html

" Let syntastic passively assess html files
let g:syntastic_mode_map={ 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['html'] }
let g:ctrlp_custom_ignore = { 'dir': 'vendor' }

command! W :w
let mapleader=","
nnoremap <Leader>t :! ./vendor/bin/phpunit <CR>
