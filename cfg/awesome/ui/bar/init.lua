-- Standard awesome library
local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")
require("awful.autofocus")

-- Widgets
local wifi = require("ui.bar.wifi")
local updates = require("ui.bar.updates")
local clock = require("ui.bar.clock")
local menu = require("ui.bar.menu")
local volume = require("ui.bar.volume")
local launcher = require("ui.bar.launcher")
local power = require("ui.bar.power")
local task = require("ui.bar.task")
local tag = require("ui.bar.tag")
local tray = require("ui.bar.tray")
local battery = require("ui.bar.battery")
local notification = require("ui.bar.notification")

--  Wibar
local function get_bar(s)
  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "top",
    height = dpi(30),
    screen = s,
    visible = true,
    stretch = true,
    margins = {
      top = 5,
      bottom = 1,
      left = 6,
      right = 6,
    },
    shape = helpers.rrect(4)
  })

  -- Add widgets to the wibox
  s.mywibox:setup({
    layout = wibox.layout.align.horizontal,

    -- Left widgets
    {
      wibox.widget.textbox(" "),
      menu,
      wibox.widget.textbox(" "),
      tag(s),
      wibox.widget.textbox(" "),
      task(s),
      layout = wibox.layout.fixed.horizontal,
    },

    -- Middle Widgets
    {
      layout = wibox.layout.ratio.horizontal,
      wibox.container.place(clock),
    },

    -- Right widgets
    {
      layout = wibox.layout.fixed.horizontal,
      wifi,
      wibox.widget.textbox(" "),
      volume,
      -- wibox.widget.textbox(" "),
      updates,
      wibox.widget.textbox(" "),
      battery,
      wibox.widget.textbox("  "),
      notification,
      wibox.widget.textbox(" "),
      tray,
      wibox.widget.textbox(" "),
      launcher,
      -- wibox.widget.textbox(" "),
      power,
    },
  })
end

awful.screen.connect_for_each_screen(function(s)
    get_bar(s)
end)
