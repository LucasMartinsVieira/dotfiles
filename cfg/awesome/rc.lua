--[[
 ▄▄▄       █     █░▓█████   ██████  ▒█████   ███▄ ▄███▓▓█████ 
 ▒████▄    ▓█░ █ ░█░▓█   ▀ ▒██    ▒ ▒██▒  ██▒▓██▒▀█▀ ██▒▓█   ▀ 
 ▒██  ▀█▄  ▒█░ █ ░█ ▒███   ░ ▓██▄   ▒██░  ██▒▓██    ▓██░▒███   
 ░██▄▄▄▄██ ░█░ █ ░█ ▒▓█  ▄   ▒   ██▒▒██   ██░▒██    ▒██ ▒▓█  ▄ 
  ▓█   ▓██▒░░██▒██▓ ░▒████▒▒██████▒▒░ ████▓▒░▒██▒   ░██▒░▒████▒
  ▒▒   ▓▒█░░ ▓░▒ ▒  ░░ ▒░ ░▒ ▒▓▒ ▒ ░░ ▒░▒░▒░ ░ ▒░   ░  ░░░ ▒░ ░
   ▒   ▒▒ ░  ▒ ░ ░   ░ ░  ░░ ░▒  ░ ░  ░ ▒ ▒░ ░  ░      ░ ░ ░  ░
   ░   ▒     ░   ░     ░   ░  ░  ░  ░ ░ ░ ▒  ░      ░      ░   
       ░  ░    ░       ░  ░      ░      ░ ░         ░      ░  ░
--]]

pcall(require, "luarocks.loader")
local gears = require("gears")
local beautiful = require("beautiful")

-- Theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

-- Config
require("config")

-- Bindings
require("bindings")

-- Widgets
require("ui")
require("signals")
