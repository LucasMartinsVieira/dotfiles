local awful = require("awful")
local naughty = require("naughty")
local user_likes = require("user_vars")
local vol = require("lib.volume")
local screenshot = require("lib.screenshot")
local updates = require("lib.updates")

local isDark = true
local mod = require("bindings.mod")

require("ui.power_popup")
require("ui.dashboard")
require("ui.notification_center")

awful.keyboard.append_global_keybindings({
  -- Applications
  awful.key({
    modifiers = { mod.super },
    key = "b",
    description = "Browser",
    group = "Applications",
    on_press = function()
      awful.util.spawn(user_likes.apps.browser)
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "p",
    description = "File Manager",
    group = "Applications",
    on_press = function()
      awful.util.spawn(user_likes.apps.file_manager)
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "Return",
    description = "Open a Terminal",
    group = "Applications",
    on_press = function()
      awful.spawn(user_likes.apps.terminal_emulator)
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "r",
    description = "Application Launcher",
    group = "Applications",
    on_press = function()
      awful.util.spawn(user_likes.apps.app_launcher)
      -- menubar.show()
    end,
  }),

  -- Scripts

  -- This will only work if you have the 'colorscheme' program in your $PATH and you need rofi installed
  awful.key({
    modifiers = { mod.super },
    key = "c",
    description = "Change Colorscheme",
    group = "Scripts",
    on_press = function()
      awful.util.spawn("colorscheme")
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.shift },
    key = "w",
    description = "Set a Wallpaper",
    group = "Scripts",
    on_press = function()
      awful.spawn.with_shell("wallpaper " .. tostring(user_likes.user.wallpapers_dir))
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.shift },
    key = "b",
    description = "Bookmarks",
    group = "Scripts",
    on_press = function()
      awful.util.spawn("bookmark")
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "e",
    description = "Rofi-Emoji",
    group = "Scripts",
    on_press = function()
      awful.util.spawn("rofi -show emoji")
    end,
  }),

  -- UI
  awful.key({
    modifiers = { mod.super, mod.ctrl },
    key = "d",
    description = "Open Dashboard",
    group = "Ui",
    on_press = function()
      dashboard_show()
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.ctrl },
    key = "n",
    description = "Notification Center",
    group = "Ui",
    on_press = function()
      notifs_toggle()
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.ctrl },
    key = "p",
    description = "Open Exit Screen",
    group = "Ui",
    on_press = function()
      power_popup_show()
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.ctrl },
    key = "w",
    description = "Set a Random Wallpaper",
    group = "Ui",
    on_press = function()
      local feh_cmd = "feh --no-fehbg --bg-scale --randomize --no-xinerama"
      awful.spawn.with_shell(feh_cmd .. " " .. tostring(user_likes.user.wallpapers_dir))
    end,
  }),

  -- On/Off
  awful.key({
    modifiers = { mod.super, mod.alt },
    key = "n",
    description = "Toggle notifications on/off",
    group = "Ui",
    on_press = function()
      naughty.toggle()
    end,
  }),

  -- Others
  awful.key({
    modifiers = { mod.super },
    key = "i",
    description = "Fullscreen Screenshot",
    group = "Others",
    on_press = function()
      awful.util.spawn(screenshot.full())
    end,
  }),
  awful.key({
    modifiers = { mod.super, mod.shift },
    key = "i",
    description = "Area Screenshot",
    group = "Others",
    on_press = function()
      awful.util.spawn(screenshot.area())
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "u",
    description = "Checkupdates",
    group = "Others",
    on_press = function()
      awful.util.spawn(updates.num())
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "=",
    description = "Volume +",
    group = "Others",
    on_press = function()
      awful.util.spawn(vol.increase())
      vol.notification()
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "-",
    description = "Volume -",
    group = "Others",
    on_press = function()
      awful.util.spawn(vol.decrease())
      vol.notification()
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "0",
    description = "Mute/Desmute",
    group = "Others",
    on_press = function()
      awful.util.spawn(vol.mute())
      vol.mute_notification()
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = ";",
    description = "Playerctl Play/Pause",
    group = "Others",
    on_press = function()
      awful.util.spawn("playerctl play-pause")
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = ".",
    description = "Playerctl Next",
    group = "Others",
    on_press = function()
      awful.util.spawn("playerctl next")
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = ",",
    description = "Playerctl Previous",
    group = "Others",
    on_press = function()
      awful.util.spawn("playerctl previous")
    end,
  }),
  awful.key({
    modifiers = { mod.super },
    key = "x",
    description = "Switch Color Temperature",
    group = "Others",
    on_press = function()
      isDark = not isDark
      if isDark then
        awful.spawn("redshift -P -O 4500")
      else
        awful.spawn("redshift -P -O 5200")
      end
    end,
  }),
})
