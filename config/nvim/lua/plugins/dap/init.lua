return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "stevearc/dressing.nvim",
          "nvim-neotest/nvim-nio",
        },
        opts = {
          layouts = { {
            elements = { {
              id = "repl",
              size = 0.4,
            }, {
              id = "scopes",
              size = 0.6,
            } },
            position = "bottom",
            size = 10,
          }, },
          floating = {
            border = "rounded",
            mappings = {
              close = { "q", "<Esc>" },
            },
          },
        },
      },
      { "folke/which-key.nvim", }
    },
    config = function()
      require('plugins.dap.setup.configuration')
      require('plugins.dap.setup.languages')
      require('plugins.dap.setup.breakpoints')

      local dap = require("dap")
      local dapui = require("dapui")

      require("which-key").add {
        remap = false,
        nowait = false,
        { "<leader>d",  group = "Debug" },
        { "<leader>dr", dap.run,               desc = "Run debug adapter" },
        { "<leader>dc", dap.continue,          desc = "Continue debug adapter" },
        { "<leader>dt", dap.toggle_breakpoint, desc = "Toggle DAP breakpoint" },
        { "<leader>du", dapui.toggle,          desc = "Toggle DapUI" },
        {
          "<leader>df",
          function()
            dapui.float_element(nil, { width = nil, height = nil, enter = true })
          end,
          desc = "Open float window",
        }
      }
    end,
  },
}
