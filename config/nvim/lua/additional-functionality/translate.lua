require("translate").setup({
  default = {
    command = "translate_shell",
    -- parse_before = "trim,concat,natural",
  },
  silent = true,
  preset = {
    -- parse_before = {
    -- 	concat = {
    -- 		sep = "\n",
    -- 	}
    -- },
    -- parse_after = {},
    output = {
      split = {
        append = true,
      },
      floating = {
        style = "minimal",
        focusable = true,
        border = require("window-plugins.window-config").border,
        -- for upper than lsp documentation
        zindex = 51,
      },
    },
  },
})

local mapping_options = {
  mode = "x",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local mapping = {
  t = {
    name = "Translate",
    r = { "<CMD>Translate ru<CR>", "To russian" },
    e = { "<CMD>Translate en<CR>", "To english" },
  },
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
