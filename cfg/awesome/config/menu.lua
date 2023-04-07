local awful = require("awful")
local helpers = require("helpers")
local user_likes = require("user_vars")

awesomemenu = {
  { "Shutdown", function()  awful.spawn.with_shell("systemctl poweroff") end },
  { "Reboot", function() awful.spawn.with_shell("systemctl reboot") end },
  { "Restart", function() awesome.restart() end },
  { "Quit", function() awesome.quit() end },
}

mainmenu = awful.menu {
	items = {
    { "Awesome", awesomemenu },
    { "Applications", user_likes.apps.app_launcher },
		{ "Browser", user_likes.apps.browser },
		{ "Terminal", user_likes.apps.terminal_emulator },
    { "File Manager", user_likes.apps.file_manager },
	}
}

mainmenu.wibox.shape = helpers.rrect(4)
