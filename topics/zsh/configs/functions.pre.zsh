################################################################################
## Functions ###################################################################
################################################################################

function my_ip() { # Get IP adress.
  curl ifconfig.co
}

function extract {
  if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
  else
    if [ -f $1 ]; then
       NAME=${1%.*}
      mkdir $NAME 
      case $1 in
      *.tar.bz2) tar xvjf "$PWD"/$1 $NAME;;
      *.tar.gz) tar xvzf "$PWD"/$1 $NAME;;
      *.tar.xz) tar xvJf "$PWD"/$1 $NAME;;
      *.lzma) unlzma  "$PWD"/$1 $NAME;;
      *.bz2) bunzip2  "$PWD"/$1 $NAME;;
      *.rar) unrar x -ad  "$PWD"/$1 $NAME;;
      *.gz) gunzip  "$PWD"/$1 $NAME;;
      *.tar) tar xvf  "$PWD"/$1 $NAME;;
      *.tbz2) tar xvjf  "$PWD"/$1 $NAME;;
      *.tgz) tar xvzf  "$PWD"/$1 $NAME;;
      *.zip) unzip  "$PWD"/$1 $NAME;;
      *.Z) uncompress  "$PWD"/$1 $NAME;;
      *.7z) 7z x  "$PWD"/$1 $NAME;;
      *.xz) unxz  "$PWD"/$1 $NAME;;
      *.exe) cabextract  "$PWD"/$1 $NAME;;
      *) echo "extract: '$1' - unknown archive method" ;;
      esac
    else
      echo "$1 - file does not exist"
    fi
  fi
}

# Creates an archive (*.tar.gz) from given directory.
function maketar() { tar cvzf "${1%%/}.tar.gz" "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
function makezip() { zip -r "${1%%/}.zip" "$1"; }
