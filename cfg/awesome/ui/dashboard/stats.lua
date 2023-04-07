local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local user_likes = require("user_vars")
local theme = require("theme.theme")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")

-- Disk
local disk_icon = wibox.widget({
  font = theme.font .. " 22",
  align = "left",
  markup = helpers.colorize_text("", theme.red),
  widget = wibox.widget.textbox(),
})

local disk_info = wibox.widget({
  font = theme.font .. " 12",
  align = "left",
  widget = wibox.widget.textbox(),
})

-- Volume
local volume_icon = wibox.widget({
  font = theme.font .. " 22",
  align = "left",
  markup = helpers.colorize_text("墳", theme.blue),
  widget = wibox.widget.textbox(),
})

local volume_info = wibox.widget({
  font = theme.font .. " 12",
  align = "left",
  widget = wibox.widget.textbox(),
})

-- Updates
local updates_icon = wibox.widget({
  font = theme.font .. " 26",
  align = "left",
  markup = helpers.colorize_text("", theme.yellow),
  widget = wibox.widget.textbox(),
})

local updates_info = wibox.widget({
  font = theme.font .. " 12",
  align = "left",
  widget = wibox.widget.textbox(),
})

-- Wifi
local wifi_icon = wibox.widget({
  font = theme.font .. " 22",
  align = "left",
  markup = helpers.colorize_text("直", theme.green),
  widget = wibox.widget.textbox(),
})

local wifi_info = wibox.widget({
  font = theme.font .. " 12",
  align = "left",
  widget = wibox.widget.textbox(),
})

-- Battery
local battery_icon = wibox.widget({
  font = theme.font .. " 22",
  align = "left",
  markup = helpers.colorize_text("󰁹", theme.green),
  widget = wibox.widget.textbox(),
})

local battery_info = wibox.widget({
  font = theme.font .. " 12",
  align = "left",
  widget = wibox.widget.textbox(),
})

-- Get info values
local function get_val()
  awesome.connect_signal("signal::volume", function(vol, muted)
    if muted then
      volume_icon.markup = helpers.colorize_text("婢", theme.red)
      volume_info.markup = helpers.colorize_text("0%", theme.red)
    else
      volume_icon.markup = helpers.colorize_text("墳", theme.blue)
      volume_info.markup = helpers.colorize_text(tonumber(vol) .. "%", theme.blue)
    end
  end)

  awesome.connect_signal("signal::disk", function(disk_perc)
    disk_info.markup = helpers.colorize_text(tonumber(disk_perc) .. "%", theme.red)
  end)

  awesome.connect_signal("signal::updates", function(upd)
    upd = tonumber(upd)

    if upd == 0 then
      updates_icon.markup = helpers.colorize_text("", theme.yellow)
    else
      updates_icon.markup = helpers.colorize_text("", theme.yellow)
    end
     updates_info.markup = helpers.colorize_text(upd, theme.yellow)
  end)
end

awesome.connect_signal("signal::battery", function(bat_level)
  bat_level = tonumber(bat_level)

  if bat_level <= 10 then
    battery_icon.markup = helpers.colorize_text("󰁺", theme.red)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.red)
  elseif bat_level <= 20 then
    battery_icon.markup = helpers.colorize_text("󰁻", theme.red)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.red)
  elseif bat_level <= 30 then
    battery_icon.markup = helpers.colorize_text("󰁼", theme.red)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.red)
  elseif bat_level <= 40 then
    battery_icon.markup = helpers.colorize_text("󰁽", theme.green)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.green)
  elseif bat_level <= 50 then
    battery_icon.markup = helpers.colorize_text("󰁾", theme.green)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.green)
  elseif bat_level <= 60 then
    battery_icon.markup = helpers.colorize_text("󰁿", theme.green)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.green)
  elseif bat_level <= 70 then
    battery_icon.markup = helpers.colorize_text("󰂀", theme.green)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.green)
  elseif bat_level <= 80 then
    battery_icon.markup = helpers.colorize_text("󰂁", theme.green)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.green)
  elseif bat_level <= 90 then
    battery_icon.markup = helpers.colorize_text("󰂂", theme.green)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.green)
  else
    battery_icon.markup = helpers.colorize_text("󰁹", theme.green)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.green)
  end
end)

local function get_wifi()
  awesome.connect_signal("signal::wifi", function(net_status, net_stregth)
    local net_stregth = tonumber(net_stregth)
    if net_status == false then
      wifi_icon.markup = helpers.colorize_text("睊", theme.red)
      wifi_info.markup = ""
    else
      wifi_icon.markup = helpers.colorize_text("直", theme.green)
      wifi_info.markup = helpers.colorize_text(net_stregth .. "%", theme.green)
    end
  end)
end

gears.timer({
  timeout = 5,
  autostart = true,
  call_now = true,
  callback = function()
    get_wifi()
  end,
})

get_val()

-- Grouping info and icon
local function grouping_widgets(icon, info)
  return wibox.widget({
    icon,
    info,
    spacing = dpi(8),
    layout = wibox.layout.fixed.horizontal,
  })
end

local wifi = grouping_widgets(wifi_icon, wifi_info)
local disk = grouping_widgets(disk_icon, disk_info)
local volume = grouping_widgets(volume_icon, volume_info)
local updates = grouping_widgets(updates_icon, updates_info)
local battery = grouping_widgets(battery_icon, battery_info)

-- Buttons
volume:buttons(gears.table.join(
  awful.button({}, 1, function()
    require("lib.volume").mute()
  end),
  awful.button({}, 3, function()
    awful.spawn("pavucontrol")
  end),
  awful.button({}, 4, function()
    require("lib.volume").increase()
  end),
  awful.button({}, 5, function()
    require("lib.volume").decrease()
  end)
))

updates:buttons(gears.table.join(
  awful.button({}, 1, function()
    awful.spawn(user_likes.apps.terminal_emulator .. " -e paru -Syu --noconfirm")
  end),
  awful.button({}, 3, function()
    require("lib.updates").num()
  end)
))

-- Hover
wifi:connect_signal("mouse::enter", function()
  wifi_icon.font = theme.font .. " 24"
  wifi_info.font = theme.font .. " 14"
end)
wifi:connect_signal("mouse::leave", function()
  wifi_icon.font = theme.font .. " 22"
  wifi_info.font = theme.font .. " 12"
end)

disk:connect_signal("mouse::enter", function()
  disk_icon.font = theme.font .. " 24"
  disk_info.font = theme.font .. " 14"
end)
disk:connect_signal("mouse::leave", function()
  disk_icon.font = theme.font .. " 22"
  disk_info.font = theme.font .. " 12"
end)

volume:connect_signal("mouse::enter", function()
  volume_icon.font = theme.font .. " 24"
  volume_info.font = theme.font .. " 14"
end)
volume:connect_signal("mouse::leave", function()
  volume_icon.font = theme.font .. " 22"
  volume_info.font = theme.font .. " 12"
end)

updates:connect_signal("mouse::enter", function()
  updates_icon.font = theme.font .. " 28"
  updates_info.font = theme.font .. " 14"
end)
updates:connect_signal("mouse::leave", function()
  updates_icon.font = theme.font .. " 26"
  updates_info.font = theme.font .. " 12"
end)

battery:connect_signal("mouse::enter", function()
  battery_icon.font = theme.font .. " 24"
  battery_info.font = theme.font .. " 14"
end)
battery:connect_signal("mouse::leave", function()
  battery_icon.font = theme.font .. " 22"
  battery_info.font = theme.font .. " 12"
end)

-- function to centralize widgets
local function center_widget(widget)
  return wibox.widget({
    nil,
    {
      nil,
      widget,
      expand = "none",
      layout = wibox.layout.align.horizontal,
    },
    expand = "none",
    layout = wibox.layout.align.vertical,
  })
end

return center_widget(wibox.widget({
  wifi,
  battery,
  disk,
  volume,
  updates,
  spacing = dpi(12),
  layout = wibox.layout.fixed.horizontal,
}))
