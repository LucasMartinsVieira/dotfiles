local awful = require("awful")
local naughty = require("naughty")
local applications = require("config.applications")
local icons_dir = require("gears").filesystem.get_configuration_dir() .. "/theme/assets/"
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local updates = {}

updates.num = function ()
  local script = [[
  checkupdates
  ]]

  local script2 = [[
  checkupdates | wc -l
  ]]

  local update = naughty.action {
    name = "Update"
  }

  update:connect_signal("invoked", function(n)
    awful.spawn(applications.default.terminal_emulator .. " -e paru -Syu --noconfirm", true)
  end)

  awful.spawn.easy_async_with_shell(script, function (out)
    awful.spawn.easy_async_with_shell(script2, function (out1)
    naughty.notification {
      title = string.format("Updates: %s", out1),
      message = string.format("%s", out),
      icon = icons_dir .. "updates.png",
      icon_size = dpi(25),
      actions = { update }
    }
  end)
  end)

end

return updates
