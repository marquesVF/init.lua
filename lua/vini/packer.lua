--"help", - This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
     -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  
  -- color scheme
  use('folke/tokyonight.nvim')

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate'})

  use('nvim-treesitter/playground')

  use('mbbill/undotree')

  use('tpope/vim-fugitive')

  use({
  'VonHeikemen/lsp-zero.nvim',
      branch = 'v2.x',
      requires = {
        -- LSP Support
        {'neovim/nvim-lspconfig'},             -- Required
        {                                      -- Optional
          'williamboman/mason.nvim',
          run = function()
            pcall(vim.cmd, 'MasonUpdate')
          end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
    }
  })

  use('nvim-tree/nvim-web-devicons')
  use('nvim-tree/nvim-tree.lua')

  use {'romgrk/barbar.nvim', requires = 'nvim-web-devicons'}

  use 'preservim/nerdcommenter'
  use 'maxmellon/vim-jsx-pretty'
  use 'jiangmiao/auto-pairs'
  use 'rafamadriz/friendly-snippets'
  use 'onsails/lspkind.nvim' -- better visual for the autocomplete
  use '/nvim-lualine/lualine.nvim' -- status line
  use '/akinsho/bufferline.nvim'
  use '/glepnir/lspsaga.nvim'
  use 'mhinz/vim-signify'
end)
