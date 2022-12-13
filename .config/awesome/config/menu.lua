local awful = require "awful"
local applications = require("config.applications")
local beautiful = require("beautiful")

awesomemenu = {
  { "Shutdown", function()  awful.spawn.with_shell("systemctl poweroff") end },
  { "Reboot", function() awful.spawn.with_shell("systemctl reboot") end },
  { "Restart", function() awesome.restart() end },
  { "Quit", function() awesome.quit() end },
}

mainmenu = awful.menu {
	items = {
    { "Awesome", awesomemenu, beautiful.awesome_icon },
		{ "Audio Config", applications.default.audio },
		{ "Browser", applications.default.browser },
    { "Btop", applications.default.terminal_emulator .. " -e btop"},
		{ "Terminal", applications.default.terminal_emulator },
    { "Rofi", applications.default.app_launcher },
	}
}

mylauncher1 = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mainmenu })
