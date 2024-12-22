return {
  "jarkz/specs.nvim",
  keys = {
    remap = false,
    silent = true,
    { "n", "n<CMD>lua require('specs').show_specs()<CR>" },
    { "N", "N<CMD>lua require('specs').show_specs()<CR>" },
  },
  opts = {
    show_jumps = true,
    min_jump = 15,
    popup = {
      delay_ms = 0, -- delay before popup displays
      inc_ms = 15,  -- time increments used for fade/resize effects
      blend = 50,   -- starting blend, between 0-100 (fully transparent), see :h winblend
      width = 100,
      winhl = "PMenu",
    },
    ignore_filetypes = {},
    ignore_buftypes = {
      nofile = true,
    },
  },
  config = function(_, opts) 
    local specs = require("specs")
    opts.popup.fader = specs.linear_fader
    opts.popup.resizer = specs.shrink_resizer
    require("specs").setup(opts)
  end
}
