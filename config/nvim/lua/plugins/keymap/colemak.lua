local wk = require("which-key")

local mapping_options = {
  mode = { "n", "x", "o" },
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local mapping = {
  -- Movement
  ["n"] = { "j", "" },
  ["e"] = { "k", "" },
  ["i"] = { "l", "" },
  ["l"] = { "u", "" },
  ["u"] = { "i", "" },

  ["<S-n>"] = { "<S-j>", "" },
  ["<S-e>"] = { "<S-k>", "" },
  ["<S-i>"] = { "<S-l>", "" },
  ["<S-l>"] = { "<S-u>", "" },
  ["<S-u>"] = { "<S-i>", "" },

  ["<C-n>"] = { "<C-j>", "" },
  ["<C-e>"] = { "<C-k>", "" },
  ["<C-i>"] = { "<C-l>", "" },
  ["<C-l>"] = { "<C-u>", "" },
  ["<C-u>"] = { "<C-i>", "" },

  -- Searching/Replacing
  ["k"] = { "n", "" },
  ["<S-k>"] = { "<S-n>", "" },
  ["<C-k>"] = { "<C-n>", "" },
}

wk.register(mapping, mapping_options)
