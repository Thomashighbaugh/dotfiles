-----------------------------------------------------------------
---------------------     Client Keys      ----------------------
-----------------------------------------------------------------
-- Standard Awesome library
local gears = require("gears")
local awful = require("awful")

local _M = {}
local modkey = RC.vars.modkey

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get()
  local clientkeys = gears.table.join(

    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Original Example Key Bindings
    awful.key({ modkey,           }, "f",
      function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
      {description = "toggle fullscreen", group = "Client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close",group = "Client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating",group = "Client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master",group = "Client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen",group = "Client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top",group = "Client"}),
    awful.key({ modkey,           }, "n",
      function (c)
        -- The client currently has the input focus, so it cannot be
        -- minimized, since minimized clients can't have the focus.
        c.minimized = true
      end ,
      {description = "minimize",group = "Client"}),
    awful.key({ modkey,           }, "x",      function (c) c:kill()                         end,
              {description = "close",group = "Client"}),
    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Custom Fix Size
    awful.key({ modkey, "Mod1"    }, "Up", 
      function (c)   
        c.floating = not c.floating
        c.width    = 480
        c.x        = (c.screen.geometry.width-c.width) * 0.5
        c.height   = 400
        c.y        = (c.screen.geometry.height-c.height) * 0.5
      end ,
      {description = "480px * 400px",group = "Client"}),
    awful.key({ modkey, "Mod1"    }, "Down", 
      function (c)   
        c.floating = not c.floating
        c.width    = 480
        c.x        = (c.screen.geometry.width-c.width) * 0.5
        c.height   = 600
        c.y        = (c.screen.geometry.height-c.height) * 0.5
      end ,
      {description = "480px * 600px",group = "Client"}),
         awful.key({ modkey, "Mod1"    }, "Left", 
      function (c)   
        c.floating = not c.floating
        c.width    = 600
        c.x        = (c.screen.geometry.width-c.width) * 0.5
        c.height   = c.screen.geometry.height * 0.5
        c.y        = c.screen.geometry.height * 0.25
      end ,
      {description = "600px * 50%",group = "Client"}),
    awful.key({ modkey, "Mod1"    }, "Right", 
      function (c)   
        c.floating = not c.floating
        c.width    = 320
        c.x        = (c.screen.geometry.width-c.width) * 0.5
        c.height   = 400
        c.y        = (c.screen.geometry.height-c.height) * 0.5
      end ,
      {description = "800px * 50%",group = "Client"}),

   awful.key({ modkey, "Control" }, "t",
      function (c)
        awful.titlebar.toggle (c, "top")
      end,     
     {description = "toggle titlebar",group = "Client"}),
 



    --   -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
    -- Maximized
    awful.key({ modkey,           }, "m",
      function (c)
        c.maximized = not c.maximized
        c:raise()
      end ,
      {description = "(un)maximize",group = "Client"}),
    awful.key({ modkey, "Control" }, "m",
      function (c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
      end ,
      {description = "(un)maximize vertically",group = "Client"}),
    awful.key({ modkey, "Shift"   }, "m",
      function (c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
      end ,
      {description = "(un)maximize horizontally",group = "Client"})
  )

  return clientkeys
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable({}, { 
  __call = function(_, ...) return _M.get(...) end 
})
