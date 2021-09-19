# GTK 

The GTK configurations for my system are two fold, the first is the GTK configurations included in this repository and the second is the repository containing my Neumorphic GTK theme named `Dhumavati GTK Theme` in honor of the Tantric Goddess of Death. 

## Local Configurations

### GTK2

GTK2 configurations are split into two files, the first and more important is the `gtkrc-2.0` file in which the options for GTK2 are set via typical `.ini` directives. In this file, the first included settings involve the modification of the color scheme which are made congruent with the rest of the system. After which the GTK theme is declared, with the icon theme and cursor theme following that. The cursor theme size is also included which is set to make the mouse easier to see at the cost of some precision (but prevents the need to include bloated libraries in awesome to do stupid and annoying things like flash the window the mouse is in). 

Then the toolbar style and icon size are set. As are the settings for button images, event sounds, input feedback sounds, antialiasing, hinting, hintstyle and rgba. Hinting is set to full in these files everywhere I remembered to check as this is my preferred setting (which is also set via fontconfig-infinality-remix's symlinked configurations). 

Another GTK2 file is the `gtkfilechooser` file in `.config/gtk-2.0` directory. This is used when another program opens a file chooser dialog and has its settings configured to my taste, such as files in ascending sort, starting with recent files, dialog window size, sort column set to name and the size column displayed. 

### GTK3
All of GTK3' configurations are symlinked to `.config/gtk-3.0` which is a neater solution than GTK2 requires and somewhat easier in that it includes CSS files for the theme handling portions. 
Among the css files, the `gtk.css` file performs modifications to the XFCE GTK theme, while also calling the `colors.css` file, which makes the GTK theme consistent with the `vice base16 color scheme`. The `settings.ini` provides a location to set the GTK theme variables (which are often also set in `~/.xsettingsd` ) and is where the bulk of the configurations of GTK3 are located. Finally the Bookmarks file contains bookmarks accessed by file managers, and is specific to me so you might want to change it a bit.``
