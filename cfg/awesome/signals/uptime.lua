local awful = require("awful")
local gears = require("gears")

local script = [[
uptime --pretty | sed -e 's/up //g' -e 's/ days/d/g' -e 's/ day/d/g' -e 's/ hours/h/g' -e 's/ hour/h/g' -e 's/ minutes/m/g' -e 's/, / /g'
]]

local function get_uptime()
awful.spawn.easy_async_with_shell(script, function(uptime)
      --uptime = uptime:gsub("%s+", "")
      awesome.emit_signal('signal::uptime', uptime)
    end)
end

gears.timer({
  timeout = 60,
  call_now = true,
  autostart = true,
  callback = function()
    get_uptime()
  end,
})
