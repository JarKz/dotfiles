local jdtls_ui = require("jdtls.ui")

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local action_utils = require("telescope.actions.utils")

local function fzf_multi_select(prompt_bufnr, co)
	local current_picker = action_state.get_current_picker(prompt_bufnr)
	local has_multiselection = (next(current_picker:get_multi_selection()) ~= nil)

	local selected = {}
	if has_multiselection then
		action_utils.map_selections(prompt_bufnr, function(selection)
			table.insert(selected, selection.value)
		end)
	else
		local selection = action_state.get_selected_entry()
		table.insert(selected, selection.value)
	end
	actions.close(prompt_bufnr)
	coroutine.resume(co, selected)
end

local window_settings = {
	layout_config = {
		width = 0.4,
		height = 0.3,
	},
}

local large_window_settings = {
	layout_config = {
		width = 0.9,
		height = 0.3,
	},
}

local function get_max_length(tbl, label_fn)
	local max = -1
	for _, value in ipairs(tbl) do
		local current_lenth = string.len(label_fn(value))
		if max < current_lenth then
			max = current_lenth
		end
	end
	return max
end

jdtls_ui.pick_many = function(items, prompt, label_f, opts)
	if get_max_length(items, label_f) > 40 then
		window_settings.layout_config.width = 0.9
	end
	local co = coroutine.running()
	opts = opts or require("telescope.themes").get_dropdown(window_settings)
	pickers
		.new(opts, {
			prompt_title = prompt,
			finder = finders.new_table({
				results = items,
				entry_maker = function(entry)
					return {
						value = entry,
						display = label_f(entry),
						ordinal = label_f(entry),
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					fzf_multi_select(prompt_bufnr, co)
				end)

				return true
			end,
		})
		:find()
	local result = coroutine.yield()
	return result
end

local function sync_picker(items, prompt, label_f)
	local choices = { prompt }
	for i, item in ipairs(items) do
		table.insert(choices, string.format("%d: %s", i, label_f(item)))
	end
	local choice = vim.fn.inputlist(choices)
	if choice < 1 or choice > #items then
		return nil
	end
	return items[choice]
end

jdtls_ui.pick_one = function(items, prompt, label_f)
	local current_window = window_settings
	if get_max_length(items, label_f) > 40 then
		current_window = large_window_settings
	end
	local co = coroutine.running()
	if co == nil then
		return sync_picker(items, prompt, label_f)
	end
	local opts = require("telescope.themes").get_dropdown(current_window)
	pickers
		.new(opts, {
			prompt_title = prompt,
			finder = finders.new_table({
				results = items,
				entry_maker = function(entry)
					return {
						value = entry,
						display = label_f(entry),
						ordinal = label_f(entry),
					}
				end,
			}),
			sorter = conf.generic_sorter(opts),
			attach_mappings = function(prompt_bufnr)
				actions.select_default:replace(function()
					actions.close(prompt_bufnr)
					local selection = action_state.get_selected_entry()

					coroutine.resume(co, selection.value)
				end)

				return true
			end,
		})
		:find()
	local result = coroutine.yield()
	return result
end
