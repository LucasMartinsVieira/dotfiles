local awful = require("awful")
local gears = require("gears")
local theme = require("theme.theme")
local wibox = require("wibox")
local helpers = require("helpers")
local dpi = require("beautiful").xresources.apply_dpi

local on = theme.blue
local off = theme.red

local wifi = wibox.widget({
  {
    {
      id = "wifi",
      widget = wibox.widget.textbox,
      font = theme.font .. " 30",
      markup = "直",
      halign = "center",
      align = "center",
    },
    widget = wibox.container.margin,
    margins = dpi(5),
  },
  fg = on,
  bg = theme.bg_normal,
  shape = helpers.rrect(5),
  widget = wibox.container.background,
})

local bluetooth = wibox.widget({
  {
    {
      id = "bluetooth",
      widget = wibox.widget.textbox,
      font = theme.font .. " 30",
      markup = "󰂯",
      halign = "center",
      align = "center",
    },
    widget = wibox.container.margin,
    margins = dpi(5),
  },
  fg = on,
  bg = theme.bg_normal,
  shape = helpers.rrect(5),
  widget = wibox.container.background,
})

local airplane = wibox.widget({
  {
    {
      id = "airplane",
      widget = wibox.widget.textbox,
      font = theme.font .. " 30",
      markup = "󰀝",
      halign = "center",
      align = "center",
    },
    widget = wibox.container.margin,
    margins = dpi(5),
  },
  fg = on,
  bg = theme.bg_normal,
  shape = helpers.rrect(5),
  widget = wibox.container.background,
})


-- wifi: 睊 直
-- bluetooth: 󰂲 󰂯
-- airplane: 󰀞 󰀝

-- Wifi
awesome.connect_signal("signal::wifi", function(net_stregth)
  if net_stregth == 0 then
    wifi.fg = off
    wifi:get_children_by_id("wifi")[1].markup = "睊"
  else
    wifi.fg = on
    wifi:get_children_by_id("wifi")[1].markup = "直"
  end

  wifi:buttons(gears.table.join(awful.button({}, 1, function()
    if net_stregth == 0 then
      wifi.fg = on
      wifi:get_children_by_id("wifi")[1].markup = "睊"
      awful.spawn.with_shell("nmcli radio wifi on")
    else
      wifi.fg = off
      wifi:get_children_by_id("wifi")[1].markup = "直"
      awful.spawn.with_shell("nmcli radio wifi off")
    end
  end)))
end)

return wibox.widget({
  {
    {
      wifi,
      bluetooth,
      airplane,
      spacing = dpi(12),
      layout = wibox.layout.flex.horizontal,
    },
    top = dpi(20),
    bottom = dpi(20),
    right = dpi(15),
    left = dpi(15),
    widget = wibox.container.margin,
  },
  shape = helpers.rrect(),
  widget = wibox.container.background,
  bg = theme.bg_alt,
})
