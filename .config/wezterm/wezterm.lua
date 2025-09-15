-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- Font configuration
config.font = wezterm.font_with_fallback({
  'JetBrainsMono Nerd Font',
  'ヒラギノ角ゴシック',
})

-- UI configuration
config.color_scheme = 'MaterialDarker'
config.default_cursor_style = 'BlinkingUnderline'
config.enable_tab_bar = true
config.window_padding = {
  left = 10,
  right = 10,
  top = 0,
  bottom = 10,
}

-- Key bindings configuration
config.keys = {
  -- Vertical split (panes arranged left and right)
  {
    key = ';',
    mods = 'CMD',
    action = wezterm.action.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
    },
  },
  -- Horizontal split (panes arranged top and bottom)
  {
    key = "'",
    mods = 'CMD',
    action = wezterm.action.SplitPane {
      direction = 'Down',
      size = { Percent = 50 },
    },
  },
  -- Close current pane
  {
    key = 'e',
    mods = 'CMD',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
}

config.window_decorations = "INTEGRATED_BUTTONS"

wezterm.on('update-right-status', function(window, pane)
  local compose = window:composition_status()
  if compose then
    compose = 'COMPOSING: ' .. compose
  end
  window:set_right_status(compose or '')
end)

return config
