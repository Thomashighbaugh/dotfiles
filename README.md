```
#####   ####  ##### ###### # #      ######  ####     #  #  #      #       #   #
#    # #    #   #   #      # #      #      #             ##      #         # #
#    # #    #   #   #####  # #      #####   ####                #        #######
#    # #    #   #   #      # #      #           #              #     ###   # #
#    # #    #   #   #      # #      #      #    #             #      ###  #   #
#####   ####    #   #      # ###### ######  ####             #       ###
```

![Screenshot of my desktop](1.png)

# Dotfiles of Thomas Leon Highbaugh

> Never mind the bullocks, here's my dotfiles!'
> Makefile managed configurations of ZSH, BASH, VIM, NeoVim, Kitty, Alacritty, AwesomeWM, SpaceMacs, Docker, Git, GTK, Ranger, Rofi+DMenu, Zathura, Xresources, Pacman, Firefox and More
> For Manjaro Linux (or other Arch based systems with Yay Installed)

![Another Screensot](2.png)


---

## Table of Contents (Optional)

> If your `README` has a lot of info, section headers might be nice.

- [Installation](#installation)
- [Features](#features)
- [FAQ](#faq)
- [License](#license)

---

## Example (Optional)

```javascript
// code away!

let generateProject = project => {
  let code = [];
  for (let js = 0; js < project.length; js++) {
    code.push(js);
  }
};
```

---

## Installation

- Use the commands below to fetch the code and provision your system
- If you would like to modify any part of the installation process, changes should be reflected within the Makefile

![Set Up Commands](<screenshot/carbon(1).png>)

---

## Features

- Configurations for - ZSH - .zshrc .zshenv, .zprofile - based on the Manjaro defaults but rearranged so that variables are available to all shells on the system - BASH - .bashrc, .profile, .bashenv - based on Manjaro defaults and included for times when using ZSH is not possible or practical - VIM - .vimrc including plugin manager and configuration - TMUX - tmux configuration and tmuxp files for tmux layout consistency - NeoVim - based on VIM configuration fr consistency - Kitty - including kitty.conf and a file for color themes - Alacritty - for times when kitty isn't working right - AwesomeWM - modular configuration file with custom interface themes - SpaceMacs - my preferred features already set, including toolbar for new initiates - Docker - custom DOCKERFILE using arch linux base - Git - configuring my name and email in .gitconfiguration as well as the universal .gitignore file - GTK - pulls in my custom GTK theme, [Dhumavati](https://github.com/Thomashighbaugh/Dhumavati), which is intended to be a dark theme that matches my AwesomeWM theme - Ranger - made consistent in theme with the rest of the system - Rofi+DMenu - adds several functions available with hotkeys on Awesome WM for powering the system off, changing xrandr configuration, managing wifi, etc. Custom overlay available on Awesome using mod4(windows) key. - Zathura - adding color theme - Xresources - adding color scheme and configuarations for Xterm URXVT, etc. - Pacman - adding colors to output of search commands - Firefox - custom theme and modifications using userChrome.css. Strips out Manjaro defaults and default homepage/new tab page replacing them with my [startpage](https://github.com/Thomashighbaugh/startpage) repository hosted locally.
- ~/bin/ - a folder with shell scripts and small applications utilized locally
- ~/lib/ - files and larger functionality that is nice to have across my workstation environments
- Custom Firefox theme and modifications using userChrome.css
- Custom Awesome WM theme and modular configuration
-

## Usage (Optional)

## Documentation (Optional)

- Individual documentation for the various configurations is **a work in progress**. Check back for updates as time goes on.

---

## FAQ

- **Why Did You Use Makefile instead of Stow or A Dotfiles Manager**


  - _Makefile offers the most features with the most customization options and is remarkably similar to shell scripts in constructing_ - **Most Features** Unlike Stow or the various Dotfile Management Applications, Make does more than just symlinking files in the repository, it can run almost any shell command, enabling one to store files meant for /etc/ in the dotfiles repo. By separating portions of the configuration out, one can tailor the provisioning process to the specific needs of the system they are provsioning easily and powerfully.  
     - **Most Customization** You can use Makefiles to provision the system and install the dotfiles. Being that these were two separate steps prior, having them both easily done at once simplifies the time it takes to spin up a new system. - **Shell Script Like Syntax** You can run pretty much any shell command within the Makefile, which is contained under various headings within the file. Under these headings are shell commands that run when the heading is called. This creates an environment that is pretty much shell scripts + modularity that is expected by the make comand.


- **How Do I Get the Firefox Configuration to Work** - To provision firefox, and Firefox Developer Edition, the Makefile creates and symlinks configurations into two directories. Open the browser, go to about:profiles, create a new profile and select one of those directories in the same directory as the other profiles as the source directory and voila! - Note: The default firefox homepage and new tab page are both replaced by my 'startpage' repository which is to be hosted locally and downloaded with during the "browsers" provisioning process.
---

## License

[![License](http://img.shields.io/:license-mit-blue.svg?style=flat-square)](http://badges.mit-license.org)

- **[MIT license](http://opensource.org/licenses/mit-license.php)**
- Copyright 2020 © <a href="http://thomasleonhighbaugh.me" target="_blank">Thomas Leon Highbaugh</a>.