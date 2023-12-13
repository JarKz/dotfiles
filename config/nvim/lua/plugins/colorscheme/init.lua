return {
  "sainnhe/sonokai",
  config = function()
    local styles = {
      "default",
      "atlantis",
      "andromeda",
      "shusia",
      "maia",
      "espresso"
    }

    math.randomseed(os.time())
    math.random()
    math.random()
    math.random()

    local current_style = styles[math.random(1, #styles)]
    local global = vim.g
    global.sonokai_style = current_style
    global.sonokai_better_performance = true
    global.sonokai_diagnostic_text_highliht = true
    global.sonokai_diagnostic_virtual_text = 'colored'
    global.sonokai_transparent_background = true
    global.sonokai_dim_inactive_windows = true
    global.sonokai_enable_italic = true

    vim.cmd("colorscheme sonokai")

    local WindowSettings = require("config.window_config")
    WindowSettings.make_float_transparent(WindowSettings.hlGroups)
  end,
}
