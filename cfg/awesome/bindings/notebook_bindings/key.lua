local awful = require("awful")
local vol = require("lib.volume")
local brightness = require("lib.brightness")

local mod = require("bindings.mod")

awful.keyboard.append_global_keybindings({

  -- Volume
  awful.key({
    modifiers = {},
    key = "XF86AudioRaiseVolume",
    description = "Volume +",
    group = "Notebook",
    on_press = function()
      awful.util.spawn(vol.increase())
      vol.notification()
    end,
  }),
  awful.key({
    modifiers = {},
    key = "XF86AudioLowerVolume",
    description = "Volume -",
    group = "Notebook",
    on_press = function()
      awful.util.spawn(vol.decrease())
      vol.notification()
    end,
  }),
  awful.key({
    modifiers = {},
    key = "XF86AudioMute",
    description = "Mute/Desmute",
    group = "Notebook",
    on_press = function()
      awful.util.spawn(vol.mute())
      vol.mute_notification()
    end,
  }),

  -- Music
  awful.key({
    modifiers = {},
    key = "XF86AudioPlay",
    description = "Playerctk Play/Pause",
    group = "Notebook",
    on_press = function()
      awful.util.spawn("playerctl play-pause")
    end,
  }),
  awful.key({
    modifiers = {},
    key = "XF86AudioNext",
    description = "Playerctk Next",
    group = "Notebook",
    on_press = function()
      awful.util.spawn("playerctl next")
    end,
  }),
  awful.key({
    modifiers = {},
    key = "XF86AudioPrev",
    description = "Playerctk Previous",
    group = "Notebook",
    on_press = function()
      awful.util.spawn("playerctl previous")
    end,
  }),

  -- Brightness
  awful.key({
    modifiers = {},
    key = "XF86MonBrightnessUp",
    description = "Brightnessctl +",
    group = "Notebook",
    on_press = function()
      awful.util.spawn(brightness.increase())
      brightness.notification()
    end,
  }),
  awful.key({
    modifiers = {},
    key = "XF86MonBrightnessDown",
    description = "Brightnessctl -",
    group = "Notebook",
    on_press = function()
      awful.util.spawn(brightness.decrease())
      brightness.notification()
    end,
  }),
})
