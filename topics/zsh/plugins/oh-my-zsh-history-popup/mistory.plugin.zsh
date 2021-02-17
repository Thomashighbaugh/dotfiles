# Regex for matching and splitting a history line in line number and history text.
_MISTORY_LINE_PATTERN='^[ ]*([0-9]+)\*?[ ]+(.+)$'


# Checks whether the `dialog` command is available
_mistory_check_dialog() {
  which dialog &> /dev/null
  if [ $? -ne 0 ]
  then
    echo "Error: 'dialog' utility not found in PATH"
    return 1
  else
    return 0
  fi
}

# Display a dialog menu with a list of options
_mistory_dialog() {
  # Get default selection
  local defitem=$1
  shift
  # Compute dialog size
  local ww hh mh
  ((ww = $(tput cols) - 8))
  ((hh = $(tput lines) - 4))
  ((mh = hh - 6))
  # Open dialog
  dialog --keep-tite --title "History" --default-item $defitem --menu "" $hh $ww $mh $@
}

_mistory_main() {
  # Check if `dialog` command is available, exit otherwise
  _mistory_check_dialog || return

  # Get history lines matching text in prompt into an array
  # Multiline to array: https://unix.stackexchange.com/a/29748
  local history_array=("${(@f)$(history | grep "$BUFFER")}")
  #TODO if error / array is empty, make error noise and exit

  # Build array of history line pairs (number, text)
  local dialog_items=()
  for history_line in $history_array
  do
    [[ $history_line =~ $_MISTORY_LINE_PATTERN ]] && \
      dialog_items+=($match[1]) && dialog_items+=($match[2])
  done

  # Show dialog :-)
  local tmpfile=$(mktemp)
  # Maybe add this: trap "rm -f $tempfile" 0 0 1 2 3 15
  _mistory_dialog $dialog_items[-2] $dialog_items 2> $tmpfile
  local dialog_return=$?
  local sel_number=$(cat $tmpfile)
  rm $tmpfile

  # Display selection
  zle kill-whole-line
  zle accept-line
  # If user did not press < OK >, exit (TODO: but re-display buffer)
  [[ $dialog_return -ne 0 ]] && return
  # Get history line from selected menu item number
  local sel_line=$(history $sel_number $sel_number)
  # Get only the text from the history line and add it to the current line
  [[ $sel_line =~ $_MISTORY_LINE_PATTERN ]] && \
    zle -U $match[2]
}


# Define _mistory_main widget
zle -N _mistory_main
# Bind "Page up" to the widget
bindkey "^[[5~" _mistory_main
