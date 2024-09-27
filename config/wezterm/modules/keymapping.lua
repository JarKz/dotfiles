local M = {}

local wezterm = require("wezterm")

--- @param config table The user's wezterm configuration
function M.apply(config)
  config.leader = {
    key = 'a',
    mods = 'CTRL',
    timeout_milliseconds = 1000,
  }

  config.keys = {

    -- Split
    {
      key = "|",
      mods = "LEADER|SHIFT",
      action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "-",
      mods = "LEADER",
      action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },

    -- Close pane
    {
      key = "x",
      mods = "LEADER",
      action = wezterm.action.CloseCurrentPane({ confirm = false }),
    },

    -- Send key
    {
      key = "a",
      mods = "LEADER",
      action = wezterm.action.SendKey({
        key = "a",
        mods = "CTRL",
      }),
    },

    -- Pane navigation
    {
      key = "n",
      mods = "LEADER",
      action = wezterm.action.ActivateKeyTable {
        name = "activate_pane",
        one_shot = false,
        replace_current = true,
      }
    },

    -- Resize pane
    {
      key = "r",
      mods = "LEADER",
      action = wezterm.action.ActivateKeyTable {
        name = "resize_pane",
        one_shot = false,
        replace_current = true,
      }
    },

    -- Command palette
    {
      key = "K",
      mods = "CTRL",
      action = wezterm.action.ActivateCommandPalette,
    },

    -- Toogle pane zoom
    {
      key = "m",
      mods = "LEADER",
      action = wezterm.action.TogglePaneZoomState,
    },

    -- Tab navigator
    {
      key = "w",
      mods = "LEADER",
      action = wezterm.action.ShowTabNavigator,
    },

    -- Spawn tab
    {
      key = "c",
      mods = "LEADER",
      action = wezterm.action.SpawnTab("DefaultDomain"),
    },

    -- Go to the next tab
    {
      key = "t",
      mods = "LEADER",
      action = wezterm.action.ActivateKeyTable {
        name = 'activate_tab',
        one_shot = false,
        replace_current = true,
      }
    },

    -- Scroll by line
    {
      key = "UpArrow",
      mods = "SHIFT",
      action = wezterm.action.ScrollByLine(-1),
    },
    {
      key = "DownArrow",
      mods = "SHIFT",
      action = wezterm.action.ScrollByLine(1),
    },

    -- Scroll by half to up and down
    {
      key = "PageUp",
      mods = "SHIFT",
      action = wezterm.action.ScrollByPage(-0.5),
    },
    {
      key = "PageDown",
      mods = "SHIFT",
      action = wezterm.action.ScrollByPage(0.5),
    },
  }

  config.key_tables = {
    resize_pane = {
      { key = 'h',      action = wezterm.action.AdjustPaneSize { "Left", 5 } },
      { key = 'l',      action = wezterm.action.AdjustPaneSize { "Right", 5 } },
      { key = 'k',      action = wezterm.action.AdjustPaneSize { "Up", 5 } },
      { key = 'j',      action = wezterm.action.AdjustPaneSize { "Down", 5 } },
      { key = "Escape", action = "PopKeyTable" }
    },

    activate_pane = {
      { key = 'h',      action = wezterm.action.ActivatePaneDirection 'Left' },
      { key = 'l',      action = wezterm.action.ActivatePaneDirection 'Right' },
      { key = 'k',      action = wezterm.action.ActivatePaneDirection 'Up' },
      { key = 'j',      action = wezterm.action.ActivatePaneDirection 'Down' },
      { key = "Escape", action = "PopKeyTable" }
    },

    activate_tab = {
      { key = 'h',      action = wezterm.action.ActivateTabRelative(-1) },
      { key = 'l',      action = wezterm.action.ActivateTabRelative(1) },
      { key = "Escape", action = "PopKeyTable" }
    }
  }
end

return M
