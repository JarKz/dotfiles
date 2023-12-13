return {
  "folke/which-key.nvim",
  opts = {
    key_labels = {
      ["<space>"] = "SPC",
      ["<cr>"] = "ENTER",
      ["<tab>"] = "TAB",
      ["<label>"] = "\\",
    },
    window = {
      border = require("config.window_config").border,
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for keymaps that start with a native binding
      n = {
        "v",
      },
      i = { "j", "k" },
      v = { "j", "k" },
    },
    triggers_nowait = {
      -- marks
      "`",
      "'",
      "g`",
      "g'",
      -- registers
      '"',
      "<c-r>",
      -- spelling
      "z=",
    },
  },
  config = function(_, opts)
    vim.o.timeout = true
    vim.o.timeoutlen = 700

    local wk = require("which-key")
    wk.setup(opts)

    local input_mode_mapping_options = {
      mode = "i",
      prefix = "",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = false,
    }

    local input_mode_mapping = {
      ["<C-l>"] = { "<C-^>", "Change input language" },
    }
    wk.register(input_mode_mapping, input_mode_mapping_options)

    local normal_mode_mapping_options = {
      mode = "n",
      prefix = "",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = false,
    }

    local gitignore = require("gitignore")

    local normal_mode_mapping = {
      ["<C-l>"] = { "a<C-^><ESC>", "Change input language" },
      ["<C-c>"] = { '0v$"*y', "Copy line to system buffer" },
      ["<ESC>"] = { "<CMD>nohls<CR>", "Remove search highlihgts" },
      ["<C-g>"] = { gitignore.generate, "Git ignore" },
      ["<C-f>"] = { "<CMD>Flote<CR>", "Float note with md filetype" },
      ["\\t"]   = { "<CMD>silent !tmux split-window -h<CR>", "Open v-pane in tmux" },

      -- Very useful mapping from:
      -- https://www.reddit.com/r/neovim/comments/12qfm20/comment/jgq0gzw/?utm_source=share&utm_medium=web2x&context=3
      H         = { "^", "Move to start of not blank line" },
      L         = { "$", "Move to end of line" },
      J         = { "}", "Move to end of block" },
      K         = { "{", "Move to start of block" },
      M         = { "J", "Mnemonic merge" },
    }

    wk.register(normal_mode_mapping, normal_mode_mapping_options)

    local select_mode_mapping_options = {
      mode = "x",
      prefix = "",
      buffer = nil,
      silent = true,
      noremap = true,
      nowait = false,
    }
    local visual_mode_mapping = {
      ["<C-c>"] = { '"*y', "Copy selected to system buffer" },
    }
    wk.register(visual_mode_mapping, select_mode_mapping_options)
  end,
}
