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
      require('plugins.keymap.dap')
    end,
  },
}
