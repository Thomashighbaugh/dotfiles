#!/usr/bin/env bash
# Node Package Management
###########################################################################
alias npm="npm "
alias npmi="npm install "
alias npmig="nom install -g "
alias npmup="npm update --global "
alias npma="npm audit --fix "
alias yarnup="yarn global upgrade "
alias nvm8="nvm use 8 "
alias nvm10="nvm use 10 "
alias nvm12="nvm use 12 "
alias nvm14="nvm use 14 "
alias nvm16=" nvm use 16 "
alias nvmNow="nvm use node "

## Clears cache, lock and node_modules (for gatsy dev) expected to fail if no NPM lock is present but if it is, clears it
alias clear-yarn="rm .cache && rm yarn.lock && rm node_modules && rm package.json.lock "
## Same as above, but if NPM is primary package manager
alias clear-npm="rm .cache && rm package.json.lock && node_modules && rm yarn.lock "
