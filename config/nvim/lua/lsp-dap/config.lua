local dap, dapui = require("dap"), require("dapui")

dapui.setup({
	layouts = {
		{
			--   elements = { {
			--       id = "scopes",
			--       size = 0.25
			--     }, {
			--       id = "breakpoints",
			--       size = 0.25
			--     }, {
			--       id = "stacks",
			--       size = 0.25
			--     }, {
			--       id = "watches",
			--       size = 0.25
			--     } },
			--   position = "left",
			--   size = 40
			-- }, {
			elements = { {
				id = "repl",
				size = 0.4,
			}, {
				id = "scopes",
				size = 0.6,
			} },
			position = "bottom",
			size = 10,
		},
	},
	floating = {
		border = "rounded",
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

-- Keymaps
local mapping_options = {
	mode = "n",
	prefix = "",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
}

local options = {
	width = nil,
	height = nil,
	enter = true,
}
local window_type = nil

local mapping = {
	["<leader>"] = {
		name = "Leader functions",
		d = {
			name = "Debug",
			r = { dap.run, "Run" },
			c = { dap.continue, "Continue" },
			t = { dap.toggle_breakpoint, "Toggle breakpoint" },
			u = { dapui.toggle, "Toggle UI" },
			f = {
				function()
					dapui.float_element(window_type, options)
				end,
				"Open float window",
			},
		},
	},
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
