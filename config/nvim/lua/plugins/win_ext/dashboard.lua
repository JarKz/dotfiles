return {
  "glepnir/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require('dashboard').setup({
      theme = "hyper",
      change_to_vcs_root = true,
      config = {
        week_header = {
          enable = true,
        },
        shortcut = {
          {
            desc = "󰚰 Update",
            group = "@property",
            action = "Lazy update",
            key = "u",
          },
          {
            desc = " Sync",
            group = "@property",
            action = "Lazy sync",
            key = "s",
          },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = require("fzf-lua").files,
            key = "f",
          },
        },
        project = {
          enable = true,
          action = function(path)
            vim.cmd.cd(path)
            require("fzf-lua").files()
          end,
        },
        mru = {},
      },
    })
  end,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "ibhagwan/fzf-lua",
  },
}
