local function on_attach()
  require("plugins.keymap.fzf")

  local actions = require "fzf-lua.actions"
  local fzf = require("fzf-lua")

  fzf.setup {
    winopts = {
      border  = require("config.window_config").border,
      preview = {
        default = 'bat',         -- override the default previewer?
        border  = 'border',      -- border|noborder, applies only to
      },
    },
    keymap = {
      builtin = {
        ["<C-/>"] = "toggle-help",
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up",
      },
      fzf = {
        ["ctrl-z"]     = "abort",
        ["shift-down"] = "unix-line-discard",
        ["ctrl-d"]     = "preview-page-down",
        ["ctrl-u"]     = "preview-page-up",
      },
    },
    previewers = {
      bat = {
        args  = "--style=numbers,changes --color always",
        -- theme  = 'Monokai Extended Origin', -- bat preview theme (bat --list-themes)
        theme = 'Catppuccin Latte',  -- bat preview theme (bat --list-themes)
      },
      man = {
        -- NOTE: add the `-c` flag when using not the man-db
        cmd = "man cat %s | col -bx",
      },
    },
    -- provider setup
    files = {
      prompt  = 'Files ❯ ',
      actions = {
        ["default"] = actions.file_edit,
        ["ctrl-g"]  = { actions.toggle_ignore },
      }
    },
    git = {
      files = {
        prompt       = 'GitFiles ❯ ',
      },
      commits = {
        prompt  = 'Commits ❯ ',
      },
      bcommits = {
        prompt  = 'BCommits ❯ ',
      },
      branches = {
        prompt  = 'Branches ❯ ',
      },
      stash = {
        prompt   = 'Stash ❯ ',
      },
    },
    grep = {
      prompt         = 'Rg ❯ ',
      input_prompt   = 'Grep For ❯ ',
    },
    args = {
      prompt     = 'Args ❯ ',
    },
    oldfiles = {
      prompt                  = 'History ❯ ',
    },
    buffers = {
      prompt        = 'Buffers ❯ ',
    },
    lsp = {
      prompt_postfix     = ' ❯ ', -- will be appended to the LSP label
      code_actions       = {
        prompt           = 'Code Actions ❯ ',
        winopts          = {
          row    = 0.40,
          height = 0.35,
          width  = 0.60,
        },
      },
      finder             = {
        prompt             = "LSP Finder ❯ ",
        providers          = {
          { "references",      prefix = require("fzf-lua").utils.ansi_codes.blue("ref ") },
          { "definitions",     prefix = require("fzf-lua").utils.ansi_codes.green("def ") },
          { "declarations",    prefix = require("fzf-lua").utils.ansi_codes.magenta("decl") },
          { "typedefs",        prefix = require("fzf-lua").utils.ansi_codes.red("tdef") },
          { "implementations", prefix = require("fzf-lua").utils.ansi_codes.green("impl") },
          { "incoming_calls",  prefix = require("fzf-lua").utils.ansi_codes.cyan("in  ") },
          { "outgoing_calls",  prefix = require("fzf-lua").utils.ansi_codes.yellow("out ") },
        },
      }
    },
  }
end

return {
  "ibhagwan/fzf-lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/which-key.nvim",
  },
  config = on_attach,
}
