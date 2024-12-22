return {
  "chrisgrieser/nvim-rip-substitute",
  keys = {
    { "<leader>rs", function(args) require("rip-substitute").sub(args) end, desc = "Replace by ripsub", mode = { "n", "v" } }
  },
  opts = {
    popupWin = {
      border = require("config.window_config").border,
    },
  },
}
