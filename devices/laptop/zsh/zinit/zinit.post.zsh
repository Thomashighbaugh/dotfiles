################################################################################
## Zinit #######################################################################
################################################################################
source ~/.zinit/bin/zinit.zsh

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

source /usr/share/zsh/plugins/zsh-auto-notify/auto-notify.plugin.zsh          
source /usr/share/gitstatus/gitstatus.prompt.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

zinit load willghatch/zsh-saneopt

zinit load mafredri/zsh-async
zinit load rupa/z

zinit load zsh-users/zsh-history-substring-search
zinit load junegunn/fzf
zinit load zsh-users/zsh-autosuggestions
zinit load chrissicool/zsh-256color                                  
zinit load djui/alias-tips                                            


zinit load mollifier/cd-gitroot
zinit load micha/resty
zinit load supercrabtree/k


zinit load zdharma/fast-syntax-highlighting




zinit load zsh-users/zsh-autosuggestions
zinit ice silent wait!1 atload"ZINIT[COMPINIT_OPTS]=-C; zpcompinit"
##############################################################################
