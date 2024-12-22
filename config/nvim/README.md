# Neovim

The main code/text editor that I mostly use.

It's at most complete neovim configuration for me, because all required functionality are exists and used many times.
But thrends can change, so I can remove or add another plugin that can be helpful in particular cases. 
Also I can replace one plugin by another for specific reasons (archived plugin, unmantained code for some years or etc.).

> __NOTE__
>
> Be sure that you use stable neovim version since 0.10, because my configuration have inlay hints functionality. Be patient, please 🙏.

## Structure

The current structure of configuration based on standard for 'lazy.nvim' plugin:

  - main file 'init.lua';
  - config directory that setup and loads plugins: 'lua/config/';
  - all plugins grouped and placed at 'lua/plugins' directory;
  - configurations for particular file types placed at 'ftplugin/' (see more in vim `:help ftplugin`).

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

  - `saghen/blink.cmp`, depends on:
      - `rafamadriz/friendly-snippets`

LSP:

  - `neovim/nvim-lspconfig`
  - `williamboman/mason.nvim`
  - `williamboman/mason-lspconfig.nvim`
  - `jay-babu/mason-null-ls.nvim` which depends on:
    - `jose-elias-alvarez/null-ls.nvim`
  - `folke/trouble.nvim`
  - `folke/lazydev.nvim`

DAP:

  - `mfussenegger/nvim-dap`
  - `rcarriga/nvim-dap-ui` which depends on:
    - `nvim-neotest/nvim-nio`

Highlights:

  - `nvim-treesitter/nvim-treesitter`
  - `RRethy/vim-illuminate`

Extensions:

  - `Pocco81/auto-save.nvim`
  - `numToStr/Comment.nvim`
  - `wintermute-cell/gitignore.nvim`
  - `lewis6991/gitsigns.nvim`
  - `booperlv/nvim-gomove`
  - `lukas-reineke/indent-blankline.nvim`
  - `chrisgrieser/nvim-spider`, depends on:
    - `theHamsta/nvim_rocks` - to enable UTF-8
  - `chrisgrieser/nvim-rip-substitute`
  - `JarKz/specs.nvim` instead of `edluffy/specs.nvim` because of deprecatibility nvim-api.
  - `noti-rs/noti.nvim`
  - `uga-rosa/translate.nvim`
  - `kaarmu/typst.vim`
  - `kevinhwang91/nvim-ufo`, which depends on:
    - `kevinhwang91/promise-async`
  - `folke/which-key.nvim`, which depends on:
    - `echasnovski/mini.icons`

Window extensions:

  - `glepnir/dashboard-nvim`
  - `stevearc/dressing.nvim`
  - `j-hui/fidget.nvim`
  - `ibhagwan/fzf-lua`
  - `glepnir/galaxyline.nvim`
  - `rcarriga/nvim-notify`
  - `stevearc/oil.nvim`
  - `NStefan002/screenkey.nvim`

Icons: `nvim-tree/nvim-web-devicons`

## Troubleshooting

If you got some errors, please copy (or screenshot) the errors from `:messages` or `:Notifications` and open issue with steps to reprouce this problem.

## Contribution

If you found code improvements or you have suggestions to replace one plugin to another, or something other – open Issue or make PR.

## License

  [MIT](/LICENSE)
