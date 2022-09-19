-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
local gears = require("gears")
local beautiful = require("beautiful")

----- Theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

----- Error Handling
require("config.errors")

----- Auto Start 
require("config.autostart")

----- Keybindings
require("config.keys")

----- Window Rules
require("config.rules")

----- Layout configs
require("config.layout")

----- Tags
require("config.tags")

----- Menu
require("config.menu")

----- Signals
require("config.signals")

----- Bar
require("config.bar")
