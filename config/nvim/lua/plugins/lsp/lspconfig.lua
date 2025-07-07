local border = require("config.window_config").border

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
      hls = {},
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
    local function tbl_len(tbl)
      local count = 0
      for _ in pairs(tbl) do count = count + 1 end
      return count
    end

    for server, config in pairs(opts.servers) do
      config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
      config.capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }

      vim.lsp.enable(server)
      if tbl_len(config) > 0 then
        vim.lsp.config(server, config)
      end
    end

    vim.lsp.enable("efm")
    vim.lsp.config("efm", opts.efm)

    -- Use LspAttach autocommand to only map the following keys
    -- after the language server attaches to the current buffer
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf });

        local wk = require("which-key")
        local fzf = require("fzf-lua")
        wk.add {
          buffer = ev.buf,
          remap = false,
          nowait = false,
          { "<space>e",  vim.diagnostic.open_float,                                        desc = "Open diagnostic window" },
          { "K",         function() vim.lsp.buf.hover({ border = border }) end,            desc = "Hover element" },
          { "]d",        function() vim.diagnostic.jump({ count = 1, float = true }) end,  desc = "Next diagnostic entry" },
          { "[d",        function() vim.diagnostic.jump({ count = -1, float = true }) end, desc = "Previous diagonostic entry" },
          { "<space>D",  vim.lsp.buf.type_definition,                                      desc = "Type definition" },
          { "<space>rn", vim.lsp.buf.rename,                                               desc = "Rename" },
          { "<space>ca", vim.lsp.buf.code_action,                                          desc = "Code action" },
          { "<space>f",  function() vim.lsp.buf.format { async = true } end,               desc = "Format buffer" },
          {
            "<space>K",
            function()
              local winid = require("ufo").peekFoldedLinesUnderCursor()
              if not winid then
                vim.lsp.buf.hover({ border = border })
              end
            end,
            desc = "Hower (show documentation or show fold preview)"
          },
          {
            "<space>i",
            function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), nil)
            end,
            desc = "Toggle inlay hints"
          },
          { "gD",        vim.lsp.buf.declaration,                                        desc = "Go to Declaration" },
          { "gd",        vim.lsp.buf.definition,                                         desc = "Go to Definition" },
          { "<C-k>",     function() vim.lsp.buf.signature_help({ border = border }) end, desc = "Signature help" },
          { "<leader>R", fzf.lsp_references,                                             desc = "Show references" },
          { "<leader>I", fzf.lsp_implementations,                                        desc = "Show implementations" }
        }
      end,
    })

    update_diagnostic_ui()
  end,
}
