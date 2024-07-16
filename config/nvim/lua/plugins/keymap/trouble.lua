local wk_utils = require("plugins.external_functionality.which_key.utils")
local wk = require("which-key")

wk.add(
  wk_utils.keymaps({
      x = {
        name = "Trouble",
        x = { "<CMD>Trouble diagnostics toggle<CR>", desc = "Diagnostics" },
        X = { "<CMD>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Buffer Diagnostics" },
        s = { "<CMD>Trouble symbols toggle focus=false<CR>", desc = "Symbols" },
        l = { "<CMD>Trouble lsp toggle focus=false win.position=right<CR>", desc = "LSP Definitions / references / ..." },
        L = { "<CMD>Trouble loclist toggle<CR>", desc = "Location List" },
        Q = { "<CMD>Trouble qflist toggle<CR>", desc = "Quickfix List" }
      },
    },
    {
      prefix = "<leader>",
      remap = false,
      nowait = false,
    }
  )
)
