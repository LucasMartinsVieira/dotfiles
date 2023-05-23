local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local theme = require("theme.theme")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local screenshot = {}

screenshot.notification = function(location)
        local open = naughty.action {
                name = "Open"
        }

        open:connect_signal("invoked", function(n)
                awful.spawn('xdg-open ' .. location, false)
        end)

        local delete = naughty.action {
                name = "Delete"
        }

        delete:connect_signal("invoked", function(n)
                awful.spawn('rm -rf ' .. location, true)
        end)

        naughty.notification {
                app_name = "Screenshot Tool",
                title = "Screenshot",
                icon = theme.camera,
                icon_size = dpi(50),
                message = "Smile 📸",
                ontop = true,
                actions = { open, delete },
                width = dpi(200),
                height = dpi(80),
        }
end


screenshot.area = function()
  local time = os.date("%y%m%d-%H%M-%S")
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
      screenshot.notification(location)
		end
	}:start()
end

screenshot.full = function()
  local time = os.date("%y%m%d-%H%M-%S")
	local location = "~/Imagens/Screenshot/" .. time .. ".png"

  local script = [[
  maim | tee ]] .. location .. [[ | xclip -selection clipboard -t image/png
  ]]

  awful.spawn.with_shell(script)
	gears.timer {
		timeout = 1,
		autostart = false,
		call_now = false,
		single_shot = true,
		callback = function()
      screenshot.notification(location)
		end
	}:start()
end

screenshot.window = function()
  local time = os.date("%y%m%d-%H%M-%S")
	local location = "~/Imagens/Screenshot/" .. time .. ".png"

  local script = [[
  maim --window $(xdotool getactivewindow) | tee ]] .. location .. [[ | xclip -selection clipboard -t image/png
  ]]

  awful.spawn.with_shell(script)
	gears.timer {
		timeout = 1,
		autostart = false,
		call_now = false,
		single_shot = true,
		callback = function()
      screenshot.notification(location)
		end
	}:start()
end

return screenshot
