local mapping_options = {
	mode = "n",
	prefix = "<leader>",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
}

local mapping = {
	z = {
		name = "Zsh",
		a = { "<CMD>LspStart bashls<CR>", "Attach the bashls" },
	},
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
