if ! [[ -d "$HOME/.nvm" ]]; then
  git clone https://github.com/creationix/nvm.git ~/.nvm
  install_default_node=true
fi

# We always initialize nvm because of other topics, such as yarn/install.sh
echo export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

if [[ -n "$install_default_node" ]]; then
  sleep 3
  nvm install node
  nvm use node
  nvm alias default node

  unset install_default_node

	npm --global install yarn
	yarn global add babel-eslint
	yarn global add create-component-app
	yarn global add create-next-app
	yarn global add create-react-app
	yarn global add eslint
	yarn global add eslint-plugin-react
	yarn global add eslint-plugin-jsx-a11y
	yarn global add eslint-config-prettier
	yarn global add gatsby
	yarn global add gulp
	yarn global add neovim
	yarn global add heroku
	yarn global add now
	yarn global add prettier
	yarn global add prettier-eslint
	yarn global add react
	yarn global add react-dom
	yarn global add webpack

	yarn upgrade

fi
