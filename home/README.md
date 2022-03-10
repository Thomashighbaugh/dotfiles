# /home/ subdirectory

This subdirectory is for storing user configurations that belong to the user and not the whole system, such as configurations stored in `~/.config` or `~/.local/share`

The purpose of splitting up these configurations from a single directory is merely for organizational precision made possible by the present installation paradigm that enables me to move away from using a single subdirectory to house everything or having to replicate the specific path a directory is expected in within a topical directory such as `directory/.config/directory`. Note that this method also doesn't require the use of hidden directories, simplifying management somewhat trivially but still simplifying it nonetheless.

## Organization

Within this subdirectory are additional subdirectories that house the various files needed in the process of installing and provisioning my work environment, if you seek merely to test out my configurations, I advise copying them from here to the appropriate locations. There are some idiosyncratic arrangements found here within due to my particular tastes and quirks so I have provided a key for anyone so inclined to try these configurations out but unsure where to copy the files to in their home directory.

| Subdirectory | File               | Expected Location                    |
| ------------ | ------------------ | ------------------------------------ |
| bash         | bashrc             | ~/.bashrc                            |
| bash         | bashenv            | ~/.bashenv                           |
| dunst        | dunstrc            | ~/.config/dunst/dunstrc              |
| fontconfig   | fonts.conf         | ~/.config/fontconfig/fonts.conf      |
| git          | gitignore          | ~/.gitignore                         |
| git          | gitconfig          | ~/.gitconfig                         |
| gnupg        | gpg.conf           | ~/.gnupg/gpg.conf                    |
| gtk          | gtkrc-2.0          | ~/.config/gtkrc-2.0                  |
| gtk/gtk-2.0/ | gtkfilechooser.ini | ~/.config/gtk-2.0/gtkfilechooser.ini |
| gtk/gtk-3.0/ | gtk.css            | ~/.config/gtk-3.0/gtk.css            |
| gtk/gtk-3.0/ | colors.css         | ~/.config/gtk-3.0/colors.css         |
| kitty        | kitty.conf         | ~/.config/kitty/kitty.conf           |
| kitty        | theme.conf         | ~/.config/kitty/theme.conf           |
| luakit       | adblock-update.sh  | ~/.config/luakit/adblock-update.sh   |
| luakit       | rc.lua             | ~/.config/luakit/rc.lua              |
| luakit       | theme.lua          | ~/.config/luakit/theme.lua           |
| luakit       | userconf.lua       | ~/.config/luakit/userconf.lua        |
| neofetch     | config.conf        | ~/.config/neofetch/config.conf       |
| picom        | picom.conf         | ~/.config/picom.conf                 |
| rofi         | \*                 | ~/.config/rofi/\*                    |
| shell        | alias/\*           | not linked but called in place       |
| shell        | configs/\*         | not linked but called in place       |
| shell        | aliases            | ~/.aliases                           |
| shell        | profile            | ~/.profile                           |
| tym          | config.lua         | ~/.config/tym/config.lua             |
| tym          | theme.lua          | ~/.config/tym/theme.lua              |
| xorg         | color              | ~/.Xresources.d/color                |
| xorg         | font               | ~/.Xresources.d/font                 |
| xorg         | rxvt-unicode       | ~/.Xresources.d/rxvt-unicode         |
| xorg         | xterm              | ~/.Xresources.d/xterm                |
| xorg         | Xresources         | ~/.Xresources                        |
| xorg         | xprofile           | ~/.xprofile                          |
| xorg         | xinitrc            | ~/.xinitrc                           |
| xorg         | xprofile           | ~/.xprofile                          |
| zathura      | zathurarc          | ~/.config/zathura/zathurarc          |

Note: the "\*" reflects any file, since there are a lot and it would be redundant to list them all here.
