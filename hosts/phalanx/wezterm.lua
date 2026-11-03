local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.initial_cols = 160;
config.initial_rows = 40;

config.font = wezterm.font('JetBrains Mono')
config.font_size = 10;
config.color_scheme = 'Tokyo Night'

config.window_background_opacity = 0.85 

config.enable_tab_bar = false

return config
