local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")

local modkey = "Mod4"

local ll = awful.widget.layoutlist({
  base_layout = wibox.widget({
    spacing = 5,
    forced_num_cols = 5,
    layout = wibox.layout.grid.vertical,
  }),
  widget_template = {
    {
      {
        id = "icon_role",
        forced_height = 22,
        forced_width = 22,
        widget = wibox.widget.imagebox,
      },
      margins = 4,
      widget = wibox.container.margin,
    },
    id = "background_role",
    forced_width = 25,
    forced_height = 25,
    shape = gears.shape.rounded_rect,
    widget = wibox.container.background,
  },
})

local layout_popup = awful.popup({
  widget = wibox.widget({
    ll,
    margins = 4,
    widget = wibox.container.margin,
  }),
  border_color = beautiful.border_color,
  border_width = beautiful.border_width,
  placement = awful.placement.centered,
  ontop = true,
  visible = false,
  shape = gears.shape.rounded_rect,
})

-- Make sure you remove the default Mod4+Space and Mod4+Shift+Space
-- keybindings before adding this.
awful.keygrabber({
  start_callback = function()
    layout_popup.visible = true
  end,
  stop_callback = function()
    layout_popup.visible = false
  end,
  export_keybindings = true,
  stop_event = "release",
  stop_key = { "Escape", "Super_L", "Super_R" },
  keybindings = {
    awful.key({
      modifiers = { modkey },
      key = "Tab",
      group = "Layout Switcher",
      description = "Open and Switch to the Next",
      on_press = function()
        awful.layout.set((gears.table.cycle_value(ll.layouts, ll.current_layout, 1)))
      end,
    }),
    awful.key({
      modifiers = { modkey, "Shift" },
      key = "Tab",
      group = "Layout Switcher",
      description = "Open and Switch to the Previous",
      on_press = function()
        awful.layout.set((gears.table.cycle_value(ll.layouts, ll.current_layout, -1)))
      end,
    }),
  },
})
