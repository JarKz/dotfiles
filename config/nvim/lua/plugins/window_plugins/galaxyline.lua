local function on_attach()
  local gl = require("galaxyline")
  local condition = require("galaxyline.condition")

  -- onedark
  local colors = {
    bg = "bg0",
    bg_dim = "bg_dim",
    bg_light = "bg4",
    black = "black",
    white = "fg",
    gray = "gray",
    red = "red",
    green = "green",
    yellow = "yellow",
    blue = "blue",
    purple = "purple",
    teal = "#56b6c2",
  }

  local function make_colors_as_code(tbl_colors)
    local configuration = vim.fn['sonokai#get_configuration']()
    local palette = vim.fn['sonokai#get_palette'](configuration.style, configuration.colors_override)
    for key, value in pairs(tbl_colors) do
      if (palette[value] ~= nil) then
        tbl_colors[key] = palette[value][1]
      end
    end
  end

  make_colors_as_code(colors)

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
      visual = colors.prple,
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

    return color[m] or colors.bg_light
  end

  -- disable for these file types
  gl.short_line_list = { "startify", "term", "fugitive", "NvimTree" }

  gl.section.left[1] = {
    ViModeIcon = {
      separator = "  ",
      separator_highlight = { colors.black, colors.bg_light },
      highlight = { colors.white, colors.black },
      provider = function()
        return "   "
      end,
    },
  }

  gl.section.left[2] = {
    CWD = {
      separator = "  ",
      separator_highlight = function()
        return { colors.bg_light, condition.buffer_not_empty() and colors.bg_dim or colors.bg }
      end,
      highlight = { colors.white, colors.bg_light },
      provider = function()
        local dirname = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        return " " .. dirname .. " "
      end,
    },
  }

  gl.section.left[3] = {
    FileIcon = {
      provider = "FileIcon",
      condition = condition.buffer_not_empty,
      highlight = { colors.gray, colors.bg_dim },
    },
  }

  local fileinfo_provider = require "galaxyline.provider_fileinfo"
  local modified_icon = ' '
  local readonly_icon = ' '

  gl.section.left[4] = {
    FileName = {
      provider = function()
        return fileinfo_provider.get_current_file_name(modified_icon, readonly_icon)
      end,
      condition = condition.buffer_not_empty,
      highlight = { colors.gray, colors.bg_dim },
      separator_highlight = { colors.bg_dim, colors.bg },
      separator = "  ",
    },
  }

  gl.section.left[5] = {
    DiffAdd = {
      icon = "  ",
      provider = "DiffAdd",
      condition = condition.hide_in_width,
      highlight = { colors.white, colors.bg },
    },
  }

  gl.section.left[6] = {
    DiffModified = {
      icon = "  ",
      provider = "DiffModified",
      condition = condition.hide_in_width,
      highlight = { colors.gray, colors.bg },
    },
  }

  gl.section.left[7] = {
    DiffRemove = {
      icon = "  ",
      provider = "DiffRemove",
      condition = condition.hide_in_width,
      highlight = { colors.gray, colors.bg },
    },
  }

  gl.section.left[8] = {
    Warns = {
      icon = " ",
      highlight = { colors.yellow, colors.bg },
      provider = function()
        return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
      end,
      separator = " |",
      separator_highlight = { colors.gray, colors.bg },
    },
  }

  gl.section.left[9] = {
    Errors = {
      icon = "  ",
      highlight = { colors.red, colors.bg },
      provider = function()
        return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
      end,
      separator = " |",
      separator_highlight = { colors.gray, colors.bg },
    },
  }

  gl.section.left[10] = {
    Hint = {
      icon = " 󰰁 ",
      highlight = { colors.green, colors.bg },
      provider = function()
        return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
      end,
      separator = " |",
      separator_highlight = { colors.gray, colors.bg },
    },
  }

  gl.section.left[11] = {
    Info = {
      icon = "  ",
      highlight = { colors.blue, colors.bg },
      provider = function()
        return #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
      end,
    },
  }

  gl.section.right[1] = {
    FileType = {
      highlight = { colors.gray, colors.bg },
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
      separator_highlight = { colors.gray, colors.bg },
      condition = condition.check_git_workspace,
      highlight = { colors.teal, colors.bg },
      provider = "GitBranch",
    },
  }

  gl.section.right[3] = {
    FileLocation = {
      icon = "  ",
      separator = " ",
      separator_highlight = { colors.bg_dim, colors.bg },
      highlight = { colors.gray, colors.bg_dim },
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

  vim.api.nvim_command("hi GalaxyViModeReverse guibg=" .. colors.bg_dim)

  gl.section.right[4] = {
    ViMode = {
      -- icon = " ",
      icon = " √",
      separator = " ",
      separator_highlight = "GalaxyViModeReverse",
      highlight = { colors.bg, mode_color() },
      provider = function()
        local m = vim.fn.mode() or vim.fn.visualmode()
        local mode = mode_alias(m)
        local color = mode_color(m)
        vim.api.nvim_command("hi GalaxyViMode guibg=" .. color)
        vim.api.nvim_command("hi GalaxyViModeReverse guifg=" .. color .. " guibg=" .. colors.bg_dim)
        return " " .. mode .. " "
      end,
    },
  }

  vim.cmd([[
  function! CurrentKeymap() abort
      return &iminsert ? b:keymap_name : ""
  endfunction
  ]])

  gl.section.right[5] = {
    KeymapName = {
      separator = "  ",
      separator_highlight = "GalaxyViModeReverse",
      highlight = { colors.gray, colors.bg_dim },
      provider = function()
        local postfix = "  "
        local lang = vim.fn.CurrentKeymap()
        if lang == "ru" then
          return "Russian" .. postfix
        else
          return "ABC" .. postfix
        end
      end,
    },
  }

  gl.section.right[6] = {
    LinePosfifx = {
      separator = "  ",
      separator_highlight = { colors.bg_dim, nil },
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
