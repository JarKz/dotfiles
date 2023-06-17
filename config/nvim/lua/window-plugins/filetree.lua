-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
local nvim_tree = require("nvim-tree")
nvim_tree.setup({
	disable_netrw = false,
	hijack_netrw = true,
	auto_reload_on_write = true,
	open_on_tab = false,
	hijack_cursor = true,
	sync_root_with_cwd = true,
	hijack_unnamed_buffer_when_opening = false,
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = false,
		update_cwd = false,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 500,
	},
	view = {
		width = 28,
		hide_root_folder = false,
		side = "left",
		preserve_window_proportions = false,
		mappings = {
			custom_only = false,
			list = {},
		},
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	actions = {
		change_dir = {
			enable = true,
			global = false,
		},
		open_file = {
			quit_on_open = false,
			resize_window = true,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
	},
})

local function open_nvim_tree(data)
	local real_file = vim.fn.filereadable(data.file) == 1
	local no_name_buffer = data.file == "" and vim.bo[data.buf].buftype == ""
	local directory = vim.fn.isdirectory(data.file) == 1

	if not no_name_buffer and not real_file and not directory then
		return
	end

	-- Open dashborad
	if no_name_buffer then
		return
	end

	if directory then
		-- change to the directory
		vim.cmd.cd(data.file)
		require("nvim-tree.api").tree.open()
		return
	else
		if real_file then
			local path = vim.fn.expand("%:p:h")
			vim.print(path)
			vim.cmd.cd(path)
		end
	end
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })

local mapping_options = {
	mode = "n",
	prefix = "",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
}

local mapping = {
	["<C-t>"] = {
		"<CMD>NvimTreeToggle<CR>",
		"Toggle file tree",
	},
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
