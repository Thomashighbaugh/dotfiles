-----------------------------------------------------------------
---------------------     Tags      -----------------------------
-----------------------------------------------------------------

-- Standard awesome library
local awful = require("awful")

local _M = {}

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

function _M.get ()
  local tags = {}

  local tagpairs = {
    names  = {
      " A ", " W ", " E ",
      " S ", " O ",
      " M ", " E ", " W ", " M " },

    layout = {
      RC.layouts[1], RC.layouts[2], RC.layouts[4],
      RC.layouts[5], RC.layouts[6], RC.layouts[12],
      RC.layouts[9], RC.layouts[3], RC.layouts[7]
    }
  }

  awful.screen.connect_for_each_screen(function(s)
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tagpairs.names, s, tagpairs.layout)
  end)
  
  return tags
end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

return setmetatable(
  {}, 
  { __call = function(_, ...) return _M.get(...) end }
)
