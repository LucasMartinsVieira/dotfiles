local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local theme = require("theme.theme")

local calendar_widget = {}

local function worker(user_args)

    local args = user_args

    local placement = 'top'

    local styles = {}
    local function rounded_shape(size)
        return function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, size)
        end
    end

    styles.month = {
        padding = 10,
        bg_color = theme.bg_normal,
        border_width = 0,
    }

    styles.normal = {
        markup = function(t) return t end,
        shape = rounded_shape(4)
    }

    styles.focus = {
        fg_color = theme.taglist_fg_focus,
        bg_color = theme.bg_normal,
        markup = function(t) return '<b>' .. t .. '</b>' end,
        shape = rounded_shape(4)
    }

    styles.header = {
        fg_color = theme.taglist_fg_occupied,
        bg_color = theme.bg_normal,
        markup = function(t) return '<b>' .. t .. '</b>' end
    }

    styles.weekday = {
        fg_color = theme.fg_focus,
        bg_color = theme.bg_normal,
        markup = function(t) return '<b>' .. t .. '</b>' end,
    }

    local function decorate_cell(widget, flag, date)
        if flag == 'monthheader' and not styles.monthheader then
            flag = 'header'
        end

        -- highlight only today's day
        if flag == 'focus' then
            local today = os.date('*t')
            if not (today.month == date.month and today.year == date.year) then
                flag = 'normal'
            end
        end

        local props = styles[flag] or {}
        if props.markup and widget.get_text and widget.set_markup then
            widget:set_markup(props.markup(widget:get_text()))
        end
        -- Change bg color for weekends
        local d = { year = date.year, month = (date.month or 1), day = (date.day or 1) }
        local weekday = tonumber(os.date('%w', os.time(d)))
        local default_bg = (weekday == 0 or weekday == 6)
            and theme.bg_normal
            or theme.bg_normal
        local ret = wibox.widget {
            {
                {
                    widget,
                    halign = 'center',
                    widget = wibox.container.place
                },
                margins = (props.padding or 2) + (props.border_width or 0),
                widget = wibox.container.margin
            },
            shape = props.shape,
            shape_border_color = props.border_color or '#000000',
            shape_border_width = props.border_width or 0,
            fg = props.fg_color or theme.fg_normal,
            bg = props.bg_color or theme.bg_normal,
            widget = wibox.container.background
        }

        return ret
    end

    local cal = wibox.widget {
        date = os.date('*t'),
        font = theme.font,
        fn_embed = decorate_cell,
        long_weekdays = true,
        start_sunday = true,
        widget = wibox.widget.calendar.month
    }

    local popup = awful.popup {
        ontop = true,
        visible = false,
        shape = rounded_shape(8),
        offset = { y = 5 },
        border_width = 1,
        border_color = theme.bg_normal,
        widget = cal
    }

    popup:buttons(
            awful.util.table.join(
                    awful.button({}, 4, function()
                        local a = cal:get_date()
                        a.month = a.month + 1
                        cal:set_date(nil)
                        cal:set_date(a)
                        popup:set_widget(cal)
                    end),
                    awful.button({}, 5, function()
                        local a = cal:get_date()
                        a.month = a.month - 1
                        cal:set_date(nil)
                        cal:set_date(a)
                        popup:set_widget(cal)
                    end)
            )
    )

    function calendar_widget.toggle()

        if popup.visible then
            -- to faster render the calendar refresh it and just hide
            cal:set_date(nil) -- the new date is not set without removing the old one
            cal:set_date(os.date('*t'))
            popup:set_widget(nil) -- just in case
            popup:set_widget(cal)
            popup.visible = not popup.visible
        else
            if placement == 'top' then
                awful.placement.top(popup, { margins = { top = 30 }, parent = awful.screen.focused() })
            elseif placement == 'top_right' then
                awful.placement.top_right(popup, { margins = { top = 30, right = 10}, parent = awful.screen.focused() })
            else
                awful.placement.top(popup, { margins = { top = 30 }, parent = awful.screen.focused() })
            end

            popup.visible = true

        end
    end

    return calendar_widget

end

return setmetatable(calendar_widget, { __call = function(_, ...)
    return worker(...)
end })
