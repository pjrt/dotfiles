-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
local act = wezterm.action

-- This is where you actually apply your config choices.
config.color_scheme = 'Solarized (dark) (terminal.sexy)'

-- Spawn a fish shell in login mode
config.default_prog = { '/opt/homebrew/bin/fish', '-l' }

config.keys = {
  -- Set alt-u to activecopymode
  { key = 'u', mods = 'ALT', action = wezterm.action.ActivateCopyMode },
  -- Set splits
  { key = 'h', mods = 'ALT|CTRL', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = 'ALT|CTRL', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  -- Move to next/prev panel with cmd-j/k
  { key = 'j', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Next' },
  { key = 'k', mods = 'CMD', action = wezterm.action.ActivatePaneDirection 'Prev' },
  {
    key = 'H',
    mods = 'CTRL|SHIFT',
    action = act.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'J',
    mods = 'CTRL|SHIFT',
    action = act.AdjustPaneSize { 'Down', 5 },
  },
  { key = 'K', mods = 'CTRL|SHIFT', action = act.AdjustPaneSize { 'Up', 5 } },
  {
    key = 'L',
    mods = 'CTRL|SHIFT',
    action = act.AdjustPaneSize { 'Right', 5 },
  },
  {
    key = 'k',
    mods = 'SHIFT|CMD',
    action = act.RotatePanes 'CounterClockwise',
  },
  { key = 'j', mods = 'SHIFT|CMD', action = act.RotatePanes 'Clockwise' },
}

-- Finally, return the configuration to wezterm:
return config
