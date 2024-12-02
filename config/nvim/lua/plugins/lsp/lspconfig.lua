local function update_diagnostic_ui()
  --- @param source table of source highlight params
  --- @param destination table of destination highlight params
  local function map_hl(source, destination)
    for key, value in pairs(source) do
      if key ~= "link" then
        destination[key] = value
      end
    end
  end

  --- Turning on italic style for highlight with specific severity name.
  --- @param severity string the severity name
  local function set_italic_for_virtual_text(severity)
    local hl_name = "DiagnosticVirtualText" .. severity

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

  local severities = { 'Error', 'Warn', 'Hint', 'Info' }

  for _, severity in ipairs(severities) do
    set_italic_for_virtual_text(severity)
  end

  local signs = {
    [vim.diagnostic.severity.ERROR] = " ",
    [vim.diagnostic.severity.WARN] = " ",
    [vim.diagnostic.severity.HINT] = "󰰁 ",
    [vim.diagnostic.severity.INFO] = " "
  }

  local border = require("config.window_config").border

  vim.diagnostic.config({
    virtual_text = {
      prefix = function(diagnostic, _, _)
        return signs[diagnostic.severity]
      end,
    },
    update_in_insert = false,
    float = {
      border = border,
      source = "always",
    },
    signs = {
      text = signs,
      hl = {
        [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
        [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
        [vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
        [vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
      }
    },
    severity_sort = true,
  })
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
end

local function on_attach()
  local lspconfig = require("lspconfig")
  local lsp_defaults = lspconfig.util.default_config

  lsp_defaults.capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  lsp_defaults.capabilities =
      vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

  local servers = {
    "pyright",
    "gradle_ls",
    "groovyls",
    "ts_ls",
    "cssls",
    "html",
    "bashls",
    "rust_analyzer",
    "nil_ls",
  }

  for _, server in ipairs(servers) do
    lspconfig[server].setup({})
  end

  lspconfig.efm.setup({
    init_options = { documentFormatting = true },
    cmd = { "efm-langserver", "-c=" .. os.getenv("XDG_CONFIG_HOME") .. "/efm-langserver/config.yaml" },
    filetypes = {
      "markdown",
      "json",
      "json5",
      "text",
      "help",
      "cpp",
      "c",
      "sh",
      "bash",
      "zsh",
      "yaml",
      "javascript",
      "typescript",
      "css",
      "scss",
      "sass",
      "less",
      "sugarss",
      "html",
      "xml",
      "python",
      "nix"
    },
  })

  local keymap = require('plugins.keymap.lspconfig')
  keymap.init_global_keymaps()

  -- Use LspAttach autocommand to only map the following keys
  -- after the language server attaches to the current buffer
  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
      -- Enable completion triggered by <c-x><c-o>
      vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
      vim.lsp.inlay_hint.enable(true, nil);
      keymap.init_buf_local_keymaps(ev.buf)
    end,
  })

  update_diagnostic_ui()
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "sainnhe/sonokai",
    "folke/which-key.nvim",
  },
  config = on_attach,
}
