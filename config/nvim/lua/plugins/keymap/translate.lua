local mapping_options = {
  mode = "x",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local mapping = {
  t = {
    name = "Translate",
    r = { "<CMD>Translate ru<CR>", "To russian" },
    e = { "<CMD>Translate en<CR>", "To english" },
  },
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
