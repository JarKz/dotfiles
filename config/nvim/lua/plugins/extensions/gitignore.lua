return {
  "wintermute-cell/gitignore.nvim",
  dependencies = {
    "folke/which-key.nvim",
    "ibhagwan/fzf-lua",
  },
  config = function()
    local gitignore = require("gitignore")
    local fzf = require("fzf-lua")

    gitignore.generate = function(opts)
      local picker_opts = {
        prompt = "Select templates for gitignore file> ",
        winopts = {
          width = 0.4,
          height = 0.3,
        },
        fzf_opts = {
          ["--multi"] = "",
          ["--no-multi"] = nil,
        },
        actions = {
          default = function(selected, _)
            gitignore.createGitignoreBuffer(opts.args, selected)
          end,
        },
      }
      fzf.fzf_exec(gitignore.templateNames, picker_opts)
    end

    vim.api.nvim_create_user_command("Gitignore", gitignore.generate, { nargs = "?", complete = "file" })

    require("which-key").add {
      remap = false,
      nowait = false,
      { "<space>gi", require("gitignore").generate, desc = "Generate gitignore file" },
    }
  end,
}
