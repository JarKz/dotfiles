return {
  "stevearc/dressing.nvim",
  opts = {
    input = {
      enabled = true,
      default_prompt = "Input:",
      prompt_align = "left",
      insert_only = false,
      start_in_insert = true,
      border = require("config.window_config").border,
      relative = "editor",
      prefer_width = 40,
      width = nil,
      max_width = { 140, 0.9 },
      min_width = { 20, 0.2 },
      buf_options = {},
      win_options = {
        winblend = 0,
        wrap = false,
      },
      mappings = {
        n = {
          ["<Esc>"] = "Close",
          ["<CR>"] = "Confirm",
        },
        i = {
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
          ["<Up>"] = "HistoryPrev",
          ["<Down>"] = "HistoryNext",
        },
      },
      override = function(conf)
        conf.anchor = "SW"
        return conf
      end,
      get_config = nil,
    },
    select = {
      enabled = true,
      backend = { "fzf_lua", "fzf", "builtin", "nui" },
      trim_prompt = true,
      fzf_lua = {
        winopts = {
          width = 0.4,
          height = 0.3,
        }
      },
      format_item_override = {},
      get_config = nil,
    },
  },
}
