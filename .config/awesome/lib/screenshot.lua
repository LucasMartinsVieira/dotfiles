local awful = require "awful"
local gears = require "gears"

local notify = require("ui.notify.notify_screenshot")


local screenshot = {}

screenshot.area = function()
  local time = os.date("%y-%m-%d_%H:%M:%S")
	local location = "~/Imagens/Screenshot/" .. time .. ".png"

  local script = [[
  maim -s | tee ]] .. location .. [[ | xclip -selection clipboard -t image/png
  ]]

  awful.spawn.with_shell(script)
	gears.timer {
		timeout = 6,
		autostart = false,
		call_now = false,
		single_shot = true,
		callback = function()
			notify.screenshot(location)
		end
	}:start()
end

screenshot.full = function()
  local time = os.date("%y-%m-%d_%H:%M:%S")
	local location = "~/Imagens/Screenshot/" .. time .. ".png"

  local script = [[
  maim | tee ]] .. location .. [[ | xclip -selection clipboard -t image/png
  ]]

  awful.spawn.with_shell(script)
  notify.screenshot(location)
end

return screenshot
