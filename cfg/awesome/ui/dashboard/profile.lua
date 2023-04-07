local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local theme = require("theme.theme")
local helpers = require("helpers")
local dpi = beautiful.xresources.apply_dpi

-- Profile Pic
local pfp = wibox.widget.imagebox()
pfp.image = theme.pfp
pfp.clip_shape = helpers.rrect()
pfp.forced_width = dpi(130)
pfp.forced_height = dpi(130)

-- User
local user = os.getenv("USER")
local username = wibox.widget.textbox()
username.markup =
  helpers.colorize_text(user:sub(1, 1):upper() .. user:sub(2), theme.blue)
username.font = theme.font .. " Bold 16"
username.align = "left"

-- Hostname
local hostname = wibox.widget.textbox()
hostname.font = theme.font .. " Bold 14"
hostname.align = "left"

awful.spawn.easy_async_with_shell("cat /etc/hostname", function(stdout)
  hostname.markup = helpers.colorize_text("@" .. stdout, theme.yellow)
end)

-- Uptime
local uptime = wibox.widget({
  text = "up 0 minutes",
  font = theme.font .. " Bold 10",
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox,
})

awesome.connect_signal("signal::uptime", function(upt)
  uptime.text = upt
end)

-- Time
local clock = wibox.widget({
  format = "%H:%M",
  font = theme.font .. " Bold 16",
  widget = wibox.widget.textclock,
  halign = "right",
  valign = "top",
})

local name = wibox.widget({
  {
    username,
    hostname,
    spacing = dpi(2),
    layout = wibox.layout.fixed.vertical,
  },
  clock,
  spacing = dpi(60),
  layout = wibox.layout.fixed.horizontal,
})

-- Buttons
local button_size = dpi(36)

-- Powermenu Icons
local power_icon = theme.power
local reboot_icon = theme.reboot
local logout_icon = theme.logout
local suspend_icon = theme.suspend

-- Commands
local power_command = function()
  awful.spawn.with_shell("systemctl poweroff")
end
local reboot_command = function()
  awful.spawn.with_shell("systemctl reboot")
end
local logout_command = function()
  awesome.quit()
end
local suspend_command = function()
  awful.spawn.with_shell("systemctl suspend")
end

-- Create button function
local create_button = function(symbol, command)
  local icon = wibox.widget({
    forced_height = button_size,
    forced_width = button_size,
    align = "center",
    valign = "center",
    resize = true,
    clip_shape = helpers.rrect(),
    image = symbol,
    widget = wibox.widget.imagebox(),
  })
  local button = wibox.widget({
    {
      nil,
      icon,
      expand = "none",
      layout = wibox.layout.align.horizontal,
    },
    forced_height = button_size,
    forced_width = button_size,
    clip_shape = helpers.rrect(),
    widget = wibox.container.background,
  })

  button:buttons(gears.table.join(awful.button({}, 1, function()
    command()
  end)))

  button:connect_signal("mouse::enter", function()
    button.bg = theme.bg_focus
  end)

  button:connect_signal("mouse::leave", function()
    button.bg = nil
  end)
  return button
end

-- Create the Buttons
local power = create_button(power_icon, power_command)
local reboot = create_button(reboot_icon, reboot_command)
local logout = create_button(logout_icon, logout_command)
local suspend = create_button(suspend_icon, suspend_command)

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

local power_buttons = wibox.widget({
  power,
  reboot,
  logout,
  suspend,
  spacing = dpi(16),
  layout = wibox.layout.fixed.horizontal,
})

return wibox.widget({
  {
    {
      pfp,
      uptime,
      spacing = dpi(20),
      layout = wibox.layout.fixed.vertical,
    },
    layout = wibox.layout.fixed.vertical,
  },
  {
    name,
    power_buttons,
    spacing = dpi(4),
    layout = wibox.layout.fixed.vertical,
  },
  spacing = dpi(30),
  layout = wibox.layout.fixed.horizontal,
})
