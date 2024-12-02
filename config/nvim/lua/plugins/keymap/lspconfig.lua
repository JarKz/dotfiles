local M = {}
local wk_utils = require("plugins.external_functionality.which_key.utils")
local wk = require("which-key")
local fzf = require("fzf-lua")

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
function M.init_global_keymaps()
  wk.add(
    wk_utils.keymaps({
        ["<space>"] = {
          name = "Special",
          e = { vim.diagnostic.open_float, desc = "Open diagnostic window" },
          q = { vim.diagnostic.setloclist, desc = "List of diagnostics" },
        },
        ["]"] = {
          name = "Right Bracket",
          d = { vim.diagnostic.goto_next, desc = "Next diagnostic" },
        },
        ["["] = {
          name = "Left Bracket",
          d = { vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
        },
      },
      {
        remap = false,
        nowait = false,
      }
    )
  )
end

-- Buffer local mappings.
-- See `:help vim.lsp.*` for documentation on any of the below functions
function M.init_buf_local_keymaps(bufnr)
  wk.add(
    wk_utils.keymaps({
        ["<space>"] = {
          name = "Special",
          w = {
            name = "Workspace",
            a = { vim.lsp.buf.add_workspace_folder, desc = "Add workspace folder" },
            r = { vim.lsp.buf.remove_workspace_folder, desc = "Remove workspace folder" },
            l = {
              function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
              end,
              desc = "List of workspace folders",
            },
          },
          D = { vim.lsp.buf.type_definition, desc = "Type definition" },
          r = {
            name = "Rename -> prefix",
            n = { vim.lsp.buf.rename, desc = "ename" },

          },
          c = {
            name = "Code action -> prefix",
            a = { vim.lsp.buf.code_action, desc = "Code action" },
          },
          f = {
            function()
              vim.lsp.buf.format({
                async = true,
              })
            end,
            desc = "Format",
          },
          K = {
            function()
              local winid = require("ufo").peekFoldedLinesUnderCursor()
              if not winid then
                vim.lsp.buf.hover()
              end
            end,
            desc = "Hower (show documentation or show fold preview)",
          },
          i = {
            function()
              if vim.lsp.inlay_hint.is_enabled() then
                vim.lsp.inlay_hint.enable(false, nil);
              else
                vim.lsp.inlay_hint.enable(true, nil);
              end
            end,
            desc = "Toggle inlay hints"
          },
        },
        g = {
          name = "Global function",
          D = { vim.lsp.buf.declaration, desc = "Declaration" },
          d = { vim.lsp.buf.definition, desc = "Definition" },
        },
        ["<C-k>"] = { vim.lsp.buf.signature_help, desc = "Signature help" },
        ["<leader>"] = {
          name = "Leader functions",
          R = { fzf.lsp_references, desc = "References" },
          I = { fzf.lsp_implementations, desc = "Implementations" },
        },
      },
      {
        buffer = bufnr,
        remap = false,
        nowait = false,
      }
    )
  )
end

return M
