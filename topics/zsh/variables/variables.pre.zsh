
################################################################################
## Variable Definitions ######################################################## 
################################################################################

## Most env variables are defined with the .profile sourced by both ZSH and BASH, 
## this file primarily exists to guarentee that ARCH doesn't pretend its 
## locale is not set

## Locale ######################################################################
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

## Locally Set & Useful ########################################################

export DATE=$(date +%s)
export WORDCHARS=${WORDCHARS//\/[&.;]}  


## Prompt ######################################################################
RPROMPT='$(git_prompt_string)'

## NVM ######################################################################
echo export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"