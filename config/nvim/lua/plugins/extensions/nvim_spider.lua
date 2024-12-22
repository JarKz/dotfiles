return {
  "chrisgrieser/nvim-spider",
  dependencies = {
    {
      "theHamsta/nvim_rocks",
      event = "VeryLazy",
      build = "python -m venv venv && source venv/bin/activate && pip install hererocks && python3 -m hererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua",
      config = function()
        local rocks = require("nvim_rocks")
        rocks.ensure_installed("luautf8")
      end,
    },
    {
      "folke/which-key.nvim",
    }
  },
  config = function(_, opts)
    local spider = require("spider")
    spider.setup(opts)

    require("which-key").add {
      remap = false,
      nowait = false,
      mode = { "n", "o", "x" },
      { "w",  function() spider.motion("w") end,  desc = "Spider motion w" },
      { "e",  function() spider.motion("e") end,  desc = "Spider motion e" },
      { "b",  function() spider.motion("b") end,  desc = "Spider motion b" },
      { "ge", function() spider.motion("ge") end, desc = "Spider motion ge" },
    }
  end,
}
