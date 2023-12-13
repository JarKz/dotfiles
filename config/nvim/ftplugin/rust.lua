local dap = require("dap")
local uv = vim.loop

local has_value = function(tbl, target)
  for _, value in ipairs(tbl) do
    if value == target then
      return true
    end
  end
  return false
end

local reference_files = { "Cargo.toml", "Cargo.lock", "build.rs" }
local function find_app_root_path()
  local cur_dir = vim.fn.getcwd()
  local prev_path = nil
  repeat
    local found = false
    if cur_dir == "/" then
      vim.api.nvim_err_write("Not found the rust project!")
      return
    end

    local dir_content = uv.fs_scandir(cur_dir)
    if not dir_content then
      vim.api.nvim_err_write("Invalid directory and path!")
      return
    end

    repeat
      local name = uv.fs_scandir_next(dir_content)
      if has_value(reference_files, name) then
        found = true
      end
    until not name

    prev_path = cur_dir

    local next_dir = uv.fs_realpath(cur_dir .. "/..")
    if not next_dir then
      vim.api.nvim_err_write("Invalid directory and path!")
      return
    end
    cur_dir = next_dir
  until found

  return prev_path
end

local config = {
  exec_version = "Debug",
}

dap.configurations.rust = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      local root = find_app_root_path()
      if not root then
        vim.api.nvim_err_write("Not found the rust project!")
        return ""
      end
      local workspace_name = nil
      for i = root:len(), 1, -1 do
        if root:sub(i, i) == '/' then
          workspace_name = root:sub(i + 1);
          break
        end
      end
      if not workspace_name then
        vim.api.nvim_err_write("Not found the rust project!")
        return ""
      end

      root = root .. "/target"
      if config.exec_version == "Debug" then
        root = root .. "/debug"
      else
        root = root .. "/release"
      end
      return root .. "/" .. workspace_name
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},
    runInTerminal = true,
  }
}

local mapping_options = {
  mode = "n",
  prefix = "<leader>",
  buffer = 0,
  silent = true,
  noremap = true,
  nowait = false,
}

local mapping = {
  d = {
    R = {
      name = "Rust debug configuratoins",
      d = { function() config.exec_version = "Debug" end, "Set debug executable version" },
      r = { function() config.exec_version = "Release" end, "Set release executable version" },
    },
  },
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
