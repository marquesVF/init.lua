--"help", - This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  -- color scheme
  use('folke/tokyonight.nvim')
  use 'Mofiqul/vscode.nvim'
  -- end of color schemes

  -- project tree
  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('nvim-treesitter/playground')
  -- end project tree

  -- session management
  use('/rmagatti/auto-session')
  -- end session management

  use('mbbill/undotree')

  -- git related
  use('tpope/vim-fugitive')
  use('tveskag/nvim-blame-line')
  -- end git related

  -- autocompletion
  use({
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
    }
  })

  use('nvim-tree/nvim-web-devicons')
  use('nvim-tree/nvim-tree.lua')

  use { 'romgrk/barbar.nvim', requires = 'nvim-web-devicons' }

  use 'preservim/nerdcommenter'
  use 'maxmellon/vim-jsx-pretty'
  use 'jiangmiao/auto-pairs'
  use 'rafamadriz/friendly-snippets'
  use 'onsails/lspkind.nvim'       -- better visual for the autocomplete
  use '/nvim-lualine/lualine.nvim' -- status line
  use '/akinsho/bufferline.nvim'
  use '/glepnir/lspsaga.nvim'
  use 'mhinz/vim-signify'
  use 'Pocco81/auto-save.nvim'

  -- pop-up preview for references, implementations, etc
  use {
    'rmagatti/goto-preview',
    config = function()
      require('goto-preview').setup {}
    end
  }

  -- for coding stats
  use 'wakatime/vim-wakatime'

  -- for Rust Only
  use 'neovim/nvim-lspconfig'
  use 'simrat39/rust-tools.nvim'

  -- Debugging
  use 'nvim-lua/plenary.nvim'
  use 'mfussenegger/nvim-dap' -- Debug Adapter Protocol (inspect application state - jester dep)
  use 'David-Kunz/jester' -- run and debug jest tests
end)
