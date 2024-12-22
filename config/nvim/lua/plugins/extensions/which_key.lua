return {
  "folke/which-key.nvim",
  dependencies = {
    "echasnovski/mini.icons",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    nowait = false,
    remap = false,
    { "g", group = "Global functions" },
    { "<space>", group = "Space functions" },
    { "<leader>", group = "Leader functions" },
    { "<leader>x", group = "Trouble", },
    { "<ESC>", "<CMD>nohls<CR>", desc = "Remove search highlihgts" },
    { "<C-f>", "<CMD>Flote<CR>", desc = "Float note with md filetype" },
    { "<C-c>", '0v$"+y',         desc = "Copy line to system buffer" },
    { "<C-c>", '"+y',            desc = "Copy selected to system buffer", mode = "x" },
  },
  opts = {
    win = {
      border = require("config.window_config").border,
    },
  },
  config = function(_, opts)
    vim.o.timeout = true
    vim.o.timeoutlen = 300

    require("which-key").setup(opts)
  end,
}
