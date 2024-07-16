local wk_utils = require("plugins.external_functionality.which_key.utils")
local wk = require("which-key")

wk.add(
  wk_utils.keymaps({
      -- Move
      ["<S-h>"] = { "<Plug>GoVSMLeft", desc = "Move visual left" },
      ["<S-j>"] = { "<Plug>GoVSMDown", desc = "Move visual down" },
      ["<S-k>"] = { "<Plug>GoVSMUp", desc = "Move visual up" },
      ["<S-l>"] = { "<Plug>GoVSMRight", desc = "Move visual right" },
      -- Copy
      ["<C-h>"] = { "<Plug>GoVSDLeft", desc = "Copy visual left" },
      ["<C-j>"] = { "<Plug>GoVSDDown", desc = "Copy visual down" },
      ["<C-k>"] = { "<Plug>GoVSDUp", desc = "Copy visual up" },
      ["<C-l>"] = { "<Plug>GoVSDRight", desc = "Copy visual right" },
    },
    {
      mode = "x",
      remap = false,
      nowait = false,
    }
  )
)
