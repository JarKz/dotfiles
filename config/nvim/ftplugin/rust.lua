local dap = require("dap")

---@enum ExecType
local EXEC_TYPE = {
  release = "release",
  debug = "debug",
}

local config = {
  ---@type ExecType
  exec_type = EXEC_TYPE.debug,
}

dap.configurations.rust = {
  {
    name = "Rust LLDB",
    type = "lldb",
    request = "launch",
    program = function()
      -- INFO: need to search only Cargo.lock because it points to main binary crate.
      -- Libraries can have Cargo.toml and build.rs but they aren't executable and debuggable,
      -- so they will be ignored.
      local root = vim.fs.root(vim.fn.getcwd(), { "Cargo.lock" })
      vim.print(root)
      if not root then
        vim.notify("Not found the Rust project!\nMake sure that it's not library crate!", vim.log.levels.ERROR,
          { title = "Rust LLDB" })
        return dap.ABORT
      end

      local workspace_name = vim.fs.basename(root)
      if not workspace_name then
        vim.notify("The Rust workspace name is invalid!", vim.log.levels.ERROR, { title = "Rust LLDB" })
        return dap.ABORT
      end

      vim.notify("DAP attached!", vim.log.levels.INFO, { title = "Rust LLDB" })
      return root .. "/target/" .. config.exec_type .. "/" .. workspace_name
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = true,
  }
}

require("which-key").add {
  remap = false,
  nowait = false,
  { "<leader>dR",  group = "Rust debug configurations" },
  { "<leader>dRd", function() config.exec_type = EXEC_TYPE.debug end,   desc = "Use Debug executable version" },
  { "<leader>dRr", function() config.exec_type = EXEC_TYPE.release end, desc = "Use Release executable version" },
}
