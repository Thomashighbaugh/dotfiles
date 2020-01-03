-----------------------------------------------------------------
---------------------     Signals      --------------------------
-----------------------------------------------------------------
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Custom Local Library: Common Functional Decoration
require("deco.titlebar")

-- reading
-- https://awesomewm.org/wiki/Signals

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-----------------------------------------------------
------------------     Signals     ------------------
-----------------------------------------------------
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)


-- Make rofi able to unminimize minimized clients
client.connect_signal("request::activate", function(c, context, hints)
    if not awesome.startup then
        if c.minimized then
            c.minimized = false
        end
        awful.ewmh.activate(c, context, hints)
    end
end)



-- Rounded corners
if beautiful.border_radius or beautiful.border_radius ~= 0 then
    client.connect_signal("manage", function (c, startup)
        if not c.fullscreen then
            c.shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, beautiful.border_radius)
            end
        end
    end)

    -- Fullscreen clients should not have rounded corners
    client.connect_signal("property::fullscreen", function (c)
        if c.fullscreen then
            c.shape = function(cr, width, height)
                gears.shape.rectangle(cr, width, height)
            end
        else
            c.shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, beautiful.border_radius)
            end
        end
    end)
end


