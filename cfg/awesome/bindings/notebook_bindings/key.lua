local awful = require("awful")
local vol = require("lib.volume")
local brightness = require("lib.brightness")
local screenshot = require("lib.screenshot")
local user_likes = require("user_vars")

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
    key = "XF86AudioStop",
    description = "Playerctk Pause",
    group = "Notebook",
    on_press = function()
      awful.util.spawn("playerctl pause")
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

  -- Others
  awful.key({
    modifiers = {},
    key = "XF86Calculator",
    description = "Calculator",
    group = "Notebook",
    on_press = function()
      awful.util.spawn(user_likes.apps.terminal_emulator .. " qalc")
    end,
  }),
  awful.key({
    modifiers = {},
    key = "XF86AudioMicMute",
    description = "Audio Mic",
    group = "Notebook",
    on_press = function()
      awful.util.spawn("notify-send --app-name=firefox MicKey")
    end,
  }),
  awful.key({
    modifiers = {},
    key = "XF86RFKill",
    description = "Airplane",
    group = "Notebook",
    on_press = function()
      awful.util.spawn("notify-send --app-name=firefox AirplaneKey")
    end,
  }),
  awful.key({
    modifiers = {},
    key = "Print",
    description = "Screenshot",
    group = "Notebook",
    on_press = function()
      awful.util.spawn(screenshot.full())
    end,
  }),
})
