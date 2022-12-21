local awful = require "awful"
local naughty = require "naughty"
local applications = require "config.applications"

local updates = {}

updates.num = function ()
  local script = [[
  checkupdates
  ]]

  local update = naughty.action {
    name = "Update"
  }

  update:connect_signal("invoked", function(n)
    awful.spawn(applications.default.terminal_emulator .. " -e paru -Syu --noconfirm", true)
  end)

  awful.spawn.easy_async_with_shell(script, function (out)
    naughty.notification {
      title = "Updates",
      message = string.format("%s", out),
      actions = {
        update,
      }
    }
  end)

end

return updates
