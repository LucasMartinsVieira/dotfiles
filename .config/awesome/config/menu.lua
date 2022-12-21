local awful = require "awful"
local applications = require("config.applications")
local screenshot = require("lib.screenshot")
local icons_dir = require("gears").filesystem.get_configuration_dir() .."/theme/assets/"
local icon = icons_dir .. "dragon-svgrepo-com.svg"

awesomemenu = {
  { "Shutdown", function()  awful.spawn.with_shell("systemctl poweroff") end },
  { "Reboot", function() awful.spawn.with_shell("systemctl reboot") end },
  { "Restart", function() awesome.restart() end },
  { "Quit", function() awesome.quit() end },
}

screenshotmenu = {
  { "Choose Area", function() screenshot.area() end },
  { "Fullscreen", function() screenshot.full() end },
}

mainmenu = awful.menu {
	items = {
    { "Awesome", awesomemenu, icon },
    { "Screenshot", screenshotmenu, icon },
		{ "Browser", applications.default.browser },
    { "Btop", applications.default.terminal_emulator .. " -e btop"},
		{ "Terminal", applications.default.terminal_emulator },
    { "Rofi", applications.default.app_launcher },
	}
}
