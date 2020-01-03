local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local naughty = require("naughty")



-- Icon size
naughty.config.defaults['icon_size'] = 32

-- Timeouts (set 0 for permanent)
naughty.config.defaults.timeout = dpi(5)
naughty.config.presets.low.timeout = dpi(2)
naughty.config.presets.critical.timeout = 0

-- Apply theme variables
naughty.config.defaults.padding = dpi(5)
naughty.config.defaults.spacing = dpi(5)
naughty.config.defaults.margin = dpi(5)
naughty.config.defaults.border_width = dpi(3)
-- Apply rounded rectangle shape
beautiful.notification_shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
end

naughty.config.presets.normal = {
    font         = beautiful.notification_font,
    fg           = beautiful.notification_fg,
    bg           = beautiful.notification_bg,
    border_width = beautiful.notification_border_width,
    margin       = beautiful.notification_margin,
    position     = beautiful.notification_position
}

naughty.config.presets.low = {
    font         = beautiful.notification_font,
    fg           = beautiful.notification_fg,
    bg           = beautiful.notification_bg,
    border_width = beautiful.notification_border_width,
    margin       = beautiful.notification_margin,
    position     = beautiful.notification_position
}

naughty.config.presets.ok = naughty.config.presets.low
naughty.config.presets.info = naughty.config.presets.low
naughty.config.presets.warn = naughty.config.presets.normal

naughty.config.presets.critical = {
    font         = beautiful.notification_font,
    fg           = beautiful.notification_crit_fg,
    bg           = beautiful.notification_crit_bg,
    border_width = beautiful.notification_border_width,
    margin       = beautiful.notification_margin,
    position     = beautiful.notification_position
}

