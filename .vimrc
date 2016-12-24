set nocompatible " be iMproved, required
filetype off " required
let mapleader = ","

au BufEnter /private/tmp/crontab.* setl backupcopy=yes

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

    " Per project vimrc files
    Plugin 'LucHermitte/lh-vim-lib'
    Plugin 'LucHermitte/local_vimrc'

    Plugin 'vimwiki/vimwiki'

    Plugin 'tomtom/tcomment_vim'
    Plugin 'tpope/vim-vinegar'
    Plugin 'jacoborus/tender'
    Plugin 'valloric/youcompleteme'
    Plugin 'gmarik/Vundle.vim'
    Plugin 'bling/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'scrooloose/syntastic'
    Plugin 'chriskempson/base16-vim'
    Plugin 'elzr/vim-json'
    Plugin 'tpope/vim-surround'
    Plugin 'kien/ctrlp.vim'
    Plugin 'ervandew/supertab'
    Plugin 'mattn/emmet-vim'
    Plugin 'junegunn/vim-easy-align'

    Plugin 'fatih/vim-go'
    Plugin 'shawncplus/phpcomplete.vim'
    Plugin 'chrisbra/csv.vim'

    Plugin 'pangloss/vim-javascript'
    Plugin 'mxw/vim-jsx'

    Plugin 'MarcWeber/vim-addon-mw-utils'
    Plugin 'tomtom/tlib_vim'
    Plugin 'garbas/vim-snipmate'
    Plugin 'honza/vim-snippets'

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
set nowrap
set textwidth=79
set formatoptions=qrn1
" Highlight lines over 80 characters
highlight OverLength ctermbg=lightgrey ctermfg=black guibg=#FFD9D9
match OverLength /\%81v.\+/

" Command completion
set wildmenu
set wildmode=longest:full,full

" Enable powerline symbols
let g:Powerline_symbols = 'fancy'
set encoding=utf-8

" Turn on syntax highlighting, auto indent
syntax on
filetype plugin indent on

" Make searches case-sensitive only if they contain upper-case characters
set hlsearch
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

nnoremap <leader>c :!ctags -R -f ./.git/tags .

map <leader>tn :tabnew<cr>

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
set termguicolors
let base16colorspace=256
set background=dark
colorscheme base16-tomorrow-night
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" Switch between relative and no relative number in command/insert
set relativenumber
set number

" Don't show scroll bars in the GUI
set guioptions-=L
set guioptions-=r

" Maps jj to <esc>
inoremap jj <esc>
map <c-f> :CtrlPClearAllCaches <enter>

" Laravel Blade Syntax
au BufRead,BufNewFile *.blade.php set filetype=html
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" Ctrlp config
let g:ctrlp_custom_ignore = '\.git$\|\.o$\|\.app$\|\.beam$\|\.dSYM\|\.ipa$\|\.csv\|tags\|public\/images$\|public\/uploads$\|log\|tmp$\|source_maps\|app\/assets\/images\|test\/reports\|node_modules\|bower_components\|vendor'

" Allow ctrlp to use git to list files, makes it faster.
"let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files --exclude-standard -co']
let g:ctrlp_user_command = 'rg %s --files -g ""'

let g:syntastic_mode_map={ 'mode': 'active', 'active_filetypes': [], 'passive_filetypes': ['html', 'css', 'scss'] }

command! W :w
nnoremap <Leader>t :! phpunit <CR>
nnoremap <silent><leader>p :call PhpCsFixerFixFile()<CR>
nnoremap <Leader>b :! vendor/bin/behat --append-snippets <CR>

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" Include project's local vim config
if filereadable(expand("./.vimrc.local"))
    source ./.vimrc.local
endif

autocmd FileType yml setlocal shiftwidth=2 tabstop=2 expandtab

command! -complete=shellcmd -nargs=+ Shell call s:RunShellCommand(<q-args>)
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

" Golang things
au FileType go nmap <Leader>gd <Plug>(go-doc)
autocmd BufWritePost *.go :GoLint
"let g:SuperTabDefaultCompletionType = "context"
let g:javascript_enable_domhtmlcss = 1

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
"
" " Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
vmap <Leader>su ! awk '{ print length(), $0 \| "sort -n \| cut -d\\  -f2-" }'<cr>

" JSX Highlighting in .js files
let g:jsx_ext_required = 0

nnoremap <Leader>nt :! npm test <CR>

autocmd FileType go nmap <leader>gb  <Plug>(go-build)
autocmd FileType go nmap <leader>gr  <Plug>(go-run)
autocmd FileType go nmap <leader>gt  <Plug>(go-test)

set autowrite

let g:javascript_conceal_function = "ƒ"
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:ycm_path_to_python_interpreter = "/usr/local/bin/python"
set tags=./tags;/

" Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'base16_tomorrow'
let g:netrw_liststyle=3
