local awful = require "awful"
local applications = require("config.applications")

mainmenu = awful.menu {
	items = {
		{ "Audio Config", applications.default.audio },
		{ "Browser", applications.default.browser },
    { "Btop", applications.default.terminal_emulator .. " -e btop"},
    { "Image Editor", applications.default.image_editor },
    { "Menu", applications.default.app_launcher },
    { "Music Player", applications.default.music_player},
		{ "Restart", awesome.restart },
    { "RSS Reader", applications.default.rss_reader},
		{ "Terminal", applications.default.terminal_emulator },
	}
}
