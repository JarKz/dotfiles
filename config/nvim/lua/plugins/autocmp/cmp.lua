return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-cmdline",                 -- command line
      "hrsh7th/cmp-omni",
      "hrsh7th/cmp-buffer",                  -- buffer completions
      "hrsh7th/cmp-nvim-lua",                -- nvim config completions
      "hrsh7th/cmp-nvim-lsp",                -- lsp completions
      "hrsh7th/cmp-path",                    -- file path completions
      "hrsh7th/cmp-nvim-lsp-signature-help", -- function/class sugnature helping
      "saadparwaiz1/cmp_luasnip",            -- snippets completions
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "onsails/lspkind-nvim",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      local source_mapping = {
        buffer = "[BUF]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[Lua]",
        path = "[PATH]",
      }

      local compare = require("cmp.config.compare")
      local border = require("config.window_config").border

      -- From colorscheme sononkai for prettier percentage in tabnine
      vim.cmd("hi link CmpItemMenu Blue")

      cmp.setup({
        performance = {
          max_view_entries = 10,
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = {
            border = border,
          },
          documentation = {
            border = border,
          },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<S-CR>"] = cmp.mapping.confirm({ select = false }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp_signature_help" },
          { name = "luasnip" },
          { name = "nvim_lsp",               priority = 8 },
          { name = "spell",                  keyword_length = 3, priority = 5, keyword_pattern = [[\w\+]] },
          -- { name = "dictionary", keyword_length = 3, priority = 5, keyword_pattern = [[\w\+]] }, -- from uga-rosa/cmp-dictionary plug
          -- { name = "rg" },
          { name = "nvim_lua",               priority = 5 },
          -- { name = "path" },
          { name = "buffer",                 priority = 3 },
          { name = "calc",                   priority = 3 },
        }),
        sorting = {
          priority_weight = 2,
          comparators = {
            -- compare.score_offset, -- not good at all
            compare.offset,
            compare.exact,
            compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
            compare.recently_used,
            compare.locality,
            compare.order,
            -- compare.scopes, -- what?
            -- compare.sort_text,
            -- compare.kind,
            -- compare.length, -- useless
          },
        },
        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = lspkind.symbolic(vim_item.kind, { mode = "symbol" })
            -- vim_item.menu = source_mapping[entry.source.name]

            if source_mapping[entry.source.name] then
              vim_item.kind = vim_item.kind .. " " .. source_mapping[entry.source.name]
            end
            local maxwidth = 60
            vim_item.abbr = string.sub(vim_item.abbr, 1, maxwidth)
            return vim_item
          end,
        },
        matching = {
          disallow_fuzzy_matching = true,
          disallow_fullfuzzy_matching = true,
          disallow_partial_fuzzy_matching = true,
          disallow_partial_matching = true,
          disallow_prefix_unmatching = false,
        },
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = "buffer" },
        }),
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- For vim.ui.input using dressing.nvim
      cmp.setup.filetype("DressingInput", {
        sources = cmp.config.sources({ { name = "buffer" } }),
      })
    end,
  },
}
