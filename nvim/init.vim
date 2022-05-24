" Plugins
call plug#begin()
  Plug 'chriskempson/base16-vim'

  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/playground'
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/nvim-compe'

  Plug 'tomtom/tcomment_vim'
  Plug 'editorconfig/editorconfig-vim'


  " telescope dependencies
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'

  " telescope
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'lewis6991/gitsigns.nvim'
  Plug 'mhartington/formatter.nvim'
  Plug 'hoob3rt/lualine.nvim'
  Plug 'kyazdani42/nvim-web-devicons'
  Plug 'rafamadriz/neon'
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'
  Plug 'tveskag/nvim-blame-line'
call plug#end()

lua << EOF
local nvim_lsp = require('lspconfig')

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
  }
}

require('lualine').setup {
  options = {
    theme = 'auto'
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {
      {
        'filename',
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
      }
    },
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  }
}

nvim_lsp.tsserver.setup{}

require('gitsigns').setup()

require'compe'.setup{
  enabled = true,
  autocomplete = true,
  debug = false,
  min_length = 1,
  preselect = 'disabled',
  throttle_time = 80,
  source_timeout = 200,
  incomplete_delay = 400,
  max_abbr_width = 100,
  max_kind_width = 100,
  max_menu_width = 100,
  documentation = true,
  source = {
    path = true,
    buffer = true,
    calc = true,
    vsnip = true,
    nvim_lsp = true,
    nvim_lua = true,
    spell = true,
    tags = true,
    treesitter = true
  }
}
vim.o.completeopt = "menuone,noselect"

-- Use an on_attach function to only map the following keys 
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "gopls", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup { on_attach = on_attach }
end

nvim_lsp.elixirls.setup{
  cmd = { vim.loop.os_homedir().."/elixir-ls/language_server.sh" },
  capabilities = capabilities,
  on_attach = on_attach
}

EOF

nnoremap <C-f>f <cmd>Telescope git_files<cr>
nnoremap <C-f>F <cmd>Telescope file_browser<cr>
nnoremap <C-f>j <cmd>Telescope jumplist<cr>
nnoremap <C-f>r <cmd>Telescope oldfiles<cr>
nnoremap <C-f>g <cmd>Telescope live_grep<cr>
nnoremap <C-f>b <cmd>Telescope buffers<cr>
nnoremap <C-f>h <cmd>Telescope help_tags<cr>

syntax on
set termguicolors
set background=dark
colorscheme base16-nord
"highlight Normal guibg=black guifg=white

set mouse=a
set number relativenumber
set autoindent
set tabstop=2
set shiftwidth=2
set smarttab
set softtabstop
set expandtab
set nohlsearch
set wildmode=longest,list
set wildmenu
set laststatus=2

" Case-insensitive search
set ignorecase

" Highlight search results
set hlsearch



set selection=exclusive
"nnoremap <silent> p "+p
map <leader>rt gg=G
map <leader>tn :tabnew<cr>
map <leader>ws :StripWhitespace<cr>


" formatter
lua <<EOF
require('formatter').setup({
  logging = false,
  filetype = {
    javascript = {
        -- prettier
       function()
          return {
            exe = "prettier",
            args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
            stdin = true
          }
        end
    },
    elixir = {
       function()
          return {
            exe = "mix",
            args = {"format", "-"},
            stdin = true
          }
        end
    },
  }
})
EOF
nnoremap <silent> <leader>f :Format<CR>

let g:mapleader = ","
inoremap jj <esc>
cnoremap W<CR> :w<CR>

autocmd BufEnter * EnableBlameLine
let g:blameLineVirtualTextFormat = '   %s'
let g:blameLineGitFormat = '%an | %ar | %s | %h'
