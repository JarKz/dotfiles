-- Disable insert mode when I leave telescope prompt
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  group = vim.api.nvim_create_augroup("DisableInsertMode", {}),
  pattern = "?*",
  callback = function(ev)
    local filename = vim.fn.fnamemodify(ev.file, ":t")
    local dap_repl = "[dap-repl]"
    if filename and (filename:sub(1, 3) == "DAP" or filename:sub(1, #dap_repl) == dap_repl) then
      return
    end
    vim.cmd("silent! stopinsert")
  end,
})
