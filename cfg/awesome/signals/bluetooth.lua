local awful = require("awful")
local gears = require("gears")

local bluetooth_state = [[
bluetoothctl show | grep Powered: | awk '{print $2}'
]]

local function get_bluetooth()
  awful.spawn.easy_async_with_shell(bluetooth_state, function(stdout)
    local bluetooth_status = stdout:match("yes")
    awesome.emit_signal("signal::bluetooth", bluetooth_status)
  end)
end

gears.timer({
  timeout = 2,
  call_now = true,
  autostart = true,
  callback = function()
    get_bluetooth()
  end,
})
