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
username.markup = helpers.colorize_text(user:sub(1, 1):upper() .. user:sub(2), theme.blue )
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
  font = theme.font .. " Bold 8",
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox,
})

awful.widget.watch("uptime -p", 60, function(_, stdout)
  local output = stdout
  output = string.gsub(output, "^%s*(.-)%s*$", "%1")
  uptime.text = output
end)

-- Time
local clock = wibox.widget({
  format = "%H:%M",
  font = theme.font .. " Bold 30",
  widget = wibox.widget.textclock,
})

local button_size = dpi(18)

-- Layout
local layout = wibox.widget({
  forced_height = button_size,
  forced_width = button_size,
  widget = awful.widget.layoutbox,
  visible = true,
  buttons = {
    awful.button({}, 1, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 3, function()
      awful.layout.inc(-1)
    end),
    awful.button({}, 4, function()
      awful.layout.inc(1)
    end),
    awful.button({}, 5, function()
      awful.layout.inc(-1)
    end),
  },
})

-- Power
local power_icon = theme.power
local reboot_icon = theme.reboot

local power_command = function()
  awful.spawn.with_shell("systemctl poweroff")
end

local reboot_command = function()
  awful.spawn.with_shell("systemctl reboot")
end

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
      layout = wibox.layout.fixed.horizontal,
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

local power = create_button(power_icon, power_command)
local reboot = create_button(reboot_icon, reboot_command)

local name = wibox.widget({
  username,
  hostname,
  spacing = dpi(2),
  layout = wibox.layout.fixed.vertical,
})

local power_menu = wibox.widget({
  power,
  reboot,
  layout,
  spacing = dpi(2),
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
    clock,
    spacing = dpi(4),
    layout = wibox.layout.fixed.vertical,
  },
  {
    power_menu,
    spacing = dpi(4),
    layout = wibox.layout.fixed.vertical,
  },
  spacing = dpi(30),
  layout = wibox.layout.fixed.horizontal,
})
