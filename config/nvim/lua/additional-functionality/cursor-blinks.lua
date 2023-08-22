require("specs").setup({
  show_jumps = true,
  min_jump = 15,
  popup = {
    delay_ms = 0, -- delay before popup displays
    inc_ms = 15,  -- time increments used for fade/resize effects
    blend = 50,   -- starting blend, between 0-100 (fully transparent), see :h winblend
    width = 100,
    winhl = "PMenu",
    fader = require("specs").linear_fader,
    resizer = require("specs").shrink_resizer,
  },
  ignore_filetypes = {},
  ignore_buftypes = {
    nofile = true,
  },
})

vim.api.nvim_set_keymap("n", "n", 'n:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "N", 'N:lua require("specs").show_specs()<CR>', { noremap = true, silent = true })
