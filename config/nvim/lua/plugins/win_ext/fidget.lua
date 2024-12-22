return {
  "j-hui/fidget.nvim",
  opts = {
    progress = {
      poll_rate = 0,
      suppress_on_insert = false,
      ignore_done_already = false,
      ignore_empty_message = false,
      clear_on_detach =
          function(client_id)
            local client = vim.lsp.get_client_by_id(client_id)
            return client and client.name or nil
          end,
      notification_group =
          function(msg) return msg.lsp_client.name end,
      ignore = {},
    },

    -- Options related to notification subsystem
    notification = {
      poll_rate = 10,               -- How frequently to update and render notifications
      filter = vim.log.levels.INFO, -- Minimum notifications level
      history_size = 128,           -- Number of removed messages to retain in history
      override_vim_notify = false,  -- Automatically override vim.notify() with Fidget
      -- configs =                     -- How to configure notification groups when instantiated
      -- { default = require("fidget.notification").default_config },

      view = {
        stack_upwards = true,
        icon_separator = " ",
        group_separator = "---",
        group_separator_hl =
        "Comment",
      },

      window = {
        normal_hl = "Normal",
        winblend = 0,
        border = "none",
        zindex = 45,
        max_width = 0,
        max_height = 0,
        x_padding = 1,
        y_padding = 0,
        align = "bottom",
        relative = "editor",
      },
    },

    integration = {
      ["nvim-tree"] = {
        enable = true,
      },
    },
  },
  config = function(_, opts)
    require('fidget').setup(opts)
    vim.cmd("hi link FidgetTask Normal")
  end,
}
