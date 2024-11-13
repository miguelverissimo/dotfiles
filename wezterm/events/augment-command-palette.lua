---@diagnostic disable: undefined-field

local wt = require "wezterm"
local act = wt.action

wt.on("augment-command-palette", function(_, _)
  return {
    {
      brief = "Rename tab",
      icon = "md_rename_box",

      action = act.PromptInputLine {
        description = "Enter new name for tab",
        action = wt.action_callback(function(inner_window, _, line)
          if line then
            inner_window:active_tab():set_title(line)
          end
        end),
      },
    },
    {
      brief = "tmux Search Up",
      icon = "md_upload_multiple",
      action = act.Multiple {
        act.SendKey { key = 'a', mods = 'CTRL' },
        act.SendKey { key = '[' },
        act.SendKey { key = '?' },
      },
    },
    {
      brief = "tmux Search Down",
      icon = "md_download_multiple",
      action = act.Multiple {
        act.SendKey { key = 'a', mods = 'CTRL' },
        act.SendKey { key = '[' },
        act.SendKey { key = '/' },
      },
    },
  }
end)
