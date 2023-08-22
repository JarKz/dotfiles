local signs = {
  DapBreakpoint = { text = "", texthl = "red", linehl = "", numhl = "" },
  DapBreakpointCondition = { text = "", texthl = "blue", linehl = "", numhl = "" },
  DapBreakpointRejected = { text = "", texthl = "yellow", linehl = "", numhl = "" },
  DapLogPoint = { text = "L", texthl = "", linehl = "", numhl = "" },
  -- DapStopped = { text = "→", texthl = "", linehl = "debugPC", numhl = "" },
  DapStopped = { text = "", texthl = "green", linehl = "debugPC", numhl = "" },
}

local function try_sign_redefine(name)
  local opts = signs[name]
  vim.fn.sign_define(name, opts)
end

for name in pairs(signs) do
  try_sign_redefine(name)
end
