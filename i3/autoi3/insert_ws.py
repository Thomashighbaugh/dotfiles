#!/usr/bin/env python3

import i3ipc
from util import *

def insert_ws(i3):
    ws_list = get_ws_list_for_monitor(i3)
    new_ws = get_ws_list_sorted(i3)[-1]+1
    focused = get_focused_ws(i3).name
    ws_list = ws_list[ws_list.index(focused)+1:]
    ws_list.append(str(new_ws))

    # Check if the current workspace is the last on the monitor
    if len(ws_list) < 2:
        i3.command("workspace " + str(new_ws))
        return

    ws_list.reverse()
    for i in range(1, len(ws_list)):
        i3.command("workspace " + str(ws_list[i]))
        i3.command("rename workspace to " + str(ws_list[i-1]))
    i3.command("workspace " + str(ws_list[-1]))

if __name__ == '__main__':
    i3 = i3ipc.Connection()
    insert_ws(i3)

