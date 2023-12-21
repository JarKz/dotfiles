return {
  "chrisgrieser/nvim-spider",
  dependencies = {
    {
      "theHamsta/nvim_rocks",
      event = "VeryLazy",
      build = "pip3 install --user hererocks && python3 -m hererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua",
      config = function()
        local rocks = require("nvim_rocks")
        rocks.ensure_installed("luautf8")
      end,
    },
    {
      "folke/which-key.nvim",
    }
  },
  config = function()
    require("plugins.keymap.nvim_spider")
  end,
}
