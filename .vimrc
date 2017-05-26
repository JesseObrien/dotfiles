" Loads of this was inspired by https://github.com/mcandre/dotfiles/blob/master/.vimrc

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.local/share/nvim/plugged')

  " Any valid git URL is allowed
  "Plug 'https://github.com/junegunn/vim-github-dashboard.git'
  Plug 'junegunn/vim-easy-align'
  Plug 'honza/vim-snippets'

  " Allow commenting
  Plug 'tomtom/tcomment_vim'

  " vimproc
  Plug 'Shougo/vimproc.vim', {'do' : 'make'}

  " Color schemes
  Plug 'flazz/vim-colorschemes'

  " Support editorconfig files
  Plug 'editorconfig/editorconfig-vim'

  " Scratch
  Plug 'mtth/scratch.vim'

  " Airline
  Plug 'bling/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'tpope/vim-surround'
  Plug 'vim-syntastic/syntastic'

  " Autocomplete
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  "Plug 'zchee/deoplete-go', { 'do': 'make'}

  " Javascript related plugins
  Plug 'pangloss/vim-javascript'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'leafgarland/typescript-vim'
  "Plug 'carlitux/deoplete-ternjs', { 'do': 'yarn add global tern' }
  Plug 'Quramy/tsuquyomi'
  "Plug 'Shougo/unite.vim'
  "Plug 'mhartington/vim-typings'

  Plug 'mattn/emmet-vim'

  " Go related plugins
  Plug 'fatih/vim-go'
  Plug 'nsf/gocode'

  " Plugin outside ~/.vim/plugged with post-update hook
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'junegunn/fzf.vim'
  " {{{
    let g:fzf_nvim_statusline = 0 " disable statusline overwriting

    nnoremap <silent> <c-p> :Files<CR>
    nnoremap <silent> <leader><space> :Files<CR>
    nnoremap <silent> <leader>a :Buffers<CR>
    nnoremap <silent> <leader>A :Windows<CR>
    nnoremap <silent> <leader>; :BLines<CR>
    nnoremap <silent> <leader>o :BTags<CR>
    nnoremap <silent> <leader>O :Tags<CR>
    nnoremap <silent> <leader>? :History<CR>
    nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>
    nnoremap <silent> <leader>. :AgIn

    nnoremap <silent> K :call SearchWordWithAg()<CR>
    vnoremap <silent> K :call SearchVisualSelectionWithAg()<CR>
    nnoremap <silent> <leader>gl :Commits<CR>
    nnoremap <silent> <leader>ga :BCommits<CR>
    nnoremap <silent> <leader>ft :Filetypes<CR>

    imap <C-x><C-f> <plug>(fzf-complete-file-ag)
    imap <C-x><C-l> <plug>(fzf-complete-line)

    function! SearchWordWithAg()
      execute 'Ag' expand('<cword>')
    endfunction

    function! SearchVisualSelectionWithAg() range
      let old_reg = getreg('"')
      let old_regtype = getregtype('"')
      let old_clipboard = &clipboard
      set clipboard&
      normal! ""gvy
      let selection = getreg('"')
      call setreg('"', old_reg, old_regtype)
      let &clipboard = old_clipboard
      execute 'Ag' selection
    endfunction

    function! SearchWithAgInDirectory(...)
      call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
    endfunction
    command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)
  " }}}

  " Unmanaged plugin (manually installed and updated)
  Plug '~/my-prototype-plugin'

" Initialize plugin system
call plug#end()



""""""""""""""""""" CUSTOM CONFIG """""""""""""""""""

let g:mapleader = ","
inoremap jj <esc>

" Fix Delete (backspace) on Mac OS X
set backspace=2

" Enable syntax highlighting
syntax on

" Indentation
set autoindent
filetype plugin indent on

set clipboard=unnamed

if has("mouse")
   set mouse=a
endif

" Bash-style tab completion
set wildmode=longest,list
set wildmenu


" Fix trailing selection on visual copy/cut
set selection=exclusive

" Keep selection on visual yank
" vnoremap <silent> y ygv

nnoremap <silent> p "+p


" Disable comment continuation on paste
" autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Show line numbers
set number
set relativenumber

" Show statusline
set laststatus=2

" Case-insensitive search
set ignorecase

" Highlight search results
set hlsearch

" Default to soft tabs, 2 spaces
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4

" Tabbing exceptions
autocmd FileType mkd setlocal sw=4 sts=0 ts=4 expandtab
autocmd FileType php setlocal sw=4 sts=0 ts=4 expandtab
autocmd FileType javascript setlocal sw=4 sts=0 ts=4 expandtab
autocmd FileType typescript setlocal sw=4 sts=0 ts=4 expandtab

" Color config
set termguicolors
set background=dark
colorscheme Monokai

" Default to Unix LF line endings
set ffs=unix

" Folding
set foldmethod=syntax
set foldcolumn=1
set foldlevelstart=20

let g:vim_markdown_folding_disabled=1 " Markdown
let javaScript_fold=1                 " JavaScript
let perl_fold=1                       " Perl
let php_folding=1                     " PHP
let r_syntax_folding=1                " R
let ruby_fold=1                       " Ruby
let sh_fold_enabled=1                 " sh
let vimsyn_folding='af'               " Vim script
let xml_syntax_folding=1              " XML

" Rename files
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

" Rename files
map <leader>rn :call RenameFile()<cr>
" Retab files
map <leader>rt gg=G

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = 'base16_spacemacs'
let g:netrw_liststyle=3

" Create a new tab using ,tn
map <leader>tn :tabnew<cr>

map <leader>s :Scratch<cr>

" Laravel Blade Syntax
au BufRead,BufNewFile *.blade.php set filetype=html

" Ruby syntax for configs
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" vim-go: Enable goimports on save
let g:go_fmt_command = "goimports"

" JSX Highlighting in .js files
let g:jsx_ext_required = 0

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" Configure fzf to use gitignore files
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Configure scratch to use markdown
let g:scratch_filetype = 'markdown'

" Configure syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_typescript_checkers = ['tsc', 'tslint']
let g:syntastic_quiet_messages = { "type": "style" }
let g:syntastic_go_checkers = ['go']
"let g:tsuquyomi_disable_quickfix = 1
"let g:syntastic_typescript_checkers = ['tsuquyomi']

" Enable omnicomplete
set omnifunc=syntaxcomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" Configure Deoplete
" Start Deoplete at vim startup
let g:deoplete#enable_at_startup = 1
" let g:tern_request_timeout = 1
" let g:tern_show_signature_in_pum = '0'  " This do disable full signature type on autocomplete
"
" "Add extra filetypes
" let g:tern#filetypes = [
"                 \ 'jsx',
"                 \ 'ts',
"                 \ 'javascript.jsx',
"                 \ 'vue',
"                 \ ]
