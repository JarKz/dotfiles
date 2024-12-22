return {
  "folke/trouble.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    remap = false,
    nowait = false,
    { "<leader>xx", "<CMD>Trouble diagnostics toggle<CR>",                        desc = "Show Trouble's diagnostics" },
    { "<leader>xX", "<CMD>Trouble diagnostics toggle filter.buf=0<CR>",           desc = "Show Trouble's local buffer diagnostics" },
    { "<leader>xs", "<CMD>Trouble symbols toggle focus=false<CR>",                desc = "Show Trouble's symbols" },
    { "<leader>xl", "<CMD>Trouble lsp toggle focus=false win.position=right<CR>", desc = "LSP Definitions / references / ..." },
    { "<leader>xL", "<CMD>Trouble loclist toggle<CR>",                            desc = "Location List" },
    { "<leader>xQ", "<CMD>Trouble qflist toggle<CR>",                             desc = "Quickfix List" }
  },
  opts = {},
}
