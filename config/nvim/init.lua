-- Disable perl provider
vim.g.loaded_perl_provider = 0

package.path = "$XDG_CONFIG_HOME/nvim/lua/?.lua;" .. package.path

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
