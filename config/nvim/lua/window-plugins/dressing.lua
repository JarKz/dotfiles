local function get_max_length(tbl)
	local max = -1
	for _, value in ipairs(tbl) do
		local current_lenth = string.len(value.ordinal)
		if max < current_lenth then
			max = current_lenth
		end
	end
	return max
end

require("dressing").setup({
	input = {
		-- Set to false to disable the vim.ui.input implementation
		enabled = true,
		-- Default prompt string
		default_prompt = "Input:",
		-- Can be 'left', 'right', or 'center'
		prompt_align = "left",
		-- When true, <Esc> will close the modal
		insert_only = false,
		-- When true, input will start in insert mode.
		start_in_insert = true,
		-- These are passed to nvim_open_win
		anchor = "SW",
		border = require("window-plugins.window-config").border,
		-- 'editor' and 'win' will default to being centered, and 'cursor'
		relative = "editor",
		-- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
		prefer_width = 40,
		width = nil,
		-- min_width and max_width can be a list of mixed types.
		-- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
		max_width = { 140, 0.9 },
		min_width = { 20, 0.2 },
		buf_options = {},
		win_options = {
			-- Window transparency (0-100)
			winblend = 0,
			-- Disable line wrapping
			wrap = false,
		},
		-- Set to `false` to disable
		mappings = {
			n = {
				["<Esc>"] = "Close",
				["<CR>"] = "Confirm",
			},
			i = {
				["<C-c>"] = "Close",
				["<CR>"] = "Confirm",
				["<Up>"] = "HistoryPrev",
				["<Down>"] = "HistoryNext",
			},
		},
		override = function(conf)
			-- This is the config that will be passed to nvim_open_win.
			-- Change values here to customize the layout
			return conf
		end,
		-- see :help dressing_get_config
		get_config = nil,
	},
	select = {
		-- Set to false to disable the vim.ui.select implementation
		enabled = true,
		-- Priority list of preferred vim.select implementations
		backend = { "telescope", "fzf_lua", "fzf", "builtin", "nui" },
		-- Trim trailing `:` from prompt
		trim_prompt = true,
		telescope = require("telescope.themes").get_dropdown({
			layout_config = {
				-- second param as max_columns, third – max_lines
				width = function(_self, _, _)
					local max = get_max_length(_self.finder.results)
					if max > 120 then
						return 180
					end
					if max > 70 then
						return 120
					end
					return 70
				end,
			},
		}),
		-- Used to override format_item. See :help dressing-format
		format_item_override = {},
		-- see :help dressing_get_config
		get_config = nil,
	},
})
