-----------------------------------------------------------------
---------------------     Calendar      -------------------------
-----------------------------------------------------------------

local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local gears = require("gears")
local naughty = require("naughty")

local calendar_widget = {}

local function worker(args)

    local calendar_themes = {
        default = {
            bg = '#17161B',
            fg = '#DEE6E7',
            focus_date_bg = '#24262A',
            focus_date_fg = '#F0719B',
            weekend_day_bg = '#24262A',
            weekday_fg = '#939597',
            header_fg = '#2196F3',
            border = '#8265FF'
        },
   --
    }
-- @TODO: add more themes
    local args = args or {}

    if args.theme ~= nil and calendar_themes[args.theme] == nil then
        naughty.notify({
            preset = naughty.config.presets.critical, 
            title = 'Calendar Widget',
            text = 'Theme "' .. args.theme .. '" not found, fallback to default'})
        args.theme = 'default'
    end

    local theme = args.theme or 'default'
    local placement = args.placement or 'top'


    local styles = {}
    local function rounded_shape(size)
        return function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, size)
        end
    end

    styles.month = {
        padding = 2,
        bg_color = calendar_themes[theme].bg,
        border_width = 0,
    }

    styles.normal = {
        markup = function(t) return t end,
        shape = rounded_shape(4)
    }

    styles.focus = {
        fg_color = calendar_themes[theme].focus_date_fg,
        bg_color = calendar_themes[theme].focus_date_bg,
        markup = function(t) return '<span>' .. t .. '</span>' end,
        shape = rounded_shape(4)
    }

    styles.header = {
        fg_color = calendar_themes[theme].header_fg,
        bg_color = "#24262A",
        markup = function(t) return '<b>' .. t .. '</b>' end
    }

    styles.weekday = {
        fg_color = "#FFA56B",
        bg_color = "#24262A",
        markup = function(t) return '<b>' .. t .. '</b>' end,
    }

    local function decorate_cell(widget, flag, date)
        if flag == 'monthheader' and not styles.monthheader then
            flag = 'header'
        end

        -- highlight only today's day
        if flag == 'focus' then
            local today = os.date('*t')
            if today.month ~= date.month then
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
        local default_fg = "#4E515B"
        local default_bg = "#24262A"
     local ret = wibox.widget {
             {
                 widget,
                 margins = (18) + (5),
                 widget  = wibox.container.margin
             },
             shape              = props.shape,
             shape_border_color = props.border_color or beautiful.xbackground,
             shape_border_width = 1,
             fg                 = props.fg_color or default_fg,
             bg                 = props.bg_color or default_bg,
             widget             = wibox.container.background
         }
         return ret
     end


  calendar_widget = wibox.widget {
    date     = os.date('*t'),
    font     = "FuraMono NF Bold 22",
    long_weekdays = false,
    spacing  = dpi(12),
    forced_width = dpi(720),
    padding = dpi(18),
    fn_embed = decorate_cell,
    widget   = wibox.widget.calendar.month
}

local current_month = os.date('*t').month
calendar_widget:buttons(gears.table.join(
-- Left Click - Reset date to current date
        awful.button({ }, 1, function ()
            calendar_widget.date = os.date('*t')
        end),
-- Scroll - Move to previous or next month
        awful.button({ }, 4, function ()
            new_calendar_month = calendar_widget.date.month - 1
            if new_calendar_month == current_month then
                calendar_widget.date = os.date('*t')
            else
                calendar_widget.date = {month = new_calendar_month, year = calendar_widget.date.year}
            end
        end),
        awful.button({ }, 5, function ()
            new_calendar_month = calendar_widget.date.month + 1
            if new_calendar_month == current_month then
                calendar_widget.date = os.date('*t')
            else
                calendar_widget.date = {month = new_calendar_month, year = calendar_widget.date.year}
            end
        end)
))


    local popup = awful.popup {
        ontop = true,
        visible = false,
        shape = gears.shape.rounded_rect,
        offset = { y = 8 },
        border_width = 3,
        border_color = calendar_themes[theme].border,
        widget = calendar_widget
    }

    popup:buttons(
            awful.util.table.join(
                    awful.button({}, 4, function()
                        local a = calendar_widget:get_date()
                        a.month = a.month + 1
                        calendar_widget:set_date(nil)
                        calendar_widget:set_date(a)
                        popup:set_widget(calendar_widget)
                    end),
                    awful.button({}, 5, function()
                        local a = calendar_widget:get_date()
                        a.month = a.month - 1
                        calendar_widget:set_date(nil)
                        calendar_widget:set_date(a)
                        popup:set_widget(calendar_widget)
                    end)
            )
    )

    function calendar_widget.toggle()

        if popup.visible then
            -- to faster render the calendar refresh it and just hide
            calendar_widget:set_date(nil) -- the new date is not set without removing the old one
            calendar_widget:set_date(os.date('*t'))
            popup:set_widget(nil) -- just in case
            popup:set_widget(calendar_widget)
            popup.visible = not popup.visible
        else
            if placement == 'top' then
                awful.placement.top(popup, { margins = { top = 80 }, parent = awful.screen.focused() })
            elseif placement == 'top_right' then
                awful.placement.top_right(popup, { margins = { top = 80, right = 30}, parent = awful.screen.focused() })
            elseif placement == 'bottom_right' then
                awful.placement.bottom_right(popup, { margins = { bottom = 80, right = 30}, parent = awful.screen.focused() })
            else
                awful.placement.top(popup, { margins = { top = 80 }, parent = awful.screen.focused() })
            end

            popup.visible = true

        end
    end

    return calendar_widget

end

return setmetatable(calendar_widget, { __call = function(_, ...)
    return worker(...)
end })
