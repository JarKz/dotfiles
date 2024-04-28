return {
  "uga-rosa/translate.nvim",
  dependencies = { "folke/which-key.nvim", },
  opts = {
    default = {
      command = "translate_shell",
    },
    silent = true,
    preset = {
      output = {
        split = {
          append = true,
        },
        floating = {
          style = "minimal",
          width = 100,
          height = 100,
          focusable = true,
          border = require("config.window_config").border,
          -- for upper than lsp documentation
          zindex = 51,
        },
      },
    },
  },
  config = function(_, opts)
    require('plugins.keymap.translate')
    require("translate").setup(opts)
  end,
}
