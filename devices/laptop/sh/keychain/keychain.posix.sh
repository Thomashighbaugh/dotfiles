#!/bin/env sh

# keys
KEYCHAIN=${SSH_KEYS:-"${HOME}/.ssh/id_rsa"}
if [[ -s $(which keychain) ]]; then
	if [[ $(uname) == 'Linux' ]]; then
		eval $(keychain -q --eval --agents ssh $KEYCHAIN)
	else
		eval $(keychain -q --eval --agents ssh --inherit any $KEYCHAIN)
	fi
	[ -f ~/.keychain/$HOST-sh ] && source ~/.keychain/$HOST-sh
	[ -f ~/.keychain/$HOST-sh-gpg ] && source ~/.keychain/$HOST-sh-gpg
else
	ssh-add -A ~/.ssh/id_rsa &>/dev/null
fi
