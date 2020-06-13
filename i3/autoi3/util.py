#!/usr/bin/env python3

# Returns the list of names of workspaces of the focused monitor
def get_ws_list_for_monitor(i3):
    focused = get_focused_ws(i3)
    result = []
    for ws in i3.get_workspaces():
        if ws.output == focused.output:
            result.append(ws.name)
    return result

# Returns an available name for a new workspace
def get_new_ws_name(i3):
    ws_list = get_ws_list_sorted(i3)
    focused = get_focused_ws(i3).num
    result = None
    for i in range(focused+1, ws_list[-1]):
        if i not in ws_list:
            return i
    return ws_list[-1]+1

# Returns a list of all visible workspaces
def get_ws_list_visible(i3):
    result = []
    for ws in i3.get_workspaces():
        if ws.visible == True:
            result.append(ws.name)
    return result

# Returns a sorted list of numbers of all workspaces
def get_ws_list_sorted(i3):
    ws_numbers = []

    for ws in i3.get_workspaces():
       ws_numbers.append(ws.num)

    ws_numbers.sort()
    return ws_numbers

# Returns all information about the focused workspace
def get_focused_ws(i3):
    ws_list = i3.get_workspaces()
    for ws in ws_list:
        if ws.focused == True:
            return ws
