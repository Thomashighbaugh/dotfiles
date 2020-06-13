#!/usr/bin/env python3

import i3ipc
from util import *
import prev_ws

def close_ws(i3):
    focused = get_focused_ws(i3)
    i3.command("[workspace=" + focused.name + "] kill")

if __name__ == '__main__':
    i3 = i3ipc.Connection()
    close_ws(i3)
    prev_ws.prev_ws(i3)
