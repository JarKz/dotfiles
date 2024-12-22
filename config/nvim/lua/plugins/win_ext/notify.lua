---@param link_from string the highlight which will be cleared and linked to hl destination
---@param link_to string the highliht to which will be linked hl origin
local function clear_and_link_to(link_from, link_to)
  ---@class vim.api.keyset.hl_info
  local notify_info_icon = vim.api.nvim_get_hl(0, { name = link_from })
  notify_info_icon.fg = nil
  notify_info_icon.link = link_to
  vim.api.nvim_set_hl(0, link_from, notify_info_icon)
end

local function fix_notify_hightlights()
  clear_and_link_to("NotifyINFOIcon", "green")
  clear_and_link_to("NotifyINFOTitle", "green")
end

return {
  "rcarriga/nvim-notify",
  opts = {
    render = "compact",
    background_colour = function()
      ---@class vim.api.keyset.hl_info
      local hl = vim.api.nvim_get_hl(0, { name = "Normal" })
      if hl.background == nil then
        return "#000000"
      end
      return "NotifyBackground"
    end,
    timeout = 50,
  },
  config = function(_, opts)
    local notify = require('notify')
    notify.setup(opts)
    vim.notify = notify

    fix_notify_hightlights()
  end
}
