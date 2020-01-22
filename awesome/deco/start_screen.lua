-----------------------------------------------------------------
---------------------    Start Screen      ----------------------
-----------------------------------------------------------------
local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local naughty = require("naughty")
local home = os.getenv("HOME")
local vicious = require("vicious")
local keygrabber = require("awful.keygrabber")
function pad(size)
    local str = ""
    for i = 1, size do
        str = str .. " "
    end
    local pad = wibox.widget.textbox(str)
    return pad

end
local helpers = require("main.helpers")
-- Appearance
local box_radius = dpi(12)
local box_gap = dpi(6)

-- Get screen geometry
local screen_width = awful.screen.focused().geometry.width
local screen_height = awful.screen.focused().geometry.height

-- Create the widget
start_screen = wibox({visible = false, ontop = true, type = "dock"})
awful.placement.maximize(start_screen)

start_screen.bg = beautiful.start_screen_bg or beautiful.exit_screen_bg or beautiful.wibar_bg or "#111111"
start_screen.fg = beautiful.start_screen_fg or beautiful.exit_screen_fg or beautiful.wibar_fg or "#FEFEFE"

start_screen:buttons(gears.table.join(
-- Middle click - Hide start_screen
        awful.button({ }, 2, function ()
            start_screen_hide()
        end),
-- Right click - Hide start_screen
        awful.button({ }, 3, function ()
            start_screen_hide()
        end)
))



local function create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
    local box_container = wibox.container.background()
    box_container.bg = bg_color
    box_container.forced_height = height
    box_container.forced_width = width
    box_container.shape =  gears.shape.rounded_rect

    local boxed_widget = wibox.widget {
        -- Add margins
        {
            -- Add background color
            {
                -- Center widget_to_be_boxed horizontally
                nil,
                {
                    -- Center widget_to_be_boxed vertically
                    nil,
                    -- The actual widget goes here
                    widget_to_be_boxed,
                    layout = wibox.layout.align.vertical,
                    expand = "none"
                },
                layout = wibox.layout.align.horizontal,
                expand = "none"
            },
            widget = box_container,
        },
        margins = box_gap,
        color = "#FF000000",
        widget = wibox.container.margin
    }

    return boxed_widget
end



-- User widget
local user_picture_container = wibox.container.background()
user_picture_container.shape = gears.shape.circle
user_picture_container.forced_height = dpi(240)
user_picture_container.forced_width = dpi(240)
local user_picture = wibox.widget {
    wibox.widget.imagebox(os.getenv("HOME").."/.coNerd Fontig/awesome/profile.png"),
    widget = user_picture_container
}
local username = os.getenv("USER")
local user_text = wibox.widget.textbox(username)
-- Capitalize username
 local user_text = wibox.widget.textbox(username:upper())
user_text.font = "ProFontWindows Nerd Font Bold 18"
user_text.align = "center"
user_text.valign = "center"


local user_widget = wibox.widget {
    user_picture,
    pad(1),
    pad(1),
    user_text,
    layout = wibox.layout.fixed.vertical
}
local user_box = create_boxed_widget(user_widget, dpi(300), dpi(340), beautiful.xbackground)

-- Calendar
-- Create the calendar
local styles = {}
styles.month   = { padding      = dpi(5),
                   fg_color     = beautiful.xcolor7,
                   bg_color     = beautiful.xbackground.."00",
                   border_width = 0,
}
styles.normal  = {}
styles.focus   = { fg_color = "#F0719B",
                   bg_color = "#24262A",
                   markup   = function(t) return '<b>' .. t .. '</b>' end,
    -- markup   = function(t) return '<span foreground="'..beautiful.xcolor1..'"><b>' .. t .. '</b></span>' end,
}
styles.header  = { fg_color = "#89DDFF",
                   bg_color = "#24262A",
    -- markup   = function(t) return '<b>' .. t .. '</b>' end,
                   markup   = function(t) return '<span font_desc="ProFontWindows Nerd Font Bold 24">' .. t .. '</span>' end,
}
styles.weekday = { fg_color ="#FF8537",
                   bg_color = "#24262A",
                   padding  = 3,
                   markup   = function(t) return '<b>' .. t .. '</b>' end,
}
local function decorate_cell(widget, flag, date)
    if flag=='monthheader' and not styles.monthheader then
        flag = 'header'
    end
    local props = styles[flag] or {}
    if props.markup and widget.get_text and widget.set_markup then
        widget:set_markup(props.markup(widget:get_text()))
    end
    -- Change bg color for weekends
    local d = {year=date.year, month=(date.month or 1), day=(date.day or 1)}
    local weekday = tonumber(os.date('%w', os.time(d)))
    local default_fg = "#4E515B"
    local default_bg = "#24262A"
    -- local default_bg = (weekday==0 or weekday==6) and beautiful.xcolor6 or beautiful.xcolor14
    local ret = wibox.widget {
        {
            widget,
            margins = (props.padding or 2) + (props.border_width or 0),
            widget  = wibox.container.margin
        },
        shape              = props.shape,
        shape_border_color = props.border_color or beautiful.xbackground,
        shape_border_width = props.border_width or 0,
        fg                 = props.fg_color or default_fg,
        bg                 = props.bg_color or default_bg,
        widget             = wibox.container.background
    }
    return ret
end

calendar_widget = wibox.widget {
    date     = os.date('*t'),
    font     = "ProFontWindows Nerd Font Bold 14",
    long_weekdays = false,
    spacing  = dpi(4),
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

local calendar_box = create_boxed_widget(calendar_widget, dpi(400), dpi(492), beautiful.xbackground)
-- local calendar_box = create_boxed_widget(calendar, 380, 540, beautiful.xcolor0)

-- Time widget
local hours = wibox.widget.textclock("<span color='#8245FF'>Time:</span>\n%H:%M")
hours.font = "ProFontWindows Nerd Font Bold 30"
hours.align = "center"
hours.valign = "center"


-- Time
local time = wibox.widget {
    hours,
    layout = wibox.layout.fixed.horizontal
}
local time_box = create_boxed_widget(time, dpi(150), dpi(200), beautiful.xbackground)

-- Date
local day_of_the_week = wibox.widget.textclock("%A")
day_of_the_week.font = "ProFontWindows Nerd Font Bold 20"
day_of_the_week.fg = beautiful.xcolor0
day_of_the_week.align = "center"
day_of_the_week.valign = "center"
day_of_the_week.align = "center"
day_of_the_week.valign = "center"
 day_of_the_week.markup = "<span color='#8265FF'>" .. day_of_the_week.text .. "</span>"
 day_of_the_week:connect_signal("widget::redraw_needed", function ()
     day_of_the_week.markup = "<span color='#8265FF'>" .. day_of_the_week.text .. "</span>"
 end)
local day_of_the_month = wibox.widget.textclock("%d")
day_of_the_month.font = "ProFontWindows Nerd Font Bold 30"
day_of_the_month.fg = beautiful.xcolor0
day_of_the_month.align = "center"
day_of_the_month.valign = "center"

day_of_the_month.align = "center"
day_of_the_month.valign = "center"
day_of_the_month.markup = "<span color='#8265FF'>" .. day_of_the_month.text .. "</span>"
day_of_the_month:connect_signal("widget::redraw_needed", function ()
    day_of_the_month.markup = "<span color='" .. beautiful.xcolor1 .."'>" .. day_of_the_month.text .. "</span>"

    -- Also update the calendar widget ;)
    calendar_widget.date = os.date('*t')
end)

local date = wibox.widget {
    day_of_the_week,
    day_of_the_month,
    layout = wibox.layout.align.vertical
}
local date_box = create_boxed_widget(date, dpi(160), dpi(130), beautiful.xbackground)

-- Fortune
--local fortune_command = "fortune -n 140 -s"
 local fortune_command = "fortune -n 140 -s computers"
local fortune = wibox.widget {
    font = "ProFontWindows Nerd Font Bold 9",
    align = "center",
    text = "Loading witty quote...",
    widget = wibox.widget.textbox
}

local fortune_update_interval = 20
awful.widget.watch(fortune_command, fortune_update_interval, function(widget, stdout)
    -- Remove trailing whitespaces
    stdout = stdout:gsub('^%s*(.-)%s*$', '%1')
    fortune.markup = stdout
end)

local fortune_widget = wibox.widget {
    fortune,
    margins = box_gap * 3,
    color = "#00000000",
    widget = wibox.container.margin
}


local fortune_box = create_boxed_widget(fortune_widget, 250, 140, beautiful.xbackground)
fortune_box:buttons(gears.table.join(
-- Left click - New fortune
        awful.button({ }, 1, function ()
            awful.spawn.easy_async_with_shell(fortune_command, function(out)
                -- Remove trailing whitespaces
                out = out:gsub('^%s*(.-)%s*$', '%1')
                fortune.markup = "<p>"..out.."</p>"
            end)
        end)
))
helpers.add_hover_cursor(fortune_box, "hand1")
-- memory widget
mem = wibox.widget.textbox()
vicious.cache(vicious.widgets.mem)
vicious.register(mem, vicious.widgets.mem, "<span color='#2196F3'> Mem: </span> \n $1%", 9)
mem.font = "ProFontWindows Nerd Font Bold 18"
-- cpu widget
cpu = wibox.widget.textbox()
vicious.cache(vicious.widgets.cpu)
vicious.register(cpu, vicious.widgets.cpu, "<span color='#A742EA'> CPU: </span> \n $1%", 9)
cpu.font = "ProFontWindows Nerd Font Bold 18"
--filesystem widget
fs = wibox.widget.textbox()
vicious.register(fs, vicious.widgets.fs, "<span color='#f0719B'> SSD: </span> \n ${/ avail_gb} GB")
fs.font = "ProFontWindows Nerd Font Bold 18"
-- Uptime Widgets
uptime = wibox.widget.textbox()
vicious.cache(vicious.widgets.uptime)
vicious.register(uptime, vicious.widgets.uptime, "<span color='#A742EA'> Up:</span> \n $2:$3")
uptime.font = "ProFontWindows Nerd Font Bold 18"


local cpu_box = create_boxed_widget(cpu, dpi(120), dpi(114), beautiful.xbackground)
local mem_box = create_boxed_widget(mem, dpi(120), dpi(114), beautiful.xbackground)
local fs_box = create_boxed_widget(fs, dpi(120), dpi(114), beautiful.xbackground)
local uptime_box = create_boxed_widget(uptime, dpi(120), dpi(114), beautiful.xbackground)


local screenshot = wibox.widget.textbox("         timed \n  screenshot \n")
screenshot.resize = true
screenshot.forced_width = icon_size
screenshot.forced_height = icon_size
screenshot.font = "FontAwesome Bold 22"
local screenshot_box = create_boxed_widget(screenshot, dpi(180), dpi(142), beautiful.xbackground)
screenshot_box:buttons(gears.table.join(
-- Left click - Take screenshot
        awful.button({ }, 1, function ()
            naughty.notify({title = "Screenshot Sequence Begun", text = "Taking shot in 5 seconds", timeout = 9, icon =""})
            helpers.screenshot("full", 5)
        end),
-- Right click - Take screenshot in 10 seconds
        awful.button({ }, 3, function ()
            naughty.notify({title = "Screenshot Sequence Begun", text = "Taking shot in 10 seconds", timeout = 9, icon =""})
            helpers.screenshot("full", 10)
        end)
))

helpers.add_hover_cursor(screenshot_box, "hand1")

-- Item placement
start_screen:setup {
    -- Center boxes vertically
    nil,
    {
        -- Center boxes horizontally
        nil,
        {
            -- Column container
            {
                -- Column 1
                user_box,
                screenshot_box,

                layout = wibox.layout.fixed.vertical
            },
            {
                -- Column 2
                fortune_box,
                time_box,
                date_box,
                layout = wibox.layout.fixed.vertical
            },
            {
                -- Column 3
                cpu_box,
                mem_box,
                fs_box,
                uptime_box,
                wifi_box,
                layout = wibox.layout.fixed.vertical
            },
            {
                -- Column 4
                calendar_box,

                layout = wibox.layout.fixed.vertical
            },
            layout = wibox.layout.fixed.horizontal
        },
        nil,
        expand = "none",
        layout = wibox.layout.align.horizontal

    },
    nil,
    expand = "none",
    layout = wibox.layout.align.vertical
}

local start_screen_grabber
function start_screen_hide()
    awful.keygrabber.stop(start_screen_grabber)
    start_screen.visible = false
end


local original_cursor = "left_ptr"
function start_screen_show()
    local w = mouse.current_wibox
    if w then
        w.cursor = original_cursor
    end
   -- naughty.notify({text = "starting the keygrabber"})
    start_screen_grabber = awful.keygrabber.run(function(_, key, event)
        if event == "release" then return end
        -- Press Escape or q or F1 to hide it
        if key == 'Escape' or key == 'q' or key == 'F1' then
            start_screen_hide()
        end
    end)
    start_screen.visible = true
end
