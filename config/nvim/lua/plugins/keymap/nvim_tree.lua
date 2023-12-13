local mapping_options = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local mapping = {
  ["<C-t>"] = {
    "<CMD>NvimTreeToggle<CR>",
    "Toggle file tree",
  },
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
