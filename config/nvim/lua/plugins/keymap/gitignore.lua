local wk_utils = require("plugins.external_functionality.which_key.utils")
local wk = require("which-key")

wk.add(
  wk_utils.keymaps({
      ["<space>gi"] = {
        "<CMD>Gitignore<CR>",
        desc = "Generate gitignore file",
      },
      ["<C-g>"] = {
        require("gitignore").generate, desc = "Generate gitignore file"
      },
    },
    {
      remap = false,
      nowait = false,
    }
  )
)
