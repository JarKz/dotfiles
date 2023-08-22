local WindowSettings = {
  hlGroups = {
    "NormalFloat",
    "FloatBorder",
    "Pmenu",
  },
  --- from package toggleterm.nvim
  border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
}

--- @param groups table
WindowSettings.make_float_transparent = function(groups)
  for _, name in ipairs(groups) do
    local hl = vim.api.nvim_get_hl(0, { name = name })
    hl.ctermbg = "NONE"
    hl.bg = "NONE"
    vim.api.nvim_set_hl(0, name, hl)
  end
end

return WindowSettings
