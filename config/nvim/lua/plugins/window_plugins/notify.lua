return {
  "rcarriga/nvim-notify",
  opts = {
    render = "compact",
    background_colour = function()
      local hl = vim.api.nvim_get_hl_by_name("Normal", true)
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
  end
}
