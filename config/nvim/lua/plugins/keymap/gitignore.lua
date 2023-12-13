local mapping_options = {
  mode = "n",
  prefix = "<space>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local mapping = {
  gi = {
    "<CMD>Gitignore<CR>",
    "Generate gitignore",
  },
}

require("which-key").register(mapping, mapping_options)
