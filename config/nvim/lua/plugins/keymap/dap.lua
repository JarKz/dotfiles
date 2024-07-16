local dap = require("dap")
local dapui = require("dapui")

local options = {
  width = nil,
  height = nil,
  enter = true,
}
local window_type = nil

local wk_utils = require("plugins.external_functionality.which_key.utils")
local wk = require("which-key")

wk.add(wk_utils.keymaps({
    d = {
      name = "Debug",
      r = { dap.run, desc = "Run" },
      c = { dap.continue, desc = "Continue" },
      t = { dap.toggle_breakpoint, desc = "Toggle breakpoint" },
      u = { dapui.toggle, desc = "Toggle UI" },
      f = {
        function()
          vim.print(dapui.elements)
          dapui.float_element(window_type, options)
        end,
        desc = "Open float window",
      },
    },
  },
  {
    prefix = "<leader>",
    remap = false,
    nowait = false,
  }
))
