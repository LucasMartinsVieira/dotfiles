local awful = require("awful")
local gears = require("gears")

-- local upd_sc = [[
-- checkupdates | wc -l
-- ]]

local upd_sc = [[
echo 0
]]

local function get_upd()
  awful.spawn.easy_async_with_shell(upd_sc, function(upd)
    awesome.emit_signal("signal::updates", upd)
  end)
end

gears.timer({
  timeout = 30,
  call_now = true,
  autostart = true,
  callback = function()
    get_upd()
  end,
})
