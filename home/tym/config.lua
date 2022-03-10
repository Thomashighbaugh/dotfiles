-- At first, you need to require tym module
local tym = require('tym')

-- set individually
--tym.set('width', 100)


-- set by table
tym.set_config({
  shell = '/usr/bin/zsh',
  cursor_shape = 'underline',
  autohide = true,
  color_foreground = '#b2bfd9',
  silent = true,
  scrollback_length=1024,
  padding_vertical=12,
  padding_horizontal=12,
  cursor_blink_mode= 'on'
})
