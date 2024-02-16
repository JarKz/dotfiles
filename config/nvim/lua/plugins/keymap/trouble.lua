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
      name = "TroubleToggle",
      x = { "<CMD>TroubleToggle<CR>", "Open" },
      w = { "<CMD>TroubleToggle workspace_diagnostics<CR>", "Workspace diagnostics" },
      d = { "<CMD>TroubleToggle document_diagnostics<CR>", "Document diagnostics" },
      l = { "<CMD>TroubleToggle loclist<CR>", "Local diagnostics list" },
      q = { "<CMD>TroubleToggle quickfix<CR>", "Show quickfixes" },
    },
  },
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
