return {
  "uga-rosa/translate.nvim",
  keys = {
    remap = false,
    nowait = false,
    { "<leader>t",  group = "Translate" },
    { "<leader>tr", "<CMD>Translate ru<CR>", desc = "Translate to Russian", mode = "x" },
    { "<leader>te", "<CMD>Translate en<CR>", desc = "Translate to English", mode = "x" },
  },
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
}
