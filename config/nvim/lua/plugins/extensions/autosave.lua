return {
  "Pocco81/auto-save.nvim",
  -- To avoid duplicate of message
  branch = "dev",
  opts = {
    enabled = true,
    execution_message = {
      message = function()
        local msg = "* Saved at " .. vim.fn.strftime("%H:%M:%S")
        vim.notify(msg, vim.log.levels.INFO, { timeout = 30 })
        return ""
      end,
      dim = 0.18,               -- dim the color of `message`
      cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying `message`. See :h MsgArea
    },
    -- trigger_events = { "InsertLeave", "QuitPre", "ExitPre", "VimLeavePre", "CursorHold" },--[[  also can "TextChange"  ]]
    trigger_events = { "InsertLeave", "QuitPre", "ExitPre", "VimLeavePre", },
    condition = function(buf)
      local fn = vim.fn

      local bufname = fn.bufname(buf)
      local oil_path = "oil://"
      if bufname:sub(1, oil_path:len()) == oil_path then
        return false
      end

      local utils = require("auto-save.utils.data")

      local isModidified = fn.getbufvar(buf, "&modified")
      local isModifiable = fn.getbufvar(buf, "&modifiable")
      local isFile = utils.not_in(fn.getbufvar(buf, "&filetype"), {})
      if isModifiable and isModidified and isFile then
        return true
      end
      return false -- can't save
    end,
    -- conditions = {
    -- 	exists = true,
    -- 	filename_is_not = {},
    -- 	filetype_is_not = {},
    -- 	modifiable = true
    -- },
    write_all_buffers = false,
    -- on_off_commands = true,
    -- clean_command_line_interval = 0,
    debounce_delay = 135,
    callbacks = {
      -- functions to be executed at different intervals
      enabling = nil,              -- ran when enabling auto-save
      disabling = nil,             -- ran when disabling auto-save
      before_asserting_save = nil, -- ran before checking `condition`
      before_saving = nil,         -- ran before doing the actual save
      after_saving = nil,          -- ran after doing the actual save
    },
  },
}
