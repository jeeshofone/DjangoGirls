#!/bin/sh
# Script to bootstrap Ubuntu 16.04 to use as a dev environment
# this should be ran as root

apt-get update
apt-get install -y vim-gtk
apt-get install -y meld
apt-get install -y git
apt-get install -y gitk
apt-get install -y python3
apt-get install -y python3-pip
apt-get install -y python3-venv
snap install atom --classic

# install CodeClimate CLI
curl -fsSL --anyauth https://github.com/codeclimate/codeclimate/archive/master.tar.gz | tar xvz
cd codeclimate-* && sudo make install

# install Krypton for authenticating SSH and GPG
curl -fsSL --anyauth https://krypt.co/kr | sh
