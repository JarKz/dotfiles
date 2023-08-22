local function map_hl(source, destination)
  for key, value in pairs(source) do
    if key ~= "link" then
      destination[key] = value
    end
  end
end

local function set_italic_for_virtual_text(type)
  local hl_name = "DiagnosticVirtualText" .. type

  local hl = vim.api.nvim_get_hl(0, { name = hl_name })
  hl.italic = true
  if hl.link then
    local innerHL = vim.api.nvim_get_hl(0, { name = hl.link })
    while innerHL.link do
      map_hl(innerHL, hl)
      innerHL = vim.api.nvim_get_hl(0, { name = innerHL.link })
    end
    map_hl(innerHL, hl)
    hl.link = nil
  end
  vim.api.nvim_set_hl(0, hl_name, hl)
end

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })

  set_italic_for_virtual_text(type)
end

local border = require("window-plugins.window-config").border

vim.diagnostic.config({
  virtual_text = {
    prefix = "",
    format = function(diagnostic)
      if diagnostic.severity == vim.diagnostic.severity.ERROR then
        return signs.Error .. " " .. diagnostic.message
      end
      if diagnostic.severity == vim.diagnostic.severity.WARN then
        return signs.Warn .. " " .. diagnostic.message
      end
      if diagnostic.severity == vim.diagnostic.severity.INFO then
        return signs.Info .. " " .. diagnostic.message
      end
      if diagnostic.severity == vim.diagnostic.severity.HINT then
        return signs.Hint .. " " .. diagnostic.message
      end
    end,
  },
  update_in_insert = false,
  float = {
    border = border,
    source = "always",
  },
})
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
