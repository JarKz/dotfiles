math.randomseed(os.time())
math.random()
math.random()
math.random()

local spinners = {
	"dots",
	"dots_negative",
	"dots_snake",
	"dots_footsteps",
	"dots_hop",
	"line",
	"pipe",
	"dots_ellipsis",
	"dots_scrolling",
	"star",
	"flip",
	"hamburger",
	"grow_vertical",
	"grow_horizontal",
	"noise",
	"dots_bounce",
	"triangle",
	"arc",
	"circle",
	"square_corners",
	"circle_quarters",
	"circle_halves",
	"dots_toggle",
	"box_toggle",
	"arrow",
	"zip",
	"bouncing_bar",
	"bouncing_ball",
	"clock",
	"earth",
	"moon",
	"dots_pulse",
	"meter",
}

local current_spinner = spinners[math.random(1, #spinners)]


require("fidget").setup({
	text = {
		spinner = current_spinner,
		commenced = "\u{25BA}", -- message shown when task starts
		completed = "\u{221A}", -- message shown when task completes
	},
	window = {
		blend = 0,
	},
	timer = {
		fidget_decay = 300,
		task_decay = 300,
	},
	fmt = {
		-- replace task = function for filtering messages
	},
})

vim.cmd("hi link FidgetTask Normal")
