-- Disable perl provider
vim.g.loaded_perl_provider = 0

package.path = "$XDG_CONFIG_HOME/nvim/lua/?.lua;"

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

-- vim.opt.mouse = "a"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

vim.opt.updatetime = 2000

vim.wo.number = true
vim.opt.relativenumber = true

-- setup of visibility of tabs, spaces, indents and trail spaces
vim.opt.listchars = "eol:\\u23CE,tab:>·,trail:~,extends:>,precedes:<,space:⚬"
vim.opt.list = true

-- Switch language
-- if you use windows or linux — set jcukenwim, else you use macos — jcukenmac
-- for mac you will install the package from:
-- https://github.com/shvechikov/vim-keymap-russian-jcukenmac
-- vim.opt.keymap = "russian-jcukenwin"
vim.opt.keymap = "russian-jcukenmac"
vim.opt.iminsert = 0
vim.opt.imsearch = 0
vim.o.cmdheight = 0

vim.opt.termguicolors = true

-- Disable insert mode when I leave telescope prompt
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	group = vim.api.nvim_create_augroup("DisableInsertMode", {}),
	pattern = "?*",
	callback = function(ev)
		local filename = vim.fn.fnamemodify(ev.file, ":t")
		local dap_repl = "[dap-repl]"
		if filename:sub(1, 3) == "DAP" or filename:sub(1, #dap_repl) == dap_repl then
			return
		end
		vim.cmd("silent! stopinsert")
	end,
})

require("plugins")
