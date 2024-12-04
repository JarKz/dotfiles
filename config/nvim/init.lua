-- Disable perl provider
vim.g.loaded_perl_provider = 0

package.path = "$XDG_CONFIG_HOME/nvim/lua/?.lua;" .. package.path

vim.opt.guicursor = {
  n = "block",
  v = "block",
  c = "block",
  i = "ver25",
  ci = "ver25",
  ve = "ver25",
  r = "hor20",
  cr = "hor20",
  o = "hor50",
  a = "blinkwait700-blinkoff400-blinkon250-Cursor/lCursor",
  sm = "block-blinkwait175-blinkoff150-blinkon175",
}

vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.updatetime = 2000

vim.wo.number = true

vim.opt.listchars = "eol:\\u23CE"
vim.opt.list = true

vim.o.cmdheight = 0

vim.opt.termguicolors = true

require('config')
