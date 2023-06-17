local mapping_options = {
	mode = { "n", "o", "x" },
	prefix = "",
	buffer = nil,
	silent = true,
	noremap = true,
	nowait = false,
}

local spider = require("spider")

local mapping = {
	w = {
		function()
			spider.motion("w")
		end,
		"Spider w",
	},
	e = {
		function()
			spider.motion("e")
		end,
		"Spider e",
	},
	b = {
		function()
			spider.motion("b")
		end,
		"Spider b",
	},
	g = {
		e = {
			function()
				spider.motion("ge")
			end,
			"Spider ge",
		},
	},
}

local wk = require('which-key')
wk.register(mapping, mapping_options)
