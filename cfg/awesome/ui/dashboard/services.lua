local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
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

local notify = wibox.widget({
  {
    {
      id = "notify",
      widget = wibox.widget.textbox,
      font = theme.font .. " 28",
      markup = "",
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

-- Hover Cursor
helpers.add_hover_cursor(wifi, "hand1")
helpers.add_hover_cursor(bluetooth, "hand1")
helpers.add_hover_cursor(notify, "hand1")

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

-- Bluetooth
awesome.connect_signal("signal::bluetooth", function(bluetooth_status)
  if bluetooth_status then
    bluetooth.fg = on
    bluetooth:get_children_by_id("bluetooth")[1].markup = "󰂯"
  else
    bluetooth.fg = off
    bluetooth:get_children_by_id("bluetooth")[1].markup = "󰂲"
  end

  bluetooth:buttons(gears.table.join(awful.button({}, 1, function()
    if bluetooth_status then
      bluetooth.fg = off
      bluetooth:get_children_by_id("bluetooth")[1].markup = "󰂲"
      awful.spawn.with_shell("bluetoothctl power off")
    else
      bluetooth.fg = on
      bluetooth:get_children_by_id("bluetooth")[1].markup = "󰂯"
      awful.spawn.with_shell("bluetoothctl power on")
    end
  end)))
end)

-- Notify
awesome.connect_signal("signal::dnd", function(dnd_status)
  if dnd_status then
    notify.fg = off
    notify:get_children_by_id("notify")[1].markup = ""
  else
    notify.fg = on
    notify:get_children_by_id("notify")[1].markup = ""
  end

  notify:buttons(gears.table.join(awful.button({}, 1, function()
    if dnd_status then
      notify.fg = off
      notify:get_children_by_id("notify")[1].markup = ""
      naughty.toggle()
    else
      notify.fg = on
      notify:get_children_by_id("notify")[1].markup = ""
      naughty.toggle()
    end
  end)))
end)

return wibox.widget({
  {
    {
      wifi,
      bluetooth,
      notify,
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
