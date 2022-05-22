FROM artixlinux/runit




# specific to antergos setup when using the `base` installation
ARG USER_SUDOERS_FILE="10-user"

# specific to this system's setup
ARG ELECTRICTANTRA_USER="tlh"
ARG ELECTRICTANTRA_PASSWORD="password"
ARG ELECTRICTANTRA_SETUP_SUDOERS_FILE="20-setup"

RUN \
  # generate locales prior to package compilation
  locale-gen && \
  # add core dependencies - includes the kernel, bash, gnu utils, shadow, sudo
  pacman -Sy --noconfirm --needed base base-devel git gnupg openssh zsh unzip >/dev/null && \
  # add our user account and set a passwordf
  useradd -m -g users -G wheel -s /bin/zsh "${ELECTRICTANTRA_USER}" && \
  echo "${ELECTRICTANTRA_USER}:${ELECTRICTANTRA_PASSWORD}" | chpasswd && \
  # add a sudoers config allowing our user to use `sudo` and fix permissions
  echo "${ELECTRICTANTRA_USER} ALL=(ALL) ALL" | tee -a "/etc/sudoers.d/${USER_SUDOERS_FILE}" && \
  chmod 0440 "/etc/sudoers.d/${USER_SUDOERS_FILE}" && \
  # add a temporary sudoers config file allowing our user to `sudo` freely w/o
  # a password so we avoid the need for a custom `askpass` script inside the
  # docker environment
  echo "${ELECTRICTANTRA_USER} ALL=NOPASSWD: ALL" | tee -a "/etc/sudoers.d/${ELECTRICTANTRA_SETUP_SUDOERS_FILE}" && \
  chmod 0440 "/etc/sudoers.d/${ELECTRICTANTRA_SETUP_SUDOERS_FILE}"

# swap into our user account
USER "${ELECTRICTANTRA_USER}"
SHELL ["/bin/bash", "-c"]


RUN \
  # run our system setup script from our staging alias
  git clone "https://github.com/Thomashighbaugh/dotfiles" dotfiles && \
  bash dotfiles/docker/install.sh && \
  # clean up any extraneous dependencies left over by our installation
  paru --clean --noconfirm && \
  # clean up pacman's package cache for installed & uninstalled packages
  sudo pacman -Scc --noconfirm && \
  # remove the sudo config we previously created to make our docker setup work
  echo "${ELECTRICTANTRA_PASSWORD}" | sudo -S -i rm "/etc/sudoers.d/${ELECTRICTANTRA_SETUP_SUDOERS_FILE}"

SHELL ["/bin/zsh", "-c"]
CMD ["/bin/zsh"]
