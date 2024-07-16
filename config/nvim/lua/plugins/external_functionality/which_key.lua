return {
  "folke/which-key.nvim",
  opts = {
    win = {
      border = require("config.window_config").border,
    },
  },
  config = function(_, opts)
    vim.o.timeout = true
    vim.o.timeoutlen = 700

    local wk = require("which-key")
    local wk_utils = require("plugins.external_functionality.which_key.utils")
    wk.setup(opts)

    wk.add(wk_utils.apply_props({
        { "<C-c>", '0v$"+y',         desc = "Copy line to system buffer" },
        { "<ESC>", "<CMD>nohls<CR>", desc = "Remove search highlihgts" },
        { "<C-f>", "<CMD>Flote<CR>", desc = "Float note with md filetype" },
        { "<C-c>", '"+y',            desc = "Copy selected to system buffer", mode = "x" },
      },
      { nowait = false, remap = false }
    ))
  end,
}
