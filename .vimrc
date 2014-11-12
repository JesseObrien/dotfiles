set nocompatible              " be iMproved, required
filetype off                  " required
let mapleader = ","

function! LoadVundle()
    let vundle_installed=filereadable(expand('~/.vim/bundle/vundle/README.md'))

    if vundle_installed == 0
        echo "Creating backups directory..."
        silent !mkdir -p ~/.vim/backups
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    endif

    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()

    Plugin 'gmarik/Vundle.vim'
    Plugin 'bling/vim-airline'
    Plugin 'tpope/vim-fugitive'
    Plugin 'scrooloose/syntastic'
    Plugin 'chriskempson/base16-vim'
    Plugin 'chriskempson/vim-tomorrow-theme'
    Plugin 'elzr/vim-json'
    Plugin 'tpope/vim-surround'
    Plugin 'xsbeats/vim-blade'
    Plugin 'kien/ctrlp.vim'
    Plugin 'SuperTab'
    Plugin 'Tabular'
    Plugin 'fatih/vim-go'
    Plugin 'mattn/emmet-vim'

    if vundle_installed==0
        echo vundle_installed
        echo "Vundle Installed, now Installing Bundles..."
        echo ""
        :BundleInstall
        silent !make -C ~/.vim/bundle/vimproc.vim
    endif

    filetype plugin indent on
endfunction

call LoadVundle()

set shell=zsh\ -l

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
set number

set nowrap
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
set hlsearch
set incsearch
set ignorecase
set smartcase
set incsearch
set showcmd
set scrolloff=3

function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>rn :call RenameFile()<cr>

" Highlight lines over 80 characters
highlight OverLength ctermbg=lightgrey ctermfg=black guibg=#FFD9D9
match OverLength /\%81v.\+/

" Move all backups to one directory
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set backspace=indent,eol,start

" Tab settings and autoindent
set tabstop=4
set shiftwidth=4
"set softtabstop=4
set expandtab
set autoindent
set smartindent

set laststatus=2
set showmatch

" Solarized colorscheme
set t_Co=256
set background=dark
colorscheme base16-tomorrow


" Line numbers

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
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby
let g:ctrlp_custom_ignore = '\.git$\|\.o$\|\.app$\|\.beam$\|\.dSYM\|\.ipa$\|\.csv\|tags\|public\/images$\|public\/uploads$\|log\|tmp$\|source_maps\|app\/assets\/images\|test\/reports\|node_modules\|bower_components\|vendor'

let g:syntastic_mode_map={ 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['html'] }

command! W :w
nnoremap <Leader>t :! phpunit <CR>
nnoremap <Leader>p :! phpspec run <CR>

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" Include project's local vim config
if filereadable(expand("./.vimrc.local"))
    source ./.vimrc.local
endif


