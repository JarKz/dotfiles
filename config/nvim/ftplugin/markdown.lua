local glow = require("glow")

glow.setup({
  glow_path = "/opt/homebrew/bin/glow",
  -- If executable not found and glow will install to specific path.
  -- If you don't have glow then uncomment code below and rename
  -- installation path
  -- install_path = "~/path/to/install/bin",
  border = require("window-plugins.window-config").border,
  pager = false,
  width = 100,
  height = 120,
})
