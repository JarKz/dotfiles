local java_boilerplate = require("extensions.java.boilerplate")
local fzf = require("fzf-lua")

local wk_utils = require("plugins.external_functionality.which_key.utils")
local wk = require("which-key")
wk.add(
  wk_utils.keymaps({
      b = {
        name = "Boilerplate code",
        j = {
          function()
            local picker_opts = {
              prompt = "Select name of boilerplate templates> ",
              winopts = {
                width = 0.4,
                height = 0.3,
              },
              actions = {
                default = function(selected, _)
                  local code = java_boilerplate.get_code(selected[1])
                  vim.api.nvim_put(code, "l", true, true)
                end,
              },
            }
            fzf.fzf_exec(function(fzf_cb)
              for _, name in ipairs(java_boilerplate.get_groups()) do
                fzf_cb(name)
              end
              fzf_cb()
            end, picker_opts)
          end,
          desc = "Java boilerplate code"
        },
      }
    },
    {
      prefix = "<leader>",
      remap = false,
      nowait = false,
    }
  )
)
