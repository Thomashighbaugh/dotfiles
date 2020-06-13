#!/usr/bin/env python3

import i3ipc
from util import *

def next_visible(i3):
    focused = get_focused_ws(i3)
    ws_list = get_ws_list_visible(i3)
    index = ws_list.index(focused.name)
    i3.command("workspace " + ws_list[(index+1)%len(ws_list)])

if __name__ == '__main__':
    i3 = i3ipc.Connection()
    next_visible(i3)
