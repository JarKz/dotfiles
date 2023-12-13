local function update_highlights()
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

  local border = require("config.window_config").border

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

  -- WARNING: It's available for neovim-nightly version
  vim.cmd("hi link LspInlayHint @lsp.type.comment")
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
    "tsserver",
    "cssls",
    "html",
    "bashls",
    "rust_analyzer",
    "kotlin_language_server",
    "clangd",
  }
  for _, server in ipairs(servers) do
    lspconfig[server].setup({})
  end

  lspconfig.efm.setup({
    init_options = { documentFormatting = true },
    cmd = { "efm-langserver", "-c=" .. os.getenv("XDG_CONFIG_HOME") .. "/efm-langserver/config.yaml" },
    filetypes = {
      "java",
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
      "python"
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
      vim.lsp.inlay_hint.enable(nil, true);
      keymap.init_buf_local_keymaps(ev.buf)
    end,
  })

  update_highlights()
end

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "sainnhe/sonokai",
    "folke/which-key.nvim",
  },
  config = on_attach,
}
