local mapping_options = {
  mode = "x",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local mapping = {
  -- -- Move
  -- ["<S-h>"] = { "<Plug>GoVSMLeft", "Move visual left" },
  -- ["<S-j>"] = { "<Plug>GoVSMDown", "Move visual down" },
  -- ["<S-k>"] = { "<Plug>GoVSMUp", "Move visual up" },
  -- ["<S-l>"] = { "<Plug>GoVSMRight", "Move visual right" },
  -- -- Copy
  -- ["<C-h>"] = { "<Plug>GoVSDLeft", "Copy visual left" },
  -- ["<C-j>"] = { "<Plug>GoVSDDown", "Copy visual down" },
  -- ["<C-k>"] = { "<Plug>GoVSDUp", "Copy visual up" },
  -- ["<C-l>"] = { "<Plug>GoVSDRight", "Copy visual right" },
  --
  -- Colemak
  -- Move
  ["<S-h>"] = { "<Plug>GoVSMLeft", "Move visual left" },
  ["<S-n>"] = { "<Plug>GoVSMDown", "Move visual down" },
  ["<S-e>"] = { "<Plug>GoVSMUp", "Move visual up" },
  ["<S-i>"] = { "<Plug>GoVSMRight", "Move visual right" },
  -- Copy
  ["<C-h>"] = { "<Plug>GoVSDLeft", "Copy visual left" },
  ["<C-n>"] = { "<Plug>GoVSDDown", "Copy visual down" },
  ["<C-e>"] = { "<Plug>GoVSDUp", "Copy visual up" },
  ["<C-i>"] = { "<Plug>GoVSDRight", "Copy visual right" },
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
