local mapping_options = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local mapping = {
  ["<leader>"] = {
    name = "Leader functions",
    x = {
      name = "Trouble",
      x = { "<CMD>Trouble diagnostics toggle<CR>", "Diagnostics" },
      X = { "<CMD>Trouble diagnostics toggle filter.buf=0<CR>", "Buffer Diagnostics" },
      s = { "<CMD>Trouble symbols toggle focus=false<CR>", "Symbols" },
      l = { "<CMD>Trouble lsp toggle focus=false win.position=right<CR>", "LSP Definitions / references / ..." },
      L = { "<CMD>Trouble loclist toggle<CR>", "Location List" },
      Q = { "<CMD>Trouble qflist toggle<CR>", "Quickfix List" }
    },
  },
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
