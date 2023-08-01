# Neovim

As I've say in README.md in previous directory, neovim is my main editor that I use everywhere. This configuration mostly contains things that I use often. I don't like adding plugins which I never use.

Sometimes I change configuration by different cases: adding barely changes that improve my coding, major changes that removing plugins because it going to be archived, fix changes for some plugin after their updating because their old configuration are deprecated...

Here's below list of plugins that I use and description of why I use it. You also can found it in `lua/plugins.lua`.

## First start

You will do nothing in first start because Lazy.nvim do all things for you. After first run close editor and run again for loading additional functions.

## List of plugins

* `sainnhe/sonokai`
  - colorscheme
* `nvim-tree/nvim-web-devicons`
  - dependency for some plugins that uses devicons
  - with it nvim pretty looks
* `shvechikov/vim-keymap-russian-jcukenmac`
  - if you use mac-like-keyboard and you like their keyboard layout so you can use
* `wakatime/vim-wakatime`
  - if you use wakatime
* `nvim-lua/plenary.nvim`
  - important dependency for many nvim plugins
* `williamboman/mason.nvim`
  - easy installing ls, linters, formatters and etc. Relief from headaches
* `williamboman/mason-lspconfig.nvim`
  - for `mason.nvim`
* `neovim/nvim-lspconfig`
  - for language server configuration
* `jose-elias-alvarez/null-ls.nvim`
  - for applying formatters, linters
* `mfussenegger/nvim-jdtls`
  - important for me plugin as java developer
  - bootstrap java language server instead built-in lsp config because it plugin could run ls directly
* `folke/trouble.nvim`
  - comfortable checking errors in other window
* `mfussenegger/nvim-dap`
  - debugger adapter because without that nvim cannot be IDE (IMHO)
* `rcarriga/nvim-dap-ui`
  - UI for debugger adapter, uses some small windows for displaying important information
* `folke/neodev.nvim`
  - if you don't configure sometimes then off this plugin
  - useful because in configurations can display global variable vim and his functions
* `hrsh7th/nvim-cmp`
  - code auto-comppletion
  - here additional plugins for cmp:
    - `hrsh7th/cmp-cmdline`                 -- command line
	- `hrsh7th/cmp-omni`
	- `hrsh7th/cmp-buffer`                  -- buffer completions
	- `hrsh7th/cmp-nvim-lua`                -- nvim config completions
	- `hrsh7th/cmp-nvim-lsp`                -- lsp completions
	- `hrsh7th/cmp-path`                    -- file path completions
	- `hrsh7th/cmp-nvim-lsp-signature-help` -- function/class sugnature helping
	- `saadparwaiz1/cmp_luasnip`            -- snippets completions
	- `L3MON4D3/LuaSnip`
	- `rafamadriz/friendly-snippets`
* `onsails/lspkind-nvim`
  - pictograms for code auto-completion
* `tzachar/cmp-tabnine`
  - if you don't like when plugin send code to non-local server then off it
  - comfortable code auto-completion because this plugin uses tabnine that analyze code for sending probable line or block (for premium) code
	},
* `windwp/nvim-ts-autotag`
  - autotag in html
* `windwp/nvim-autopairs`,
  - autopairs the parentheses, braces and brackets
* `ibhagwan/fzf-lua`
  - useful plugin for find some files, helps or commands and etc. that based on fzf command
  - it's my main plugin because it faster
* `stevearc/dressing.nvim`
  - changes default built-in nvim displays `vim.ui.input()` and `vim.ui.select()` to more prettier
* `nvim-tree/nvim-tree.lua`
  - useful plugin for file-tree at side in editor
* `akinsho/toggleterm.nvim`
  - uses to display terminal as floating window
* `glepnir/dashboard-nvim`
  - nvim startup not as empty buffer, but showing dashboard, if not argument passed
* `rcarriga/nvim-notify`
  - prettier showing some notifications via `vim.notify()`, not like messages in bottom line
* `j-hui/fidget.nvim`
  - displaying status of language servers when they runs and works
  - useful when language server not immediately starts and you understand why (example: long initializing workspace)
* `glepnir/galaxyline.nvim`
  - plugin that displays statusline but full-customizable
* `JellyApple102/flote.nvim`
  - for every workspace show editable in .md window
  - useful if you need write thoughts immediately in "note"
* `ellisonleao/glow.nvim`
  - displays your .md file in other window like as [glow command](https://github.com/charmbracelet/glow) in terminal
* `folke/which-key.nvim`
  - easy mapping your keymaps and if you forgot then this plugin will help by showing some mapping for specific key ([read more about it](https://github.com/folke/which-key.nvim))
* `numToStr/Comment.nvim`
  - comments code by mapping
  - can recognize the filetype and choose right symbols for comments
* `edluffy/specs.nvim`
  - useful to show your cursor if you move it to many lines up or down
* `booperlv/nvim-gomove`
  - moves lines right, left (increase or decrease indentations or move through symbols), up and down (like swap lines) by special mapping
* `uga-rosa/translate.nvim`
  - translates selected text
  - useful for non-native english users
* `wintermute-cell/gitignore.nvim`
  - makes gitignore file by some patterns
  - this plugin use only telescope and I don't like it, therefore I've maked fork:
    - `JarKz/gitignore.nvim`
      - supports contract with templates and friendly with any pickers like telescope, fzf...
* `chrisgrieser/nvim-spider`
  - remaps default nvim keys: w, b, e...
  - **important** [by issue](https://github.com/chrisgrieser/nvim-spider/issues/14) plugin works only with ACSII symbols and it may be annoying if you also works with non-ASCII text
    - `JarKz/nvim-spider-utf8`
      - my forked plugin with support UTF-8, which well works
* `lewis6991/gitsigns.nvim`
  - show git signs left of code
  - useful when you works with git and understand what is changes
* `kevinhwang91/nvim-ufo`
  - folds normally code unlike treesitter folding (IMHO)
  - here as dependency: `kevinhwang91/promise-async`
* `roobert/search-replace.nvim`
  - replacing something by pattern
  - useful when, even if you using DRY code, your code have some weird or worst naming then you can replace it by pattern
  - but maintainer not upgrading this plugin by addin similar changes and I made fork it:
    - `JarKz/search-replace-additional-configuration.nvim`
      - contains two patterns: "range" ([read more here](https://neovim.io/doc/user/usr_10.html#10.3)) and part of regex pattern like global, insensitive...
* `nvim-treesitter/nvim-treesitter`
  - syntax-highlighting by incremental selection
* `RRethy/vim-illuminate`
  - highlight similar or logical keyword pairs (e.g. "for (...) {" -> "}" or "break" -> "while")
* `Pocco81/auto-save.nvim`
  - autosaving file when you exit from insert mode

## Troubleshooting

Make an issue with detailed explains what neovim does and I will response if found time for it.

## Contribution

If you found something that clean code or improve configuration then make PR :)

## License

  [MIT](https://github.com/JarKz/dotfiles/blob/main/LICENSE)
