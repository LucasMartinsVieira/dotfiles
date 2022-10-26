local awful = require "awful"
local applications = require("config.applications")

mainmenu = awful.menu {
	items = {
		{ "Audio Config", applications.default.audio },
		{ "Browser", applications.default.browser },
    { "Btop", applications.default.terminal_emulator .. " -e btop"},
		{ "Restart", awesome.restart },
		{ "Terminal", applications.default.terminal_emulator },
	}
}
