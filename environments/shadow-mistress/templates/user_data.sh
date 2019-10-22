#!/bin/bash

# For avoiding memory error
/bin/dd if=/dev/zero of=/var/swap.1 bs=1G count=2
/sbin/mkswap /var/swap.1
chmod 600 /var/swap.1
/sbin/swapon /var/swap.1

# Add user
adduser --disabled-password --gecos \"\" picosushi && sudo adduser picosushi sudo
sh -c 'echo picosushi\\ ALL=\\(ALL\\)\\ NOPASSWD:ALL > /etc/sudoers.d/picosushi-user'

# Update packages
export DEBIAN_FRONTEND=noninteractive
apt update
apt full-upgrade -y
apt install -y build-essential git curl apt-transport-https ca-certificates software-properties-common awscli linux-tools-common linux-tools-aws
apt install -y byobu tmux vim neovim fish jed figlet toilet cmake homesick

echo "================Install personal packages================"
# fzf
sudo --login --user=picosushi git clone --depth 1 https://github.com/junegunn/fzf.git /home/picosushi/.fzf
yes | sudo --login --user=picosushi /home/picosushi/.fzf/install

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sudo --login --user=picosushi sh -s -- -y
echo 'export PATH=$${PATH}:$${HOME}/.cargo/bin' | tee -a /home/picosushi/.bashrc
sudo --login --user=picosushi /home/picosushi/.cargo/bin/cargo install bat exa fd-find ripgrep

# docker
curl -fsSL https://get.docker.com/ | sudo sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
apt update && apt install -y docker-ce
usermod -aG docker picosushi

echo "================User setup================"
# SSH
mkdir -p /home/picosushi/.ssh
curl --proto '=https' --tlsv1.2 -sSf -o /home/picosushi/.ssh/authorized_keys https://github.com/PicoSushi.keys
chown -R picosushi:picosushi /home/picosushi/.ssh
chmod -R 700 /home/picosushi/.ssh
# Shell
sudo --login --user=picosushi homesick clone https://github.com/PicoSushi/dotfiles
yes | sudo --login --user=picosushi homesick link dotfiles
