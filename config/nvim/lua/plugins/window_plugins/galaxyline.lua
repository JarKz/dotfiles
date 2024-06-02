local function on_attach()
  local gl = require("galaxyline")
  local condition = require("galaxyline.condition")
  local vcs = require("galaxyline.provider_vcs")

  local colors = {
    fg = "fg",
    gray = "grey",
    red = "red",
    green = "green",
    yellow = "yellow",
    blue = "blue",
    purple = "purple",
  }

  local function mode_alias(m)
    local alias = {
      n = "NORMAL",
      i = "INSERT",
      c = "COMMAND",
      R = "REPLACE",
      t = "TERMINAL",
      [""] = "V-BLOCK",
      V = "V-LINE",
      v = "VISUAL",
    }

    return alias[m] or ""
  end

  local function mode_color(m)
    local mode_colors = {
      normal = colors.green,
      insert = colors.blue,
      visual = colors.purple,
      replace = colors.red,
    }

    local color = {
      n = mode_colors.normal,
      i = mode_colors.insert,
      c = mode_colors.replace,
      R = mode_colors.replace,
      t = mode_colors.insert,
      [""] = mode_colors.visual,
      V = mode_colors.visual,
      v = mode_colors.visual,
    }

    return color[m] or mode_colors.normal
  end

  -- disable for these file types
  gl.short_line_list = { "startify", "term", "fugitive", "NvimTree" }

  gl.section.left[1] = {
    CWD = {
      separator = "󰅂 ",
      separator_highlight = colors.gray,
      highlight = colors.green,
      provider = function()
        local dirname = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        return "   " .. dirname .. " "
      end,
    },
  }

  gl.section.left[2] = {
    FileIcon = {
      provider = "FileIcon",
      condition = condition.buffer_not_empty,
      highlight = colors.fg,
    },
  }

  local fileinfo_provider = require "galaxyline.provider_fileinfo"
  local modified_icon = ''
  local readonly_icon = ''

  gl.section.left[3] = {
    FileName = {
      provider = function()
        return fileinfo_provider.get_current_file_name(modified_icon, readonly_icon)
      end,
      condition = condition.buffer_not_empty,
      highlight = colors.fg,
      separator_highlight = colors.gray,
      separator = "󰅂",
    },
  }

  gl.section.left[4] = {
    DiffAdd = {
      icon = "  ",
      provider = function ()
        local count = vcs.diff_add()
        if count then
          return count
        else
          return "0 "
        end
      end,
      condition = condition.hide_in_width,
      highlight = colors.fg,
      separator = "|",
      separator_highlight = colors.gray,
    },
  }

  gl.section.left[5] = {
    DiffModified = {
      icon = "  ",
      provider = function ()
        local count = vcs.diff_modified()
        if count then
          return count
        else
          return "0 "
        end
      end,
      condition = condition.hide_in_width,
      highlight = colors.gray,
      separator = "|",
      separator_highlight = colors.gray,
    },
  }

  gl.section.left[6] = {
    DiffRemove = {
      icon = "  ",
      provider = function ()
        local count = vcs.diff_remove()
        if count then
          return count
        else
          return "0 "
        end
      end,
      condition = condition.hide_in_width,
      highlight = colors.gray,
      separator = "󰅁󰅂",
      separator_highlight = colors.gray,
    },
  }

  gl.section.left[7] = {
    Warns = {
      icon = "  ",
      highlight = colors.yellow,
      provider = function()
        return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      end,
      separator = " |",
      separator_highlight = colors.gray,
    },
  }

  gl.section.left[8] = {
    Errors = {
      icon = "  ",
      highlight = colors.red,
      provider = function()
        return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      end,
      separator = " |",
      separator_highlight = colors.gray,
    },
  }

  gl.section.left[9] = {
    Hint = {
      icon = " 󰰁 ",
      highlight = colors.green,
      provider = function()
        return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      end,
      separator = " |",
      separator_highlight = colors.gray,
    },
  }

  gl.section.left[10] = {
    Info = {
      icon = "  ",
      highlight = colors.blue,
      provider = function()
        return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      end,
    },
  }

  gl.section.right[1] = {
    FileType = {
      highlight = colors.gray,
      provider = function()
        local buf = require("galaxyline.provider_buffer")
        return string.lower(buf.get_buffer_filetype())
      end,
    },
  }

  gl.section.right[2] = {
    GitBranch = {
      icon = " ",
      separator = " | ",
      separator_highlight = colors.gray,
      condition = condition.check_git_workspace,
      highlight = colors.blue,
      provider = "GitBranch",
    },
  }

  gl.section.right[3] = {
    FileLocation = {
      icon = "  ",
      separator = " ",
      separator_highlight = colors.gray,
      highlight = colors.gray,
      provider = function()
        local current_line = vim.fn.line(".")
        local total_lines = vim.fn.line("$")

        if current_line == 1 then
          return "Top"
        elseif current_line == total_lines then
          return "Bot"
        end

        local percent, _ = math.modf((current_line / total_lines) * 100)
        return "" .. percent .. "%"
      end,
    },
  }

  vim.api.nvim_command("hi link GalaxyViMode green")

  gl.section.right[4] = {
    ViMode = {
      -- icon = " ",
      icon = " √",
      separator = " ",
      separator_highlight = "GalaxyViMode",
      highlight = "GalaxyViMode",
      provider = function()
        local m = vim.fn.mode() or vim.fn.visualmode()
        local mode = mode_alias(m)
        local color = mode_color(m)
        vim.api.nvim_command("hi link GalaxyViMode " .. color)
        return " " .. mode .. " "
      end,
    },
  }

  gl.section.right[5] = {
    LinePosfifx = {
      separator = "  ",
      separator_highlight = "GalaxyViMode",
      highlight = nil,
      provider = function() end,
    },
  }
end

return {
  "glepnir/galaxyline.nvim",
  branch = "main",
  config = on_attach,
  dependencies = { "nvim-tree/nvim-web-devicons", "sainnhe/sonokai", opt = true },
}
