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

local wk_utils = require("plugins.external_functionality.which_key.utils")
local wk = require("which-key")

wk.add(
  wk_utils.keymaps({
      f = {
        name = "Find",
        t = {
          toggle,
          desc = "Toggle FZF",
        },
        f = {
          fzf.files,
          desc = "Files",
        },
        h = {
          fzf.help_tags,
          desc = "Help",
        },
        b = {
          fzf.buffers,
          desc = "Buffers",
        },
      },
      g = {
        name = "Grep",
        l = {
          fzf.live_grep,
          desc = "Live grep",
        },
        c = {
          fzf.grep_curbuf,
          desc = "Code grep",
        },
      },
    },
    {
      prefix = "<leader>",
      remap = false,
      nowait = false,
    }
  )
)
