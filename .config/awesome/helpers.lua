local gears = require("gears")
local wibox = require("wibox")
local theme = require("theme.theme")
local naughty = require("naughty")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

-- Create rounded rectangle shape (in one line)
local helpers = {}

helpers.rrect = function(radius)
  return function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, radius)
  end
end

-- function to colorize text
function helpers.colorize_text(txt, fg)
  return "<span foreground='" .. fg .. "'>" .. txt .. "</span>"
end

function helpers.vertical_pad(height)
  return wibox.widget({
    forced_height = height,
    layout = wibox.layout.fixed.vertical,
  })
end

function helpers.get_notification_widget(n)
  local time = os.date("%H:%M")
  return {
    {
      {
        {
          {
            {
              {
                {
                  image = n.icon or theme.notifications,
                  resize = true,
                  forced_height = 30,
                  forced_width = 30,
                  valign = "center",
                  align = "center",
                  clip_shape = gears.shape.circle,
                  widget = wibox.widget.imagebox,
                },
                right = dpi(6),
                widget = wibox.container.margin,
              },
              {
                markup = helpers.colorize_text(n.app_name, theme.blue),
                align = "left",
                valign = "center",
                widget = wibox.widget.textbox,
              },
              {
                markup = time,
                align = "right",
                font = theme.font .. "Bold 9",
                widget = wibox.widget.textbox,
              },
              spacing = dpi(10),
              layout = wibox.layout.align.horizontal,
            },
            top = dpi(8),
            bottom = dpi(8),
            left = dpi(10),
            right = dpi(10),
            widget = wibox.container.margin,
          },
          margins = dpi(8),
          widget = wibox.container.background,
          bg = theme.bg_alt,
        },
        {
          {
            {
              markup = "",
              widget = wibox.widget.textbox,
            },
            top = 1,
            widget = wibox.container.margin,
          },
          bg = theme.bg_alt,
          widget = wibox.container.background,
        },
        layout = wibox.layout.fixed.vertical,
      },
      {
        {
          n.title == "" and nil or {
            markup = "<b>" .. n.title .. "</b>",
            align = "left",
            valign = "left",
            font = theme.font .. " 10",
            widget = wibox.widget.textbox,
          },
          {
            markup = n.title == "" and "<b>" .. n.message .. "</b>" or n.message,
            align = "left",
            valign = "left",
            font = theme.font .. " 10",
            widget = wibox.widget.textbox,
          },
          spacing = dpi(5),
          layout = wibox.layout.fixed.vertical,
        },
        top = dpi(25),
        left = dpi(12),
        right = dpi(12),
        bottom = dpi(15),
        widget = wibox.container.margin,
      },
      {
        {
          notification = n,
          base_layout = wibox.widget({
            spacing = dpi(12),
            layout = wibox.layout.flex.horizontal,
          }),
          widget_template = {
            {
              {
                {
                  id = "text_role",
                  widget = wibox.widget.textbox,
                },
                widget = wibox.container.place,
              },
              top = dpi(7),
              bottom = dpi(7),
              left = dpi(4),
              right = dpi(4),
              widget = wibox.container.margin,
            },
            shape = gears.shape.rounded_bar,
            bg = theme.bg_alt,
            widget = wibox.container.background,
          },
          widget = naughty.list.actions,
          style = { underline_normal = false, underline_selected = true },
        },
        margins = dpi(12),
        widget = wibox.container.margin,
      },
      spacing = dpi(7),
      layout = wibox.layout.align.vertical,
    },
    bg = theme.bg_normal,
    fg = theme.fg_normal,
    shape = helpers.rrect(2),
    widget = wibox.container.background,
  }
end

return helpers
