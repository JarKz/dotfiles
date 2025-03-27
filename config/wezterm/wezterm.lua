local wezterm = require("wezterm")

local config = {
  -- color_scheme = "Sonokai (Gogh)",
  color_scheme = "catppuccin-latte",
  font = wezterm.font("JetBrainsMono Nerd Font Mono"),
  font_size = 14,
  check_for_updates = false,
  enable_tab_bar = true,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  hide_tab_bar_if_only_one_tab = false,
  show_new_tab_button_in_tab_bar = false,
  xcursor_theme = "Bibata-Modern-Classic",
}

for k, v in pairs(wezterm.config_builder()) do
  if config[k] == nil then
    config[k] = v
  end
end

require("modules.tabs").apply(config)
require("modules.keymapping").apply(config)

return config
