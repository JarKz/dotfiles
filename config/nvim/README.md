# Neovim

The main code/text editor that I mostly use.

It's at most complete neovim configuration for me, because all required functionality are exists and used many times. But thrends can change, so I can remove or add another plugin that can be helpful in particular cases. Also I can replace one plugin by another for specific reasons (archived plugin, unmantained code for some years or etc.).

> __NOTE__
>
> Be sure that you use stable neovim version since 0.10, because my configuration have inlay hints functionality. Be patient, please 🙏.

## Structure

The current structure of configuration based on standard for 'lazy.nvim' plugin:

  - main file 'init.lua';
  - config directory that setup and loads plugins: 'lua/config/';
  - all plugins grouped and placed at 'lua/plugins' directory;
  - externsions for some cases placed at 'lua/extensions' directory;
  - configurations for particular programming languages placed at 'ftplugin/' (see more in vim `:help ftplugin`).

## First start

When you initially starts Neovim, you must wait becuase plugins, `treesitter`parsers and `Mason` packages is installing. You can check status of installations:

  - for `treesitter` parsers: type `:messages` and scroll down (by 'j'/'space' key);
  - for plugins: type `:Lazy` and it pop up window with details;
  - for `Mason`: type `:Mason` and it pop up window with list of packages and their status;

If you see any errors in top-right corner, type `:Notifications` and read what is errors. Mostly it based on bad preparation, that I described in `README.md`.

## List of plugins

Plugin manager:

  - `folke/lazy.nvim`

Colorscheme:

  - `sainnhe/sonokai`
  - `catppuccin/nvim`

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

LSP:

  - `neovim/nvim-lspconfig`
  - `williamboman/mason.nvim`
  - `williamboman/mason-lspconfig.nvim`
  - `jay-babu/mason-null-ls.nvim` which depends on:
    - `jose-elias-alvarez/null-ls.nvim`
  - `mfussenegger/nvim-jdtls`
  - `folke/trouble.nvim` – easy shows list of warnings, errors, references, implementations and etc.
  - `folke/lazydev.nvim` - helps to write lua in neovim configurations or plugins.

DAP:

  - `mfussenegger/nvim-dap`
  - `rcarriga/nvim-dap-ui` which depends on:
    - `nvim-neotest/nvim-nio`

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
  - `hrisgrieser/nvim-spider`, depends on:
    - `theHamsta/nvim_rocks` - for enabling UTF-8
  - `JarKz/search-replace-additional-configuration.nvim` instead of `roobert/search-replace.nvim` because of lack of additional properties.
  - `JarKz/specs.nvim` instead of `edluffy/specs.nvim` because of deprecatibility nvim-api of nightly-version.
  - `uga-rosa/translate.nvim`
  - `kaarmu/typst.vim`
  - `kevinhwang91/nvim-ufo`, which depends on:
    - `kevinhwang91/promise-async`
  - `folke/which-key.nvim`

Window plugins:

  - `glepnir/dashboard-nvim`
  - `stevearc/dressing.nvim`
  - `j-hui/fidget.nvim`
  - `ibhagwan/fzf-lua`
  - `glepnir/galaxyline.nvim`
  - `rcarriga/nvim-notify`
  - `stevearc/oil.nvim`

Icons: `nvim-tree/nvim-web-devicons`

## Troubleshooting

If you got some errors, please copy (or screenshot) the errors from `:messages` or `:Notifications` and open issue with steps to reprouce this problem.

## Contribution

If you found code improvements or you have suggestions to replace one plugin to another, or something other – open Issue or make PR.

## License

  [MIT](/LICENSE)
