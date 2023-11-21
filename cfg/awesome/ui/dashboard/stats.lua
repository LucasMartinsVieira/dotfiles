local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local user_likes = require("user_vars")
local theme = require("theme.theme")
local dpi = require("beautiful").xresources.apply_dpi
local helpers = require("helpers")
local icons = require("utils.icons")

-- Disk
local disk_icon = wibox.widget({
  font = theme.font .. " 18",
  align = "left",
  markup = helpers.colorize_text(icons.disk, theme.red),
  widget = wibox.widget.textbox(),
})

local disk_info = wibox.widget({
  font = theme.font .. " 12",
  align = "left",
  widget = wibox.widget.textbox(),
})

-- Volume
local volume_icon = wibox.widget({
  font = theme.font .. " 18",
  align = "left",
  markup = helpers.colorize_text(icons.volume.high, theme.blue),
  widget = wibox.widget.textbox(),
})

local volume_info = wibox.widget({
  font = theme.font .. " 12",
  align = "left",
  widget = wibox.widget.textbox(),
})

-- Updates
local updates_icon = wibox.widget({
  font = theme.font .. " 16",
  align = "left",
  markup = helpers.colorize_text(icons.updates_on, theme.yellow),
  widget = wibox.widget.textbox(),
})

local updates_info = wibox.widget({
  font = theme.font .. " 12",
  align = "left",
  widget = wibox.widget.textbox(),
})

-- Wifi
local wifi_icon = wibox.widget({
  font = theme.font .. " 18",
  align = "left",
  markup = helpers.colorize_text(icons.wifi_on, theme.green),
  widget = wibox.widget.textbox(),
})

local wifi_info = wibox.widget({
  font = theme.font .. " 12",
  align = "left",
  widget = wibox.widget.textbox(),
})

-- Battery
local battery_icon = wibox.widget({
  font = theme.font .. " 16",
  align = "left",
  markup = helpers.colorize_text(icons.battery.hundred, theme.green),
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
      volume_icon.markup = helpers.colorize_text(icons.volume.mute, theme.red)
      volume_info.markup = helpers.colorize_text("0%", theme.red)
    else
      volume_icon.markup = helpers.colorize_text(icons.volume.high, theme.blue)
      volume_info.markup =
        helpers.colorize_text(tonumber(vol) .. "%", theme.blue)
    end
  end)

  awesome.connect_signal("signal::disk", function(disk_perc)
    disk_info.markup =
      helpers.colorize_text(string.format("%s", disk_perc), theme.red)
  end)

  awesome.connect_signal("signal::updates", function(upd)
    upd = tonumber(upd)

    if upd == 0 then
      updates_icon.markup =
        helpers.colorize_text(icons.updates_off, theme.yellow)
    else
      updates_icon.markup =
        helpers.colorize_text(icons.updates_on, theme.yellow)
    end
    updates_info.markup = helpers.colorize_text(upd, theme.yellow)
  end)
end

awesome.connect_signal("signal::battery", function(bat_level)
  bat_level = tonumber(bat_level)

  if bat_level <= 10 then
    battery_icon.markup =
      helpers.colorize_text(icons.battery.ten .. " ", theme.red)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.red)
  elseif bat_level <= 20 then
    battery_icon.markup =
      helpers.colorize_text(icons.battery.twenty .. " ", theme.red)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.red)
  elseif bat_level <= 30 then
    battery_icon.markup =
      helpers.colorize_text(icons.battery.thirty .. " ", theme.red)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.red)
  elseif bat_level <= 40 then
    battery_icon.markup =
      helpers.colorize_text(icons.battery.forty .. " ", theme.green)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.green)
  elseif bat_level <= 50 then
    battery_icon.markup =
      helpers.colorize_text(icons.battery.fifty .. " ", theme.green)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.green)
  elseif bat_level <= 60 then
    battery_icon.markup =
      helpers.colorize_text(icons.battery.sixty .. " ", theme.green)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.green)
  elseif bat_level <= 70 then
    battery_icon.markup =
      helpers.colorize_text(icons.battery.seventy .. " ", theme.green)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.green)
  elseif bat_level <= 80 then
    battery_icon.markup =
      helpers.colorize_text(icons.battery.eighty .. " ", theme.green)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.green)
  elseif bat_level <= 90 then
    battery_icon.markup =
      helpers.colorize_text(icons.battery.ninety .. " ", theme.green)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.green)
  else
    battery_icon.markup =
      helpers.colorize_text(icons.battery.hundred .. " ", theme.green)
    battery_info.markup = helpers.colorize_text(bat_level .. "%", theme.green)
  end
end)

local function get_wifi()
  awesome.connect_signal("signal::wifi", function(net_stregth)
    local net_stregth = tonumber(net_stregth)

    if net_stregth == 0 then
      wifi_icon.markup = helpers.colorize_text(icons.wifi_off, theme.red)
      wifi_info.markup = ""
    else
      wifi_icon.markup = helpers.colorize_text(icons.wifi_on, theme.green)
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
    spacing = dpi(-2),
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
    awful.spawn(
      user_likes.apps.terminal_emulator .. " -e paru -Syu --noconfirm"
    )
  end),
  awful.button({}, 3, function()
    require("lib.updates").num()
  end)
))

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
