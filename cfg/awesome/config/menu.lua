local awful = require("awful")
local helpers = require("helpers")
local applications = require("config.applications")

awesomemenu = {
  { "Shutdown", function()  awful.spawn.with_shell("systemctl poweroff") end },
  { "Reboot", function() awful.spawn.with_shell("systemctl reboot") end },
  { "Restart", function() awesome.restart() end },
  { "Quit", function() awesome.quit() end },
}

mainmenu = awful.menu {
	items = {
    { "Awesome", awesomemenu },
    { "Applications", applications.default.app_launcher },
		{ "Browser", applications.default.browser },
		{ "Terminal", applications.default.terminal_emulator },
    { "File Manager", applications.default.file_manager },
	}
}

mainmenu.wibox.shape = helpers.rrect(4)
