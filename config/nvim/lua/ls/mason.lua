require("mason").setup({
  ui = {
    border = require("window-plugins.window-config").border,
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗",
    },
  },
})
