local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.font = wezterm.font('JetBrains Mono')
config.font_size = 11;
config.color_scheme = 'Tokyo Night'

config.window_background_opacity = 0.85 

config.enable_tab_bar = false

return config
