local project_actions = require("telescope._extensions.project.actions")
local telescope = require("telescope")

local builtin = require("telescope.builtin")
local horisotal_large_preview = function(builtin_function, opts)
	opts.layout_config = {
		preview_width = 0.6,
	}
	builtin_function(opts)
end

telescope.setup({
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		},
		project = {
			base_dirs = {
				-- "~/dev/src",
				-- { "~/dev/src2" },
				-- { "~/dev/src3", max_depth = 4 },
				-- { path = "~/dev/src4" },
				-- { path = "~/dev/src5", max_depth = 2 },
			},
			hidden_files = true, -- default: false
			theme = "dropdown",
			order_by = "asc",
			search_by = "title",
			sync_with_nvim_tree = true, -- default false
			-- default for on_project_selected = find project files
			on_project_selected = function(prompt_bufnr)
				project_actions.change_working_directory(prompt_bufnr, false)
				horisotal_large_preview(
					builtin.find_files,
					-- { hidden = true, no_ignore = true, no_ignore_parent = true }
					{}
				)
			end,
		},
		file_browser = {
			hidden_files = true,
		},
	},
})

require("telescope").load_extension("project")
require("telescope").load_extension("fzy_native")


local mapping = {
	["<leader>"] = {
		name = "Leader functions",
		-- t = { "<CMD>Telescope<CR>", "Telescope" }, -- removed cuz hinders
		p = {
			function()
				local opts = {}
				local theme = require("telescope.themes").get_dropdown(opts)
				require("telescope").extensions.project.project(theme)
			end,
			"Projects",
		},
		f = {
			name = "Find",
			c = {
				function()
					local opts = {
						layout_config = {
							width = 0.7,
							height = function(_, _, max_lines)
								if max_lines > 10 then
									return 12
								end
								return max_lines
							end,
						},
					}
					local theme = require("telescope.themes").get_cursor(opts)
					builtin.commands(theme)
				end,
				"Command",
			},
		},
	},
}

local mapping_options = {
	mode = "n",
	prefix = "",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
