local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local theme = require("theme.theme")

local dpi = beautiful.xresources.apply_dpi

-- Var
local width = dpi(420)
local height = awful.screen.focused().geometry.height - dpi(50)

local function round_widget(radius)
  return function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, radius)
  end
end

local function box_widget(widgets, width, height)

  return wibox.widget({
    {
      {
        widgets,
        margins = dpi(16),
        widget = wibox.container.margin,
      },
      forced_width = dpi(width),
      forced_height = dpi(height),
      shape = round_widget(8),
      bg = theme.color_bg_alt,
      widget = wibox.container.background,
    },
    margins = { left = dpi(20), right = dpi(20) },
    widget = wibox.container.margin,
  })
end

-- Get Widgets
local profile_widget = require("ui.dashboard.profile")
local player_widget = require("ui.dashboard.player")
local stats_widget = require("ui.dashboard.stats")

-- Combine Widgets
local profile = box_widget(profile_widget, 380, 210)
local player = box_widget(player_widget, 380, 150)
local stats = box_widget(stats_widget, 380, 100)

-- Spacing
local space = function(height)
  return wibox.widget({
    forced_height = dpi(height),
    layout = wibox.layout.align.horizontal,
  })
end

-- Dashboard
local dashboard = wibox({
  visible = false,
  ontop = true,
  width = width,
  height = height,
  shape = gears.shape.rounded_rect,
  y = dpi(40),
  x = dpi(10),
  bg = theme.bg_normal,
})

-- Dashboard Setup
dashboard:setup({
  {
    profile,
    player,
    stats,
    spacing = dpi(20),
    layout = wibox.layout.fixed.vertical,
  },
  margins = { top = dpi(20), bottom = dpi(20) },
  widget = wibox.container.margin,
})


function dashboard_show()
  if dashboard.visible == false then
    dashboard.visible = true
    dashboard.timer:start()
  else
    dashboard.visible = false
  end
end

dashboard.timer = gears.timer {
  timeout = 10,
	single_shot = true,
  callback = function()
    dashboard.visible = false
  end
}
