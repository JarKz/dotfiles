return {
  'saghen/blink.cmp',
  dependencies = {
    'rafamadriz/friendly-snippets',
    "folke/lazydev.nvim",
  },

  build = "cargo build --release",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      preset = 'enter',

      ["<C-d>"] = { "scroll_documentation_down" },
      ["<C-u>"] = { "scroll_documentation_up" },
    },

    cmdline = {
      keymap = {
        preset = "inherit",
      },
      completion = {
        menu = { auto_show = true },
      },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono'
    },

    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,

        window = {
          border = require('config.window_config').border,
        }
      },

      menu = {
        border = require('config.window_config').border,
        direction_priority = { 's', 'n' },
        draw = {
          treesitter = { 'lsp' }
        }
      },
    },

    signature = {
      enabled = true,
      window = {
        border = require('config.window_config').border,
      }
    },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },

      per_filetype = {
        lua = { 'lsp', 'lazydev', 'path', 'snippets', 'buffer' }
      },

      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
        }
      },
    },
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default", "completion.menu" }
}
