local wk_utils = require("plugins.external_functionality.which_key.utils")
local wk = require("which-key")
wk.add(wk_utils.keymaps({
    z = {
      name = "Zsh",
      a = { "<CMD>LspStart bashls<CR>", desc = "Attach the bashls" },
    },
  },
  {
    prefix = "<leader>",
    remap = false,
    nowait = false,
  }
))
