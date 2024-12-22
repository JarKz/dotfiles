return {
  'stevearc/oil.nvim',
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>o", "<CMD>Oil<CR>", desc = "Open the Oil in a new buffer.", remap = false, nowait = false, },
  },
  opts = {
    delete_to_trash = true,
  },
  lazy = false,
}
