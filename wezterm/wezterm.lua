local wezterm = require 'wezterm';

return {
  term = "xterm-256color",
  use_fancy_tab_bar = false,
  scrollback_lines = 10000,
  default_prog = {"/usr/bin/zsh", "-l"},
  color_scheme = "Dracula+",
  font = wezterm.font("Hack Nerd Font", {weight="Regular", italic=false}),
  font_rules = {
        {
            italic = false,
            bold = false,
            font = wezterm.font("Hack Nerd Font", {weight="Regular", italic=false}),
        },
        {
            italic = true,
            bold = false,
            font = wezterm.font("Hack Nerd Font", {weight="Regular", italic=true}),
        },
        {
            italic = false,
            bold = true,
            font = wezterm.font("Hack Nerd Font", {weight="Bold", italic=false}),
        },
        {
            italic = true,
            bold = true,
            font = wezterm.font("Hack Nerd Font", {weight="Bold", italic=true}),
        },
    },
  font_size = 9.5,
  dpi = 96.0,
  font_antialias = "Greyscale",
  default_cursor_style = "BlinkingBlock",
  keys = {
     { key = "t", mods = "SUPER",  action=wezterm.action{SendString="\x02c"}},
     { key = "s", mods = "SUPER",  action=wezterm.action{SendString="\x02/"}},
  },
  window_padding = {
    left = 3,
    -- This will become the scrollbar width if you have enabled the scrollbar!
    right = 2,

    top = 0,
    bottom = 0,
  },
}
