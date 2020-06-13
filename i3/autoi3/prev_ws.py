#!/usr/bin/env python3

import i3ipc
from util import *

def prev_ws(i3):
    focused = get_focused_ws(i3)
    ws_list = get_ws_list_for_monitor(i3)
    index = ws_list.index(focused.name)
    next_ws_name = ""
    if index-1 < 0:
        next_ws_name = ws_list[0]
    else:
        next_ws_name = ws_list[index-1]
    i3.command("workspace " + next_ws_name)

    
if __name__ == '__main__':
    i3 = i3ipc.Connection()
    prev_ws(i3)
