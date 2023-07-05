#!/bin/bash
clear

#
# Debian based version
#

sudo apt update
sudo apt upgrade -y
sudo fwupdmgr get-devices
sudo fwupdmgr get-updates
sudo fwupdmgr update -y

# Packages
sudo apt install -y git htop exa bat traceroute tree whois dnsutils net-tools apt-transport-https neofetch bash-completion curl wget default-jre default-jdk vagrant gimp thunderbird code flatpak vlc virt-manager vim neovim deja-dup fonts-jetbrains-mono gnome-shell-extension-manager gparted unzip p7zip p7zip-full transmission pip cargo

# Flatpak
flatpak remote-add --user --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

flatpak install -y com.spotify.Client md.obsidian.Obsidian org.cryptomator.Cryptomator

# Docker

sudo apt install docker docker-compose -y
sudo usermod -aG docker $USER

# DotFiles

sudo cp -iu ../dotfiles/.gitconfig $HOME/.gitconfig
sudo cp -iu ../dotfiles/.zshrc $HOME/.zshrc

# ZSH

sudo apt install zsh zsh-autosuggestions zsh-syntax-highlighting fzf -y
chsh -s $(which zsh) ## Required password
sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -P /usr/local/share/fonts
sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -P /usr/local/share/fonts
sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -P /usr/local/share/fonts
sudo wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -P /usr/local/share/fonts
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.powerlevel10k
echo 'source ~/.powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# SYSCTL - SSD/NVME and RAM config
sudo sh -c "echo 'vm.vfs_cache_pressure=50' >> /etc/sysctl.conf"
sudo sh -c "echo 'vm.dirty_background_ratio = 5' >> /etc/sysctl.conf"
sudo sh -c "echo 'vm.swappiness=10' >> /etc/sysctl.conf"

# Disable coredump
echo "* hard core 0" >> /mnt/etc/security/limits.conf

# Security kernel settings.
curl https://raw.githubusercontent.com/Whonix/security-misc/master/etc/sysctl.d/30_security-misc.conf >> /mnt/etc/sysctl.d/30_security-misc.conf
sed -i 's/kernel.yama.ptrace_scope=2/kernel.yama.ptrace_scope=3/g' /mnt/etc/sysctl.d/30_security-misc.conf
curl https://raw.githubusercontent.com/Whonix/security-misc/master/etc/sysctl.d/30_silent-kernel-printk.conf >> /mnt/etc/sysctl.d/30_silent-kernel-printk.conf


# ASDF and Node
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0

## After all reboot!
