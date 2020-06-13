#!/usr/bin/env python3

import i3ipc
from util import *

def mv_next_ws(i3):
    focused = get_focused_ws(i3)
    ws_list = get_ws_list_for_monitor(i3)
    index = ws_list.index(focused.name)
    next_ws_name = ""
    if index+1 >= len(ws_list):
        next_ws_name = str(get_new_ws_name(i3))
    else:
        next_ws_name = ws_list[index+1]
    i3.command("move container to workspace " + next_ws_name)

if __name__ == '__main__':
    i3 = i3ipc.Connection()
    mv_next_ws(i3)
