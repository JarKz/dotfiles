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

    ---@class vim.api.keyset.hl_info
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

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "sainnhe/sonokai",
    "folke/which-key.nvim",
    "saghen/blink.cmp",
  },

  opts = {
    servers = {
      pyright = {},
      gradle_ls = {},
      groovyls = {},
      ts_ls = {},
      cssls = {},
      html = {},
      bashls = {},
      rust_analyzer = {
        settings = {
          ['rust-analyzer'] = {
            check = {
              command = 'clippy'
            },
            cargo = {
              buildScript = {
                enable = true,
              },
            },
          }
        }
      },
      nil_ls = {},
    },

    efm = {
      init_options = {
        documentFormatting = true,
      },
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
    },
  },

  config = function(_, opts)
    local lspconfig = require("lspconfig")

    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      config.capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      lspconfig[server].setup(config)
    end

    lspconfig.efm.setup(opts.efm)

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
  end,
}
