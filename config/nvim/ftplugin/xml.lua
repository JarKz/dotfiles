local java_boilerplate = require("for_ls.java.boilerplate")


local mapping_options = {
	mode = "n",
	prefix = "<leader>",
	buffer = 0,
	silent = true,
	noremap = true,
	nowait = false,
}

local mapping = {
	b = {
		name = "Boilerplate code",
		j = {
			function()
				vim.ui.input({ prompt = "Enter the group of boilerplate code" }, function(input)
					local code = java_boilerplate.get_code(input)
					vim.api.nvim_put(code, "l", true, true)
				end)
			end,
			"Java boilerplate code"
		},
	}
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
