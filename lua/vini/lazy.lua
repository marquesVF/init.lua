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
      { "williamboman/mason-lspconfig.nvim" },
      { "jose-elias-alvarez/null-ls.nvim" },

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

  -- LLM Integration
{
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- add any opts here
    -- for example
    provider = "openai",
    openai = {
      -- endpoint = "https://api.openai.com/v1",
      endpoint = "http://localhost:1234/v1",
      -- model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      -- temperature = 0,
      -- max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      temperature = 0.7,
      max_tokens = 2048,
      --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
},

  -- File system
  { "stevearc/oil.nvim" },

  -- ChatGPT
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   config = function()
  --     require("chatgpt").setup()
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },

  { "MunifTanjim/prettier.nvim" },
} 