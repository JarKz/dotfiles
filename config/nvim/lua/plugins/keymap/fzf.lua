local fzf = require("fzf-lua")

local function toggle()
  fzf.fzf_exec(function(fzf_cb)
    for key, value in pairs(fzf) do
      if type(value) == "function" and string.match(key, "complete") == nil then
        fzf_cb(key)
      end
      fzf_cb()
    end
  end, {
    actions = {
      ["default"] = function(selected, _)
        fzf[selected[1]]()
      end,
    },
  })
end

local mapping = {
  f = {
    name = "Find",
    t = {
      toggle,
      "Toggle FZF",
    },
    f = {
      fzf.files,
      "Files",
    },
    h = {
      fzf.help_tags,
      "Help",
    },
    b = {
      fzf.buffers,
      "Buffers",
    },
  },
  g = {
    name = "Grep",
    l = {
      fzf.live_grep,
      "Live grep",
    },
    c = {
      fzf.grep_curbuf,
      "Code grep",
    },
  },
}

local mapping_options = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

local wk = require("which-key")
wk.register(mapping, mapping_options)
