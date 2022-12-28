-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
require("awful.autofocus")

-- Widgets
local wifi = require("ui.bar.wifi")
local updates = require("ui.bar.updates")
local clock = require("ui.bar.clock")
local menu = require("ui.bar.menu")
local volume = require("ui.bar.volume")
local launcher = require("ui.bar.launcher")
local task = require("ui.bar.task")
local tag = require("ui.bar.tag")

--  Wibar
local function get_bar(s)
  -- Create the wibox
  s.mywibox = awful.wibar({
    position = "top",
    screen = s,
    visible = true,
    stretch = true,
    margins = {
      top = 3,
      bottom = 1,
      left = 6,
      right = 6,
    },
    shape = function(cr, width, height)
      gears.shape.rounded_rect(cr, width, height, 4)
    end,
  })

  -- Add widgets to the wibox
  s.mywibox:setup({
    layout = wibox.layout.align.horizontal,

    -- Left widgets
    {
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
      wibox.widget.textbox("  "),
      volume,
      wibox.widget.textbox("  "),
      updates,
      wibox.widget.textbox("  "),
      launcher,
      wibox.widget.textbox("  "),
      wibox.widget.systray(),
    },
  })
end

awful.screen.connect_for_each_screen(function(s)
    get_bar(s)
end)
