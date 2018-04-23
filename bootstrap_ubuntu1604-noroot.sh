#!/bin/sh
# Script to bootstrap Ubuntu 16.04 to use as dev environment
# Install steps that don't need root and should be run after 
# the root intstaller

HOME="/home/vagrant"
git clone https://github.com/cabarnes/dotfiles.git /tmp/dotfiles > /dev/null 2>&1
if [ -e /tmp/dotfiles/install.sh ]; then
  cd /tmp/dotfiles || return 1 # handle if cd fails
  sed -i'.bak' "s|~/|${HOME}/|g" install.sh
  ./install.sh
fi

# ensure gpg knows how to prompt for passphrase
GPG_EXPORT='export GPG_TTY=\$(tty)'
BASHRC_FILE="${HOME}/.bashrc"
if ! $(grep -qw "^\s*${GPG_EXPORT}" ${BASHRC_FILE})
then
  echo -n "missing $(echo "${GPG_EXPORT}" | tr -d '\\') in ${BASHRC_FILE}..."
  echo "$(echo "${GPG_EXPORT}" | tr -d '\\')" >> ${BASHRC_FILE}
  echo added.
fi

