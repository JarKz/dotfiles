local spider = require("spider")
local wk_utils = require("plugins.external_functionality.which_key.utils")
local wk = require("which-key")

wk.add(
  wk_utils.keymaps({
      w = {
        function()
          spider.motion("w")
        end,
        desc = "Spider w",
      },
      e = {
        function()
          spider.motion("e")
        end,
        desc = "Spider e",
      },
      b = {
        function()
          spider.motion("b")
        end,
        desc = "Spider b",
      },
      g = {
        name = "Go",
        e = {
          function()
            spider.motion("ge")
          end,
          desc = "Spider ge",
        },
      },
    },
    {
      mode = { "n", "o", "x" },
      remap = false,
      nowait = false,
    }
  )
)
