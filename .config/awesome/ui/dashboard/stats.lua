local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local applications = require("config.applications")
local theme = require("theme.theme")
local dpi = require("beautiful").xresources.apply_dpi

-- Disk
local disk_icon = wibox.widget({
  font = theme.font .. " 26",
  align = "left",
  markup = "<span foreground='" .. theme.red .. "'></span>",
  widget = wibox.widget.textbox(),
})

local disk_info = wibox.widget({
  font = theme.font .. " 12",
  align = "left",
  widget = wibox.widget.textbox(),
})

-- Volume
local volume_icon = wibox.widget({
  font = theme.font .. " 26",
  align = "left",
  markup = "<span foreground='" .. theme.blue .. "'>墳</span>",
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
  markup = "<span foreground='" .. theme.yellow .. "'></span>",
  widget = wibox.widget.textbox(),
})

local updates_info = wibox.widget({
  font = theme.font .. " 12",
  align = "left",
  widget = wibox.widget.textbox(),
})

-- Wifi
local wifi_icon = wibox.widget({
  font = theme.font .. " 26",
  align = "left",
  markup = "<span foreground='" .. theme.green .. "'>直</span>",
  widget = wibox.widget.textbox(),
})

local wifi_info = wibox.widget({
  font = theme.font .. " 12",
  align = "left",
  widget = wibox.widget.textbox(),
})

-- Get info values
local function get_val()
  awesome.connect_signal("signal::volume", function(vol, muted)
    if muted then
      volume_icon.markup = "<span foreground='" .. theme.red .. "'>墳</span>"
      volume_info.markup = "<span foreground='" .. theme.red .. "'>0%</span>"
    else
      volume_icon.markup = "<span foreground='" .. theme.blue .. "'>墳</span>"
      volume_info.markup = "<span foreground='" .. theme.blue .. "'>" .. tonumber(vol) .. "%" .. "</span>"
    end
  end)

  awesome.connect_signal("signal::disk", function(disk_perc)
    disk_info.markup = "<span foreground='" .. theme.red .. "'>" .. tonumber(disk_perc) .. "%" .. "</span>"
  end)

  awesome.connect_signal("signal::updates", function(upd)
    upd = tonumber(upd)

    if upd == 0 then
      updates_icon.markup = "<span foreground='" .. theme.yellow .. "'></span>"
    else
      updates_icon.markup = "<span foreground='" .. theme.yellow .. "'></span>"
    end
    updates_info.markup = "<span foreground='" .. theme.yellow .. "'>" .. upd .. "</span>"
  end)
end

local function get_wifi()
  awesome.connect_signal("signal::wifi", function(net_status, net_stregth)
    local net_stregth = tonumber(net_stregth)
    if net_status == false then
      wifi_icon.markup = "<span foreground='" .. theme.red .. "'>睊</span>"
      wifi_info.markup = ""
    else
      wifi_icon.markup = "<span foreground='" .. theme.green .. "'>直</span>"
      wifi_info.markup = "<span foreground='" .. theme.green .. "'>" .. net_stregth .. "%" .. "</span>"
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

-- Buttons
volume:buttons(gears.table.join(
  awful.button({}, 1, function()
    require("lib.volume").mute()
    require("ui.bar.volume").get_vol()
  end),
  awful.button({}, 3, function()
    awful.spawn("pavucontrol")
  end),
  awful.button({}, 4, function()
    require("lib.volume").increase()
    require("ui.bar.volume").get_vol()
  end),
  awful.button({}, 5, function()
    require("lib.volume").decrease()
    require("ui.bar.volume").get_vol()
  end)
))

updates:buttons(gears.table.join(
  awful.button({}, 1, function()
    awful.spawn(applications.default.terminal_emulator .. " -e paru -Syu --noconfirm")
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
  disk,
  volume,
  updates,
  spacing = dpi(18),
  layout = wibox.layout.fixed.horizontal,
}))
