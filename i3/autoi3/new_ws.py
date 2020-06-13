#!/usr/bin/env python3

import i3ipc
from util import *

def new_ws(i3):
    i3.command("workspace " + str(get_new_ws_name(i3)))

if __name__ == '__main__':
    i3 = i3ipc.Connection()
    new_ws(i3)

