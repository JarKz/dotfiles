# Neovim

The main code/text editor that I mostly use. Sometimes I can change configuration for adding minor effects or removing deprecated plugins. Also in intervals like 1-3 months I update the configurations to latest plugin standards.

## Structure

The current structure of configuration based on standard for 'lazy.nvim' plugin:

  - main file 'init.lua';
  - config directory that setup and loads plugins: 'lua/config/';
  - all plugins grouped and placed at 'lua/plugins' directory;
  - externsions for some cases placed at 'lua/extensions' directory;
  - configurations for particular programming languages placed at 'ftplugin/' (see more in vim `:help ftplugin`).

## First start

When you initially starts Neovim, you must wait becuase plugins, `treesitter`parsers and `Mason` packages is installing. You can check status of installations:

  - for `treesitter` parsers: type `:messages` and scroll down (by 'j' key or 'space' key);
  - for plugins: type `:Lazy` and it pop up window with details;
  - for `Mason`: type `:Mason` and it pop up window with list of packages and their status;

If you see any errors in top-right corner, type `:Notifications` and read what is errors. Mostly it based on bad preparation, that I described in 'dotfiles/README.md'.

## List of plugins

Colorscheme:

  - `sainnhe/sonokai`

Autopairs:

  - `altermo/ultimate-autopair.nvim`
  - `windwp/nvim-ts-autotag`
  - `windwp/nvim-autopairs`
  - `abecodes/tabout.nvim`

Autocompletion:

  - `hrsh7th/nvim-cmp`, depends on:
      - `hrsh7th/cmp-cmdline`
      - `hrsh7th/cmp-omni`
      - `hrsh7th/cmp-buffer`
      - `hrsh7th/cmp-nvim-lua`
      - `hrsh7th/cmp-nvim-lsp`
      - `hrsh7th/cmp-path`
      - `hrsh7th/cmp-nvim-lsp-signature-help`
      - `saadparwaiz1/cmp_luasnip`
      - `L3MON4D3/LuaSnip`
      - `rafamadriz/friendly-snippets`
      - `onsails/lspkind-nvim`
      - `tzachar/cmp-tabnine`

LSP:

  - `neovim/nvim-lspconfig`
  - `williamboman/mason.nvim`
  - `williamboman/mason-lspconfig.nvim`
  - `jay-babu/mason-null-ls.nvim`
  - `mfussenegger/nvim-jdtls`
  - `folke/trouble.nvim` – easy shows list of warnings, errors, references, implementations and etc.

DAP:

  - `mfussenegger/nvim-dap`
  - `rcarriga/nvim-dap-ui`
  - `folke/neodev.nvim` – debug Neovim

Syntax highlight:

  - `nvim-treesitter/nvim-treesitter`
  - `RRethy/vim-illuminate`

External functionality:

  - `Pocco81/auto-save.nvim`
  - `numToStr/Comment.nvim`
  - `wintermute-cell/gitignore.nvim`
  - `lewis6991/gitsigns.nvim`
  - `booperlv/nvim-gomove`
  - `lukas-reineke/indent-blankline.nvim`
  - `JarKz/nvim-spider-utf8` instead of `hrisgrieser/nvim-spider` for enabuling UTF-8, and it depends on:
    - `theHamsta/nvim_rocks`
  - `JarKz/search-replace-additional-configuration.nvim` instead of `roobert/search-replace.nvim` because of lack of additional properties.
  - `edluffy/specs.nvim`
  - `uga-rosa/translate.nvim`
  - `kaarmu/typst.vim`
  - `kevinhwang91/nvim-ufo`, which depends on `kevinhwang91/promise-async`
  - `folke/which-key.nvim`

Window plugins:

  - `glepnir/dashboard-nvim`
  - `stevearc/dressing.nvim`
  - `j-hui/fidget.nvim`
  - `JellyApple102/flote.nvim`
  - `ibhagwan/fzf-lua`
  - `glepnir/galaxyline.nvim`
  - `ellisonleao/glow.nvim`
  - `rcarriga/nvim-notify`
  - `nvim-tree/nvim-tree.lua`

Icons: `nvim-tree/nvim-web-devicons`

Keyboard layout: `shvechikov/vim-keymap-russian-jcukenmac`

## Troubleshooting

If you got some errors, please copy (or screenshot) the errors from `:messages` or `:Notifications` and open Issue with steps to reprouce this problem.

## Contribution

If you found code improvements or you have suggestions to replace one plugin to another, or something other – open Issue or make PR.

## License

  [MIT](https://github.com/JarKz/dotfiles/blob/main/LICENSE)
