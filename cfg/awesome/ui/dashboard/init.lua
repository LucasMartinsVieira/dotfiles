local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local theme = require("theme.theme")
local helpers = require("helpers")

local dpi = beautiful.xresources.apply_dpi

-- Var
local width = dpi(420)
local height = awful.screen.focused().geometry.height - dpi(120)
--local height = awful.screen.focused().geometry.height - dpi(50)

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
      shape = helpers.rrect(8),
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
-- local weather_widget = require("ui.dashboard.weather")
local services_widget = require("ui.dashboard.services")

-- Combine Widgets
local profile = box_widget(profile_widget, 380, 200)
local player = box_widget(player_widget, 380, 170)
local stats = box_widget(stats_widget, 380, 100)
-- local weather = box_widget(weather_widget, 380, 225)
local services = box_widget(services_widget, 380, 130)

-- Dashboard
dashboard = wibox({
  visible = false,
  ontop = true,
  width = width,
  height = height,
  shape = helpers.rrect(),
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
    -- weather,
    -- powerbar,
    services,
    spacing = dpi(25),
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

dashboard.timer = gears.timer({
  timeout = 16,
  single_shot = true,
  callback = function()
    dashboard.visible = false
  end,
})
