# Git

Git provides a command line application to interact with remote version control repositories. In order to download these dotfiles, you probably needed git (and to use the install script, you definitely need it).

As an active developer who has a number of remote repositories I interact with daily, and a Linux user tired of loosing all my work when my install breaks, I find this application absolutely necessary and even have `.local/share/bin` scripts set up to streamline its use.

## Configuration

Provided in the repository is a `.gitconfig` file that provisions the user's home with my email and name, which you will probably want to change. Additionally, I have set `libsecret` as the credential manager and have the installation script install it.

By default, the branch that is pushed to is whatever the currently set branch is set at, for ease of modification of other branches than the master/main branch.

Whitespace is fixed by default, as per the option provided, as is autostash, aliases for the git command shortening most subcommands to their first letter (or first two if multiple with the same first letter exist, see list below), the global `.gitignore` is checked by default and rebases are automatically set up.

### Global gitignore

Also included is a user-wide (or global for all intents and purposes) `.gitignore` file that helps prevent certain (often sensitive) files from being accidentally included in commits. The excluded files are:

| File | Exclusion Reason|
|------x-----------------|
| .fuse*hidden | prevents including files being deleted locally|
| .directory | KDE directory preferences |
| .Trash-* | Prevents including trash |
| .nfs\_ | prevents including files being deleted but still open in an application |
| .tmp/ | prevents including temporary files |
| coverage/ | prevents including code coverage files |
| dist/ | prevents including build files, as hosting services typically will build themselves |
|node_modules | prevents including dependencies fetched by `npm` or `yarn` which hosts will download themselves in the build process |
| .projectile | prevents including the emacs project tracking files, which I don't use to store additional information |
| .idea/ | prevent storing intelliJ files from repo on remote |
| .vscode/ | prevent storing vscode files |

### Git Aliases

Git's configuration file allows the user to onfigure aliases for its subcommands, which saves me space in my `.aliases` directory. The aliases configured are listed below:

| Alias | Subcommand |
|-------x------------|
| a | add |
| b | branch |
| c | commit |
| cl | clone |
| co | checkout |
| ls | branch |
| ph | push |
| pl | pull |
| rho | reset --hard origin/main |
| rhom | reset --hard origin/master |
