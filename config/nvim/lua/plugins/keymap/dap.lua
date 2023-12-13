local dap = require("dap")
local dapui = require("dapui")

local mapping_options = {
  mode = "n",
  prefix = "",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local options = {
  width = nil,
  height = nil,
  enter = true,
}
local window_type = nil

local mapping = {
  ["<leader>"] = {
    name = "Leader functions",
    d = {
      name = "Debug",
      r = { dap.run, "Run" },
      c = { dap.continue, "Continue" },
      t = { dap.toggle_breakpoint, "Toggle breakpoint" },
      u = { dapui.toggle, "Toggle UI" },
      f = {
        function()
          vim.print(dapui.elements)
          dapui.float_element(window_type, options)
        end,
        "Open float window",
      },
    },
  },
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
