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
    { "romgrk/barbar.nvim",         dependencies = "nvim-web-devicons" },
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

    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "OXY2DEV/markview.nvim" },
        lazy = false,
    },

    -- GAI Autocompletion
    { "supermaven-inc/supermaven-nvim" },

    {
        "hat0uma/csvview.nvim",
        ---@module "csvview"
        ---@type CsvView.Options
        opts = {
            parser = { comments = { "#", "//" } },
            keymaps = {
                -- Text objects for selecting fields
                textobject_field_inner = { "if", mode = { "o", "x" } },
                textobject_field_outer = { "af", mode = { "o", "x" } },
                -- Excel-like navigation:
                -- Use <Tab> and <S-Tab> to move horizontally between fields.
                -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
                -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
                jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
                jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
                jump_next_row = { "<Enter>", mode = { "n", "v" } },
                jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
            },
        },
        cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    }
}
