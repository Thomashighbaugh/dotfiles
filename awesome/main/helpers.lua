-----------------------------------------------------------------
---------------------     Helpers      --------------------------
-----------------------------------------------------------------

-- Functions that you use more than once and in different files would
-- be nice to define here.
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")

local naughty = require("naughty")
local home = os.getenv("HOME")

local helpers = {}

-- Create rounded rectangle shape (in one line)
helpers.rrect = function(radius)
    return function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, radius)
    end
end

helpers.prrect = function(radius, tl, tr, br, bl)
    return function(cr, width, height)
        gears.shape.partially_rounded_rect(cr, width, height, tl, tr, br, bl, radius)
    end
end

function helpers.colorize_text(txt, fg)
    return "<span color='" .. fg .."'>" .. txt .. "</span>"
end

function helpers.client_menu_toggle()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = dpi(250) } })
        end
    end
end

function helpers.pad(size)
    local str = ""
    for i = 1, size do
        str = str .. " "
    end
    local pad = wibox.widget.textbox(str)
    return pad
end

function helpers.move_to_edge(c, direction)
    -- local workarea = awful.screen.focused().workarea
    -- local client_geometry = c:geometry()
    if direction == "up" then
        local old_x = c:geometry().x
        awful.placement.top(c, {honor_padding = true, honor_workarea = true, honor_padding = true})
        c.x = old_x
        -- c:geometry({ nil, y = workarea.y + beautiful.screen_margin * 2, nil, nil })
    elseif direction == "down" then
        local old_x = c:geometry().x
        awful.placement.bottom(c, {honor_padding = true, honor_workarea = true, honor_padding = true})
        c.x = old_x
        -- c:geometry({ nil, y = workarea.height + workarea.y - client_geometry.height - beautiful.screen_margin * 2 - beautiful.border_width * 2, nil, nil })
    elseif direction == "left" then
        local old_y = c:geometry().y
        awful.placement.left(c, {honor_padding = true, honor_workarea = true, honor_padding = true})
        c.y = old_y
        -- c:geometry({ x = workarea.x + beautiful.screen_margin * 2, nil, nil, nil })
    elseif direction == "right" then
        local old_y = c:geometry().y
        awful.placement.right(c, {honor_padding = true, honor_workarea = true, honor_padding = true})
        c.y = old_y
        -- c:geometry({ x = workarea.width + workarea.x - client_geometry.width - beautiful.screen_margin * 2 - beautiful.border_width * 2, nil, nil, nil })
    end
end


-- Add a hover cursor to a widget by changing the cursor on
-- mouse::enter and mouse::leave
-- You can find the names of the available cursors by opening any
-- cursor theme and looking in the "cursors folder"
-- For example: "hand1" is the cursor that appears when hovering over
-- links
function helpers.add_hover_cursor(w, hover_cursor)
    local original_cursor = "left_ptr"

    w:connect_signal("mouse::enter", function ()
        local w = _G.mouse.current_wibox
        if w then
            w.cursor = hover_cursor
        end
    end)

    w:connect_signal("mouse::leave", function ()
        local w = _G.mouse.current_wibox
        if w then
            w.cursor = original_cursor
        end
    end)
end

-- Move client to screen edge, respecting the screen workarea
function helpers.move_to_edge(c, direction)
    local workarea = awful.screen.focused().workarea
    if direction == "up" then
        c:geometry({ nil, y = workarea.y + beautiful.useless_gap * 2, nil, nil })
    elseif direction == "down" then
        c:geometry({ nil, y = workarea.height + workarea.y - c:geometry().height - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil })
    elseif direction == "left" then
        c:geometry({ x = workarea.x + beautiful.useless_gap * 2, nil, nil, nil })
    elseif direction == "right" then
        c:geometry({ x = workarea.width + workarea.x - c:geometry().width - beautiful.useless_gap * 2 - beautiful.border_width * 2, nil, nil, nil })
    end
end

-- Rounds a number to any number of decimals
function helpers.round(number, decimals)
    local power = 10 ^ decimals
    return math.floor(number * power) / power
end


function helpers.screenshot(action, delay)
    local cmd
    local timestamp = os.date("%Y.%m.%d-%H.%M.%S")
    local filename = home.."/Pictures/"..timestamp..".screenshot.png"
    -- local filename = user.screenshot_dir.."screenshot"..timestamp..".png"
    local maim_args = "-u -b 3 -m 5"
    local icon = ""

    local prefix
    if delay then
        prefix = "sleep "..tostring(delay).." && "
    else
        prefix = ""
    end

    if action == "full" then
        cmd = prefix.."maim "..maim_args.." "..filename
        print(filename)
        awful.spawn.easy_async_with_shell(cmd, function(_, __, ___, ____)
            naughty.notify({ title = "Screenshot", message = "Screenshot taken", icon = icon })
        end)
    elseif action == "selection" then
        cmd = "maim "..maim_args.." -s "..filename
        naughty.notify({ title = "Screenshot", message = "Select area to capture.", icon = icon })
        awful.spawn.easy_async_with_shell(cmd, function(_, __, ___, exit_code)
            if exit_code == 0 then
                naughty.notify({ title = "Screenshot", message = "Selection captured", icon = icon })
            end
        end)
    elseif action == "clipboard" then
        naughty.notify({ title = "Screenshot", message = "Select area to copy to clipboard.", icon = icon })
        cmd = "maim "..maim_args.." -s /tmp/maim_clipboard && xclip -selection clipboard -t image/png /tmp/maim_clipboard && rm /tmp/maim_clipboard"
        awful.spawn.easy_async_with_shell(cmd, function(_, __, ___, exit_code)
            if exit_code == 0 then
                naughty.notify({ title = "Screenshot", message = "Copied selection to clipboard", icon = icon })
            end
        end)
    elseif action == "browse" then
        awful.spawn.with_shell("cd ".. home.."/Pictures/".." && feh $(ls -t)")
    elseif action == "gimp" then
        awful.spawn.with_shell("cd ".. home.."/Pictures/".." && gimp $(ls -t | head -n1)")
        naughty.notify({ message = "Opening last screenshot with GIMP", icon = icon })
    end

end


return helpers
