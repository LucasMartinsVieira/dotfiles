local awful = require("awful")
local gears = require("gears")

local wifi_stregth = [[
awk '/^\s*w/ { print  int($3 * 100 / 70) }' /proc/net/wireless
]]

local function wifi_sc()
    awful.spawn.easy_async_with_shell(wifi_stregth, function(stdout)
      
    local net_stregth = stdout

      if net_stregth == "" then
        net_stregth = 0
      end

    awesome.emit_signal("signal::wifi", net_stregth)
  end)
end

gears.timer({
  timeout = 3,
  autostart = true,
  call_now = true,
  callback = function()
    wifi_sc()
  end,
})
