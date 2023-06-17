local mapping_options = {
	mode = "n", -- NORMAL mode
	-- prefix: use "<leader>f" for example for mapping everything related to finding files
	-- the prefix is prepended to every mapping part of `mappings`
	prefix = "",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = false, -- use `nowait` when creating keymaps
}

local mapping = {
	["<leader>"] = {
		name = "Leader functions",
		x = {
			name = "TroubleToggle",
			x = { "<CMD>TroubleToggle<CR>", "Open" },
			w = { "<CMD>TroubleToggle workspace_diagnostics<CR>", "Workspace diagnostics" },
			d = { "<CMD>TroubleToggle document_diagnostics<CR>", "Document diagnostics" },
			l = { "<CMD>TroubleToggle loclist<CR>", "Local diagnostics list" },
			q = { "<CMD>TroubleToggle quickfix<CR>", "Show quickfixes" },
		},
	},
	g = {
		name = "Global function",
		R = { "<CMD>TroubleToggle lsp_references<CR>", "Lsp references" },
		r = { "<CMD>TroubleToggle lsp_references<CR>", "Lsp references (same)" },
	},
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
