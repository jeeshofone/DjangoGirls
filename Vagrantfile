# -*- mode: ruby -*-
# vi: set ft=ruby :

# Ensure that an adequate version of Vagrant is used
Vagrant.require_version '>= 2.0.1'

# Usually, host locale environment variables are passed to guest. It may cause
# failures if the guest software do not support host locale.
ENV['LC_ALL'] = 'en_US.UTF-8'

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure('2') do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = 'ubuntu/xenial64'

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # If specified, Vagrant will compare the checksum of the downloaded box to
  # this value and error if they do not match. Checksum checking is only done
  # when Vagrant must download the box.
  # If this is specified, then "config.vm.box_download_checksum_type" must also
  # be specified.
  config.vm.box_download_checksum = true
  config.vm.box_download_checksum_type = 'sha256'

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network 'forwarded_port', guest: 8000, host: 8000

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080,
  # host_ip: "127.0.0.1"
  # ...

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  # This box uses the CodeClimate CLI to enable testing during writing code
  # Using install/run script based on instructions here:
  #  https://github.com/codeclimate/codeclimate#usage
  config.vm.provision 'docker',
                      images: ['codeclimate/codeclimate']

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
  $script_apps = <<SCRIPT
apt-get update
apt-get install -y vim-gtk
apt-get install -y meld
apt-get install -y git
apt-get install -y gnupg2
apt-get install -y gitk
apt-get install -y python3
apt-get install -y python3-pip
apt-get install -y python3-venv
snap install atom --classic

# install CodeClimate CLI
curl -L https://github.com/codeclimate/codeclimate/archive/master.tar.gz | tar xvz
cd codeclimate-* && sudo make install
SCRIPT

  config.vm.provision 'shell' do |s|
    s.inline = $script_apps
  end

  $script_config = <<SCRIPT
HOME="/home/vagrant"
git clone https://github.com/cabarnes/dotfiles.git /tmp/dotfiles &> /dev/null
if [ -e /tmp/dotfiles/install.sh ]; then
  cd /tmp/dotfiles
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
SCRIPT

  config.vm.provision 'shell' do |t|
    t.privileged = false
    t.inline = $script_config
  end
end
