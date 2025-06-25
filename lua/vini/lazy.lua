return {
  -- Lazy.nvim can manage itself
  {
    "folke/lazy.nvim",
    version = "*",
  },

  -- Command line UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
  },

  -- Color schemes
  { "folke/tokyonight.nvim" },
  { "Mofiqul/vscode.nvim" },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  { "nvim-treesitter/playground" },

  -- Session management
  { "rmagatti/auto-session" },

  { "mbbill/undotree" },

  -- Git related
  { "tpope/vim-fugitive" },
  { "tveskag/nvim-blame-line" },
  { "tpope/vim-rhubarb" },

  -- LSP and Autocompletion
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" },
      {
        "williamboman/mason.nvim",
        build = function()
          pcall(vim.cmd, "MasonUpdate")
        end,
      },
      { "nvimtools/none-ls.nvim" },

      -- Autocompletion
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "hrsh7th/nvim-cmp" },
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
      },
    },
  },

  -- UI Components
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-tree/nvim-tree.lua" },
  { "romgrk/barbar.nvim", dependencies = "nvim-web-devicons" },
  { "preservim/nerdcommenter" },
  { "maxmellon/vim-jsx-pretty" },
  { "jiangmiao/auto-pairs" },
  { "onsails/lspkind.nvim" },
  { "nvim-lualine/lualine.nvim" },
  { "akinsho/bufferline.nvim" },
  { "glepnir/lspsaga.nvim" },
  { "mhinz/vim-signify" },
  { "Pocco81/auto-save.nvim" },

  -- Preview
  {
    "rmagatti/goto-preview",
    config = function()
      require("goto-preview").setup {}
    end,
  },

  -- Coding stats
  { "wakatime/vim-wakatime" },

  -- Rust
  { "neovim/nvim-lspconfig" },
  { "simrat39/rust-tools.nvim" },

  -- Debugging
  { "nvim-lua/plenary.nvim" },
  { "mfussenegger/nvim-dap" },
  { "David-Kunz/jester" },

  -- File system
  { "stevearc/oil.nvim" },

  { "MunifTanjim/prettier.nvim" },
} 
