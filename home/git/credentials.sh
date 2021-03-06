sudo pacman -S --noconfirm git-credential-manager-bin

gitconfig_local_path="$HOME/.gitconfig.local"

if ! [[ -f $gitconfig_local_path ]]; then
	credential_helper='libsecret'

	echo 'enter your full name'
	read -e user_name
	echo 'enter your e-mail'
	read -e user_email

	sed \
		-e "s/USER_NAME/$user_name/g" \
		-e "s/USER_EMAIL/$user_email/g" \
		-e "s/CREDENTIAL_HELPER/$credential_helper/g" \
		template.txt >"$gitconfig_local_path"
fi
