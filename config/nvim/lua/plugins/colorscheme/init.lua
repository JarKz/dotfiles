vim.api.nvim_create_autocmd({ "ColorScheme" }, {
  callback = function()
    local WindowSettings = require("config.window_config")
    WindowSettings.make_float_transparent(WindowSettings.hlGroups)
  end
})

return {
  {
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

      -- vim.cmd("colorscheme sonokai")
    end,
  }, {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    opts = {
      custom_highlights = function(colors)
        return {
          red = { fg = colors.red },
          blue = { fg = colors.blue },
          yellow = { fg = colors.yellow },
          purple = { fg = colors.flamingo },
          grey = { fg = "#716f71" },
          green = { fg = colors.green },
        }
      end
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin-latte")
    end,
  }
}
