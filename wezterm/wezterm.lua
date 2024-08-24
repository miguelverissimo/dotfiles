local wezterm = require 'wezterm';

return {
  term = "xterm-256color",
  use_fancy_tab_bar = false,
  scrollback_lines = 10000,
  default_prog = { "/usr/bin/zsh", "-l" },
  --[[ color_scheme = "Dracula+", ]]
  color_scheme = "Catppuccin Frappe",
  font = wezterm.font("Hack Nerd Font", { weight = "Regular", italic = false }),
  font_rules = {
    { font = wezterm.font("Hack Nerd Font", { weight = "Regular", style = "Normal" }), intensity = "Normal" },
    { font = wezterm.font("Hack Nerd Font", { weight = "Regular", style = "Italic" }), intensity = "Normal", italic = true },
    { font = wezterm.font("Hack Nerd Font", { weight = "Bold", style = "Normal" }),    intensity = "Bold" },
    { font = wezterm.font("Hack Nerd Font", { weight = "Bold", style = "Italic" }),    intensity = "Bold",   italic = true },
  },
  font_size = 9,
  dpi = 96.0,
  default_cursor_style = "BlinkingBlock",
  keys = {
    { key = "t", mods = "SUPER", action = wezterm.action { SendString = "\x02c" } },
    { key = "s", mods = "SUPER", action = wezterm.action { SendString = "\x02/" } },
  },
  window_padding = {
    left = 3,
    -- This will become the scrollbar width if you have enabled the scrollbar!
    right = 2,
    top = 0,
    bottom = 0,
  },
  warn_about_missing_glyphs = false,
}
