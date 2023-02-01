local gears = require("gears")
local awful = require("awful")
local dpi = require("beautiful").xresources.apply_dpi
local naughty = require("naughty")
local theme = require("theme.theme")
local wibox = require("wibox")
local helpers = require("helpers")

-- Notification Center

-- Title
local notify_header = wibox.widget({
  markup = 'Notification Center',
  font = theme.font .. " Bold 11",
  align = 'center',
  valign = 'center',
  widget = wibox.widget.textbox
})

-- Clear Button
local notify_clear = wibox.widget({
  markup = helpers.colorize_text("", theme.purple),
  font = theme.font .. " 18",
  align = "center",
  valign = "center",
  widget = wibox.widget.textbox
})

notify_clear:buttons(gears.table.join(
  awful.button({}, 1, function()
    _G.reset_notify_container()
  end)
))

-- Empty Notifications
local notify_empty = wibox.widget({
    {
        {
            expand = 'none',
            layout = wibox.layout.align.horizontal,
            nil,
            {
                markup = helpers.colorize_text("!!", theme.blue),
                font = theme.font .. " 45",
                align = "center",
                valign = "center",
                widget = wibox.widget.textbox
            },
            nil
        },
        {
            markup = helpers.colorize_text("No Notification!", theme.blue),
            font = theme.font .. ' 13',
            align = 'center',
            valign = 'center',
            widget = wibox.widget.textbox
        },
        layout = wibox.layout.fixed.vertical,
        spacing = dpi(5)
    },
    top = dpi(250),
    widget = wibox.container.margin
})

-- Mouse Scroll
local notify_container = wibox.layout.fixed.vertical()
notify_container.spacing = dpi(5)
notify_container.forced_width = dpi(270)

local remove_notify_empty = true

reset_notify_container = function()
    notify_container:reset(notify_container)
    notify_container:insert(1, notify_empty)
    remove_notify_empty = true
end

remove_notify_box = function(box)
  notify_container:remove_widgets(box)

  if #notify_container.children == 0 then
    notify_conatainer:insert(1, notify_empty)
    remove_notify_empty = true
  end

  -- Create Notifications
  local create_notify = function(icon, n, width)
    local time = os.date("%H:%M")
    local box = {}

    local dismiss = wibox.widget({
        markup = helpers.colorize_text("", theme.purple),
        font = theme.font .. " 10",
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox
    })
    
    dismiss:buttons(gears.table.join(
        awful.button({}, 1, function()
            _G.remove_notify_box(box)
        end)
    ))

    box = wibox.widget({
    {
      {
        {
          {
            image = icon,
            resize = true,
            clip_shape = helpers.rrect(6),
            halign = "center",
            valign = "center",
            widget = wibox.widget.imagebox,
          },
          strategy = "exact",
          height = 50,
          width = 50,
          widget = wibox.container.constraint,
        },
        {
          {
            nil,
            {
              {
                {
                  step_function = wibox.container.scroll.step_functions.waiting_nonlinear_back_and_forth,
                  speed = 50,
                  {
                    markup = n.title,
                    font = beautiful.font_var .. " Bold 11",
                    align = "left",
                    widget = wibox.widget.textbox,
                  },
                  forced_width = 140,
                  widget = wibox.container.scroll.horizontal,
                },
                nil,
                {
                  markup = "<span foreground='" .. beautiful.fg_color .. "'>" .. time .. "</span>",
                  align = "right",
                  valign = "bottom",
                  font = beautiful.font_var .. "9",
                  widget = wibox.widget.textbox,
                },
                expand = "none",
                layout = wibox.layout.align.horizontal,
              },
              {
                markup = "<span foreground='" .. beautiful.fg_color .. "99" .. "'>" ..  n.message .. "</span>",
                font = beautiful.font_var .. " 10",
                align = "left",
                forced_width = 165,
                widget = wibox.widget.textbox,
              },
              spacing = 3,
              layout = wibox.layout.fixed.vertical,
            },
            expand = "none",
            layout = wibox.layout.align.vertical,
          },
          left = 15,
          widget = wibox.container.margin,
        },
        layout = wibox.layout.align.horizontal,
      },
      margins = 15,
      widget = wibox.container.margin,
    },
    forced_height = 85,
    shape = helpers.rrect(6),
    widget = wibox.container.background,
    bg = beautiful.bg_light_alt .. "4D",
    })
  end
  
end
