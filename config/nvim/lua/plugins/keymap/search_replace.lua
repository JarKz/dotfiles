local n_mode_mapping_options = {
  mode = { "n" },
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local single_b = require("search-replace.single-buffer")
local multi_b = require("search-replace.multi-buffer")

--- Call the vim.ui.select() for select one from three
--- variants:
---  * All suggestions
---  * From here and below
---  * From here and below (certains)
--- @param cb_repl function
local replace_selection = function(cb_repl)
  local items = {
    "All suggestions",
    "From here and below",
    "From here and below (certains)"
  }
  local opts = {
    prompt = "",
    format_item = function(item)
      return item
    end
  }
  local cb = function(choice)
    if choice == items[1] then
      cb_repl({ flags = "gI" })
    elseif choice == items[2] then
      cb_repl({ range = ",$", flags = "gI" })
    elseif choice == items[3] then
      cb_repl({ range = ",$", flags = "gc" })
    end
  end
  vim.ui.select(items, opts, cb)
end
local ui = require("search-replace.ui")

local n_mode_mapping = {
  r = {
    name = "Replace in single buffer",
    s = { ui.single_buffer_selections, "Selection" },
    o = { function() replace_selection(single_b.open) end, "Open" },
    w = { function() replace_selection(single_b.cword) end, "CWord" },
    W = { function() replace_selection(single_b.cWORD) end, "CWORD" },
    e = { function() replace_selection(single_b.cexpr) end, "CExpr" },
    f = { function() replace_selection(single_b.cfile) end, "CFile" },
    b = {
      name = "Replace in multibuffer",
      s = { ui.multi_buffer_selections, "Selection" },
      o = { function() replace_selection(multi_b.open) end, "Open" },
      w = { function() replace_selection(multi_b.cword) end, "CWord" },
      W = { function() replace_selection(multi_b.cWORD) end, "CWORD" },
      e = { function() replace_selection(multi_b.cfile) end, "CFile" },
      f = { function() replace_selection(multi_b.cexpr) end, "CExpr" },
    },
  },
}

local wk = require("which-key")
wk.register(n_mode_mapping, n_mode_mapping_options)

local v_mode_mapping_options = {
  mode = "x",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local visual_multitype = require("search-replace.visual-multitype")

local v_mode_mapping = {
  r = {
    name = "Visual replace",
    o = { visual_multitype.within, "Open" },
    w = { visual_multitype.within_cword, "CWord" },
    W = { visual_multitype.within_cWORD, "CWORD" },
    e = { visual_multitype.within_cfile, "CFile" },
    f = { visual_multitype.within_cexpr, "CExpr" },

    s = { single_b.visual_charwise_selection, "Single buffer visual charwise selection" },
    m = { multi_b.visual_charwise_selection, "Multi buffer visual charwise selection" },
  },
}

wk.register(v_mode_mapping, v_mode_mapping_options)
