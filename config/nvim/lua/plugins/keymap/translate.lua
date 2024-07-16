local wk_utils = require("plugins.external_functionality.which_key.utils")
local wk = require("which-key")

wk.add(
  wk_utils.keymaps({
      t = {
        name = "Translate",
        r = { "<CMD>Translate ru<CR>", desc = "To russian" },
        e = { "<CMD>Translate en<CR>", desc = "To english" },
      },
    },
    {
      prefix = "<leader>",
      mode = "x",
      remap = false,
      nowait = false,
    }
  )
)
