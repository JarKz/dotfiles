vim.api.nvim_command("command RipSub RipSubstitute")

return {
  "chrisgrieser/nvim-rip-substitute",
  cmd = "RipSubstitute",
  opts = {
    popupWin = {
      border = require("config.window_config").border,
    },
  },
};
