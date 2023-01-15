--[[
 ______     __     __     ______     ______     ______     __    __     ______     __     __     __    __    
/\  __ \   /\ \  _ \ \   /\  ___\   /\  ___\   /\  __ \   /\ "-./  \   /\  ___\   /\ \  _ \ \   /\ "-./  \   
\ \  __ \  \ \ \/ ".\ \  \ \  __\   \ \___  \  \ \ \/\ \  \ \ \-./\ \  \ \  __\   \ \ \/ ".\ \  \ \ \-./\ \  
 \ \_\ \_\  \ \__/".~\_\  \ \_____\  \/\_____\  \ \_____\  \ \_\ \ \_\  \ \_____\  \ \__/".~\_\  \ \_\ \ \_\ 
  \/_/\/_/   \/_/   \/_/   \/_____/   \/_____/   \/_____/   \/_/  \/_/   \/_____/   \/_/   \/_/   \/_/  \/_/ 
                                                                                                             
  --]]

pcall(require, "luarocks.loader")
local gears = require("gears")
local beautiful = require("beautiful")

-- Theme
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

-- Config
require("config")

-- Widgets
require("ui")
require("signals")
