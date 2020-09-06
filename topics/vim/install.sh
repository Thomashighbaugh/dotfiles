yay -S --noconfirm --sudoloop --needed vim vi sudo  vim-runtime vim-spell-en


ln -sv $HOME/dotfiles/topics/vim/vim/vimrc $HOME/.vimrc
ln -svf $HOME/dotfiles/topics/vim/vim $HOME/.vim
ln -sv $HOME/dotfiles/topics/vim/vim/vim/plugins.vim $HOME/.vim/plugins.vim
ln -svf $HOME/dotfiles/topics/vim/vim/vim/plugged $HOME/.vim/plugged
ln -sv $HOME/dotfiles/topics/vim/vim/vim/autoload $HOME/.vim/autoload