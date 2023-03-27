-- This is based of: https://github.com/mariod8/policromia
local awful = require("awful")
local wibox = require("wibox")
local theme = require("theme.theme")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local helpers = require("helpers")
local gears = require("gears")

local height = dpi(250)
local width = dpi(50)

local progressbar = wibox.widget {
  max_value = 100,
  forced_height = width,
  forced_width = height,
  value = 25,
  shape = helpers.rrect(),
  color = theme.green,
  background_color = theme.bg_normal,
  widget = wibox.widget.progressbar,
}

local icon = wibox.widget {
  font   = theme.font .. " 22",
  align  = 'center',
  valign = 'bottom',
  widget = wibox.widget.textbox
}

local pop = wibox({
  type    = "popup",
  height  = height,
  width   = width,
  shape   = helpers.rrect(),
  halign  = "center",
  valign  = "center",
  ontop   = true,
  visible = false,
})

awful.placement.right(pop, { margins = { right = dpi(10) * 4 } })

pop:setup({
  {
    progressbar,
    widget = wibox.container.rotate,
    direction = "east"
  },
  {
    icon,
    margins = { bottom = dpi(12) },
    widget = wibox.container.margin
  },
  layout = wibox.layout.stack
})

local volume_center_timer = gears.timer {
  timeout = 6,
  callback = function()
    pop.visible = false
  end
}

function volume_center_show()
  if pop.visible then
    volume_center_timer:again()
  else
    pop.visible = true
    volume_center_timer:start()
  end
end

pop:buttons(gears.table.join(
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

awesome.connect_signal('signal::volume', function(vol, mute)
  vol = tonumber(vol)
  if mute or vol == 0 then
    progressbar.color = theme.red
    icon.markup = helpers.colorize_text("婢", theme.bg_alt)
  else
    progressbar.color = theme.green
    icon.markup = helpers.colorize_text("墳", theme.bg_alt)
  end
  progressbar.value = vol
end)
