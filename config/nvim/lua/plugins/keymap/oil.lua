local wk_utils = require("plugins.external_functionality.which_key.utils")
local wk = require("which-key")

wk.add(
  wk_utils.keymaps({
      o = {
        "<CMD>Oil<CR>",
        desc = "Open the Oil in a new buffer."
      },
    },
    {
      prefix = "<leader>",
      remap = false,
      nowait = false,
    }
  )
)
