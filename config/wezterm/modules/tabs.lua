local wezterm = require 'wezterm'

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
  local title = tab_info.tab_title
  -- if the tab title is explicitly set, take that
  if title and #title > 0 then
    return " " .. title .. " "
  end
  -- Otherwise, use the title from the active pane
  -- in that tab
  return " " .. tab_info.active_pane.title .. " "
end

wezterm.on(
  'format-tab-title',
  function(tab, tabs, panes, config, hover, max_width)
    local palette = config.resolved_palette

    local edge_background = config.colors.tab_bar.background
    local background = palette.brights[1]
    local foreground = "#FFFFFF"

    if tab.is_active then
      background = palette.ansi[7]
    end

    local edge_foreground = background

    local title = tab_title(tab)

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    title = wezterm.truncate_right(title, max_width - 2)

    return {
      { Foreground = { Color = edge_background } },
      { Background = { Color = edge_foreground } },
      { Text = SOLID_RIGHT_ARROW },
      { Background = { Color = background } },
      { Foreground = { Color = foreground } },
      { Text = title },
      { Background = { Color = edge_background } },
      { Foreground = { Color = edge_foreground } },
      { Text = SOLID_RIGHT_ARROW },
    }
  end
)

return {
  apply = function(config)
    config.colors = {
      tab_bar = {
        background = '#bcbcbc',
      }
    }
  end,
}
