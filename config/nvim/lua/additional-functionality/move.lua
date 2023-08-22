require("gomove").setup({
  -- whether or not to map default key bindings, (true/false)
  map_defaults = false,
  -- whether or not to reindent lines moved vertically (true/false)
  reindent = true,
  -- whether or not to undojoin same direction moves (true/false)
  undojoin = true,
  -- whether to not to move past end column when moving blocks horizontally, (true/false)
  move_past_end_col = false,
})

local mapping_options = {
  mode = "x",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local mapping = {
  -- Move
  ["<S-h>"] = { "<Plug>GoVSMLeft", "Move visual left" },
  ["<S-j>"] = { "<Plug>GoVSMDown", "Move visual down" },
  ["<S-k>"] = { "<Plug>GoVSMUp", "Move visual up" },
  ["<S-l>"] = { "<Plug>GoVSMRight", "Move visual right" },
  -- Copy
  ["<C-h>"] = { "<Plug>GoVSDLeft", "Copy visual left" },
  ["<C-j>"] = { "<Plug>GoVSDDown", "Copy visual down" },
  ["<C-k>"] = { "<Plug>GoVSDUp", "Copy visual up" },
  ["<C-l>"] = { "<Plug>GoVSDRight", "Copy visual right" },
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
