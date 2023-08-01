local jdtls_ui = require("jdtls.ui")
local fzf = require("fzf-lua")

local window_settings = {
	winopts = {
		width = 0.4,
		height = 0.3,
	},
}

local large_window_settings = {
	winopts = {
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

local function pick_many(items, prompt, label_f, opts)
	local co = coroutine.running()

	opts = opts or window_settings
	if get_max_length(items, label_f) > 40 then
		opts = large_window_settings
	end
	opts.prompt = prompt

	local choices = {}
	for _, item in pairs(items) do
		choices[label_f(item)] = item
	end
	opts.actions = {
		default = function(selected, _)
			local s_items = {}
			for _, selected_item in ipairs(selected) do
				local item = choices[selected_item]
				table.insert(s_items, item)
			end
			coroutine.resume(co, s_items)
		end
	}
	fzf.fzf_exec(
		function(fzf_cb)
			for labeled_item, _ in pairs(choices) do
				fzf_cb(labeled_item)
			end
			fzf_cb()
		end,
		opts
	)
	local result = coroutine.yield()
	return result
end

jdtls_ui.pick_many = pick_many

local function pick_one(items, prompt, label_f)
	local co = coroutine.running()

	local opts = window_settings
	if get_max_length(items, label_f) > 40 then
		opts = large_window_settings
	end
	opts.prompt = prompt

	local choices = {}
	for _, item in pairs(items) do
		choices[label_f(item)] = item
	end
	opts.actions = {
		default = function(selected, _)
			vim.print(selected)
			coroutine.resume(co, choices[selected[1]])
		end
	}
	fzf.fzf_exec(
		function(fzf_cb)
			for labeled_item, _ in pairs(choices) do
				fzf_cb(labeled_item)
			end
			fzf_cb()
		end,
		opts
	)
	local result = coroutine.yield()
	vim.print(result)
	return result
end

jdtls_ui.pick_one = pick_one
