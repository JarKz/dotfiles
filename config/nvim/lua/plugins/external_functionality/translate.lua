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
          focusable = true,
          border = require("config.window_config").border,
          -- for upper than lsp documentation
          zindex = 51,
        },
      },
    },
  },
  config = function()
    require('plugins.keymap.translate')
  end,
}
