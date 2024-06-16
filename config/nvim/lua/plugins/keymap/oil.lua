local which_key = require("which-key")

which_key.register(
  {
    o = {
      "<CMD>Oil<CR>",
      "Open the Oil in a new buffer."
    },
  }, {
    mode = "n",
    prefix = "<leader>",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  }
)
