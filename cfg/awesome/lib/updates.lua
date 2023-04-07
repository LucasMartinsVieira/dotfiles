local awful = require("awful")
local naughty = require("naughty")
local user_likes = require("user_vars")
local theme = require("theme.theme")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local updates = {}

updates.num = function()
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
    awful.spawn(user_likes.apps.terminal_emulator .. " -e paru -Syu --noconfirm", true)
  end)

  awful.spawn.easy_async_with_shell(script, function(out)
    awful.spawn.easy_async_with_shell(script2, function(out1)
      naughty.notification {
        app_name = "Updates Tool",
        title = string.format("Updates: %s", out1),
        message = string.format("%s", out),
        icon = theme.updates,
        ontop = true,
        icon_size = dpi(20),
        actions = { update },
      }
    end)
  end)
end

return updates
