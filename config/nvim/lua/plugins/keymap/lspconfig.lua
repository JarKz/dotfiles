local M = {}
local wk = require("which-key")
local fzf = require("fzf-lua")

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
function M.init_global_keymaps()
  local mapping_options = {
    mode = "n",
    prefix = "",
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = false,
  }

  local mapping = {
    ["<space>"] = {
      name = "Special",
      e = { vim.diagnostic.open_float, "Open diagnostic window" },
      q = { vim.diagnostic.setloclist, "List of diagnostics" },
    },
    ["]"] = {
      d = { vim.diagnostic.goto_next, "Next diagnostic" },
    },
    ["["] = {
      d = { vim.diagnostic.goto_prev, "Previous diagnostic" },
    },
  }
  wk.register(mapping, mapping_options)
end

local ignore_lsp_servers = { jdtls = true }
local function table_contains(tbl, element)
  return not tbl[element]
end

-- Buffer local mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
function M.init_buf_local_keymaps(bufnr)
  local lsp_mapping_options = {
    mode = "n",
    prefix = "",
    buffer = bufnr,
    silent = true,
    noremap = true,
    nowait = false,
  }

  local lsp_mapping = {
    ["<space>"] = {
      name = "Special",
      w = {
        name = "Workspace",
        a = { vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
        r = { vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
        l = {
          function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end,
          "List of workspace folders",
        },
      },
      D = { vim.lsp.buf.type_definition, "Type definition" },
      r = {
        name = "Rename -> prefix",
        n = { vim.lsp.buf.rename, "Rename" },
      },
      c = {
        name = "Code action -> prefix",
        a = { vim.lsp.buf.code_action, "Code action" },
      },
      f = {
        function()
          vim.lsp.buf.format({
            async = true,
            filter = function(client)
              return table_contains(ignore_lsp_servers, client.name)
            end
          })
        end,
        "Format",
      },
      E = {
        function()
          local winid = require("ufo").peekFoldedLinesUnderCursor()
          if not winid then
            vim.lsp.buf.hover()
          end
        end,
        "Hower (show documentation or show fold preview)",
      },
      i = {
        function()
          if vim.lsp.inlay_hint.is_enabled() then
            vim.lsp.inlay_hint.enable(nil, false);
          else
            vim.lsp.inlay_hint.enable(nil, true);
          end
        end,
        "Toggle inlay hints"
      },
    },
    g = {
      name = "Global function",
      D = { vim.lsp.buf.declaration, "Declaration" },
      d = { vim.lsp.buf.definition, "Definition" },
    },
    -- ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature help" },
    --
    -- Colemak
    ["<C-e>"] = { vim.lsp.buf.signature_help, "Signature help" },
    ["<leader>"] = {
      name = "Leader functions",
      R = { fzf.lsp_references, "References" },
      I = { fzf.lsp_implementations, "Implementations" },
    },
  }
  wk.register(lsp_mapping, lsp_mapping_options)
end

return M
