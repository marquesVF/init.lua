# My Neovim Configuration

This Neovim configuration is designed for modern developers who work across multiple languages, with a focus on web development in TypeScript, system development in Rust, and general-purpose coding.


## Why Neovim?

- **Fast navigation** with Vim motions for efficient text editing
- **Extensive plugin ecosystem** for any development workflow
- **Customizable in Lua** instead of Vimscript ❤️

## Features

- 🔍 **Telescope** — Fuzzy finding for files, grep, buffers, and LSP references
- 🌳 **Treesitter** — Advanced syntax highlighting and code understanding
- 💡 **LSP Support** — IntelliSense, code actions, go-to-definition, and more
- ✨ **Autocompletion** — Context-aware completions with snippets
- 📁 **File Explorer** — nvim-tree with git integration
- 🎨 **VS Code Theme** — Familiar dark theme with transparency
- 🔧 **Formatting** — Prettier integration for web development
- 🦀 **Rust Tools** — Enhanced Rust development experience
- 🧪 **Jest Runner** — Run and debug JavaScript/TypeScript tests
- 📊 **Git Integration** — Fugitive, blame line, and diff tools
- 💾 **Session Management** — Auto-save and restore sessions
- 📝 **Modern UI** — Noice command line, notifications, and status line

## Prerequisites

### Required Dependencies

| Dependency | Purpose | Installation |
|------------|---------|--------------|
| **Neovim 0.9+** | Core editor | [neovim.io](https://neovim.io) or `brew install neovim` |
| **Git** | Plugin management & fugitive | `sudo apt install git` or `brew install git` |
| **Node.js & npm** | TypeScript LSP, Prettier, Jest | [nodejs.org](https://nodejs.org) or use nvm |
| **ripgrep** | Telescope live grep | `sudo apt install ripgrep` or `brew install ripgrep` |
| **Nerd Font** | Icons in file tree and UI | [nerdfonts.com](https://www.nerdfonts.com/) |

### Recommended (for specific languages)

| Dependency | Purpose | Installation |
|------------|---------|--------------|
| **Rust & Cargo** | Rust development | [rustup.rs](https://rustup.rs) |
| **Python 3** | Python development | System package manager |
| **tree-sitter CLI** | Parser auto-installation | `npm install -g tree-sitter-cli` |
| **prettier** | Code formatting | `npm install -g prettier` |

### Nerd Font Installation

This configuration uses icons extensively. Install a Nerd Font for the best experience:

```bash
# Ubuntu/Debian
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip
unzip FiraCode.zip
fc-cache -fv

# macOS (via Homebrew)
brew tap homebrew/cask-fonts
brew install --cask font-fira-code-nerd-font
```

Then set your terminal emulator to use **FiraCode Nerd Font**.

## Installation

1. **Backup your existing configuration** (if any):

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository**:

   ```bash
   git clone https://github.com/marquesVF/init.lua.git ~/.config/nvim
   ```

3. **Create the undo directory** (for persistent undo history):

   ```bash
   mkdir -p ~/.vim/undodir
   ```

4. **Open Neovim**:

   ```bash
   nvim
   ```

   On first launch, [lazy.nvim](https://github.com/folke/lazy.nvim) will automatically install itself and all plugins.

5. **Install language servers** (automatic via Mason):

   The configuration will automatically install these LSP servers on first use:
   - `ts_ls` — TypeScript/JavaScript
   - `eslint` — JavaScript/TypeScript linting
   - `pyright` — Python
   - `rust_analyzer` — Rust
   - `lua_ls` — Lua
   - `cssls` — CSS
   - `jsonls` — JSON
   - `lemminx` — XML
   - `cucumber_language_server` — Cucumber/Gherkin

   You can also manually install/update servers with `:Mason`.

## Key Mappings

**Leader key:** `Space`

### General

| Mapping | Description |
|---------|-------------|
| `<leader>pv` | Open netrw file explorer |
| `<leader>q` | Close current buffer |
| `<leader>da` | Close all buffers except current |
| `<leader>f` | Format current file |
| `<leader><leader>` | Source current file |

### Navigation

| Mapping | Description |
|---------|-------------|
| `<C-h/j/k/l>` | Move between splits |
| `<C-d>` | Scroll down (centered) |
| `<C-u>` | Scroll up (centered) |
| `n` / `N` | Next/previous search result (centered) |

### Telescope (Fuzzy Finder)

| Mapping | Description |
|---------|-------------|
| `<leader>ff` | Find files |
| `<C-p>` | Git files |
| `<leader>fg` | Live grep (search text) |
| `<leader>fb` | List open buffers |

### File Tree (nvim-tree)

| Mapping | Description |
|---------|-------------|
| `<C-n>` | Toggle file tree |
| `<leader>it` | Reveal current file in tree |
| `l` | Open file/expand folder |
| `h` | Collapse folder |
| `v` | Open in vertical split |

### LSP

| Mapping | Description |
|---------|-------------|
| `gd` | Go to definition |
| `K` | Hover documentation |
| `<leader>gr` | Find references |
| `<leader>rn` | Rename symbol |
| `<leader>ga` | Code actions |
| `<leader>of` | Open diagnostics float |
| `<leader>vws` | Workspace symbol search |
| `[d` / `]d` | Next/previous diagnostic |

### TypeScript Specific

| Mapping | Description |
|---------|-------------|
| `<leader>oi` | Organize imports |
| `<leader>oa` | Add missing imports |

### Git

| Mapping | Description |
|---------|-------------|
| `<leader>gib` | Git blame |
| `<leader>gid` | Git diff |
| `<leader>gdf` | Git diff (vertical split) |
| `<leader>gim` | Git mergetool |

### Rust

| Mapping | Description |
|---------|-------------|
| `<leader>rr` | Rust runnables |

### Jest Testing

| Mapping | Description |
|---------|-------------|
| `<leader>lj` | Run test under cursor |
| `<leader>rj` | Run all tests in file |
| `<leader>dj` | Debug test under cursor |

### Terminal

| Mapping | Description |
|---------|-------------|
| `<leader>nt` | New horizontal terminal |
| `<leader>nvt` | New vertical terminal |
| `<Esc>` | Exit terminal mode |

### Window Management

| Mapping | Description |
|---------|-------------|
| `<leader>=` | Increase window height |
| `<leader>-` | Decrease window height |

### Visual Mode

| Mapping | Description |
|---------|-------------|
| `J` | Move selected lines down |
| `K` | Move selected lines up |

## Plugin List

| Plugin | Description |
|--------|-------------|
| [lazy.nvim](https://github.com/folke/lazy.nvim) | Plugin manager |
| [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) | Fuzzy finder |
| [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) | Syntax highlighting |
| [lsp-zero.nvim](https://github.com/VonHeikemen/lsp-zero.nvim) | LSP setup helper |
| [mason.nvim](https://github.com/williamboman/mason.nvim) | LSP server manager |
| [nvim-cmp](https://github.com/hrsh7th/nvim-cmp) | Autocompletion |
| [LuaSnip](https://github.com/L3MON4D3/LuaSnip) | Snippet engine |
| [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua) | File explorer |
| [barbar.nvim](https://github.com/romgrk/barbar.nvim) | Tab/buffer line |
| [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) | Status line |
| [noice.nvim](https://github.com/folke/noice.nvim) | UI for messages and cmdline |
| [nvim-notify](https://github.com/rcarriga/nvim-notify) | Notification manager |
| [vscode.nvim](https://github.com/Mofiqul/vscode.nvim) | VS Code color scheme |
| [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) | Tokyo Night color scheme |
| [vim-fugitive](https://github.com/tpope/vim-fugitive) | Git integration |
| [nvim-blame-line](https://github.com/tveskag/nvim-blame-line) | Git blame |
| [rust-tools.nvim](https://github.com/simrat39/rust-tools.nvim) | Rust development tools |
| [jester](https://github.com/David-Kunz/jester) | Jest test runner |
| [none-ls.nvim](https://github.com/nvimtools/none-ls.nvim) | Formatting/diagnostics |
| [prettier.nvim](https://github.com/MunifTanjim/prettier.nvim) | Prettier integration |
| [auto-session](https://github.com/rmagatti/auto-session) | Session management |
| [undotree](https://github.com/mbbill/undotree) | Undo history visualizer |
| [auto-pairs](https://github.com/jiangmiao/auto-pairs) | Auto-close brackets |
| [nerdcommenter](https://github.com/preservim/nerdcommenter) | Code commenting |
| [goto-preview](https://github.com/rmagatti/goto-preview) | Floating preview windows |
| [oil.nvim](https://github.com/stevearc/oil.nvim) | File explorer as buffer |
| [markview.nvim](https://github.com/OXY2DEV/markview.nvim) | Markdown preview |
| [csvview.nvim](https://github.com/hat0uma/csvview.nvim) | CSV file viewer |

## Troubleshooting

### Icons not displaying correctly
Make sure you have a Nerd Font installed and configured in your terminal emulator.

### Live grep not working
Install ripgrep: `sudo apt install ripgrep` or `brew install ripgrep`

### LSP not starting
Run `:Mason` to check if language servers are installed. You can manually install them from the Mason UI.

### Treesitter parsers missing
Run `:TSUpdate` to update/install all parsers, or `:TSInstall <language>` for specific ones.

### Plugin errors on startup
Run `:Lazy sync` to ensure all plugins are properly installed and updated.

## License

See [LICENSE](./LICENSE) file.
