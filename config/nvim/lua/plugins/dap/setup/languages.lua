local dap = require('dap')

dap.adapters.lldb = {
  type = 'executable',
  command = os.getenv("LLDB"),
  name = 'lldb',
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = true,
  },
}
dap.configurations.c = dap.configurations.cpp
