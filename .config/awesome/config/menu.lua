local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local applications = require("config.applications")
local screenshot = require("lib.screenshot")

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
    { "Awesome", awesomemenu },
    { "Screenshot", screenshotmenu },
    { "Applications", applications.default.app_launcher },
		{ "Browser", applications.default.browser },
		{ "Terminal", applications.default.terminal_emulator },
    { "File Manager", applications.default.file_manager },
    { "Music Player", applications.default.music_player },
	}
}

mainmenu.wibox.shape = function (cr, w, h)
  gears.shape.rounded_rect(cr, w, h, 4)
end
