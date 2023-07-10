local notify = require("notify")

notify.setup({
	background_colour = function()
		local hl = vim.api.nvim_get_hl_by_name("Normal", true)
		if hl.background == nil then
			return "#000000"
		end
		return "NotifyBackground"
	end,
	timeout = 50,
})

vim.notify = notify
