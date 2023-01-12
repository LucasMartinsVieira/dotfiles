local awful = require("awful")
local theme = require("theme.theme")
local wibox = require("wibox")
local gears = require("gears")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Buttons
local button_bg = theme.bg_focus
local button_size = dpi(42)

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
    clip_shape = gears.shape.rounded_rect,
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
    clip_shape = gears.shape.rounded_rect,
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

-- Profile pic
local pic = wibox.widget({
  nil,
  {
    {
      image = theme.pfp,
      resize = true,
      clip_shape = gears.shape.circle,
      widget = wibox.widget.imagebox,
    },
    border_width = dpi(3),
    border_color = theme.blue,
    bg = theme.blue,
    forced_height = dpi(120),
    forced_width = dpi(120),
    shape = gears.shape.circle,
    widget = wibox.container.background,
  },
  nil,
  expand = "none",
  layout = wibox.layout.align.horizontal,
})

-- Get username
local user = os.getenv("USER")

local username = wibox.widget.textbox(user:sub(1, 1):upper() .. user:sub(2))
username.font = theme.font .. " 18"
username.align = "center"
username.valign = "center"

-- Uptime
local uptime = wibox.widget({
  text = "up 0 minutes",
  font = theme.font .. " 12",
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox,
})

awful.widget.watch("uptime -p", 60, function(_, stdout)
  -- Remove trailing whitespaces
  local out = stdout:gsub("^%s*(.-)%s*$", "%1") --:gsub(", ", ",\n")
  uptime.text = out
end)

p = wibox({
  visible = false,
  ontop = true,
  bg = theme.bg_normal,
  fg = theme.blue,
  height = dpi(300),
  width = dpi(400),
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 12)
  end,
})

awful.placement.centered(p)

p:buttons(gears.table.join(
  awful.button({}, 1, function()
    p.visible = false
  end),
  awful.button({}, 2, function()
    p.visible = false
  end),
  awful.button({}, 3, function()
    p.visible = false
  end)
))


-- Item placement
p:setup({
  nil,
  {
    nil,
    {
      {
        pic,
        username,
        uptime,
        spacing = dpi(10),
        layout = wibox.layout.fixed.vertical,
      },
      {
        power,
        reboot,
        logout,
        suspend,
        spacing = dpi(40),
        layout = wibox.layout.fixed.horizontal,
      },
      spacing = dpi(30),
      layout = wibox.layout.fixed.vertical,
    },
    expand = "none",
    layout = wibox.layout.align.horizontal,
  },
  expand = "none",
  layout = wibox.layout.align.vertical,
})

function power_popup_show()
  if p.visible == false then
    p.visible = true
    popup_timer:start()
  else
    p.visible = false
  end
end

popup_timer = gears.timer {
  timeout = 3.5,
	single_shot = true,
  callback = function()
    p.visible = false
  end
}
