#!/bin/bash
set -eu

function print_logo() {
  cat <<'EOF'
  PPPP                  t        III                t          l  l  
  P   P   ooo    ssss   t         I   nnn    ssss   t    aaa   l  l  
  PPPP   o   o  s      ttt        I   n  n  s      ttt      a  l  l  
  P      o   o   sss    t         I   n  n   sss    t    aaaa  l  l  
  P      o   o      s   t         I   n  n      s   t   a   a  l  l  
  P       ooo   ssss    tt       III  n  n  ssss    tt   aaaa  l  l  
EOF
}

function init_config() {
    local COMMONS_FILE="commons.sh"
    source "$COMMONS_FILE"
    source "$PACKAGES_CONF_FILE"
}

function packages() {
    print_step 'packages()'
    USER_NAME="rogerio" \
        ./packages.sh
    if [ "$?" != "0" ]; then
        exit 1
    fi
}

function dotfiles() {
  print_step 'dotfiles()'
  execute_user "cp -iu ../dotfiles/.gitconfig $HOME/.gitconfig"
  execute_user "cp -iu ../dotfiles/.zshrc $HOME/.zshrc"
}

function docker() {
  print_step 'settings docker'
  execute_sudo "systemctl enable docker.service"
  execute_sudo "usermod -aG docker rogerio"
}

function install_DE() {
  print_step 'install_DE'
  pacman_install 'gnome-shell gedit gnome-control-center
  nautilus gnome-terminal gnome-tweak-tool xdg-user-dirs
  gdm gnome-clocks gnome-weather gnome-calendar eog sushi
  gnome-boxes gnome-keyring networkmanager evince gnome-calculator 
  gnome-system-monitor gnome-themes-extra gnome-backgrounds'
  execute_sudo "systemctl enable gdm.service"
  execute_sudo "systemctl enable NetworkManager.service"
}

function bluetooth() {
  print_step 'bluetooth'
  pacman_install 'bluez bluez-utils'
  execute_sudo "systemctl enable bluetooth.service"
}

function openVPN() {
  print_step 'openVPN'
  pacman_install 'openvpn networkmanager-openvpn'
}

function cups() {
  print_step 'cups'
  pacman_install 'cups'
  execute_sudo "systemctl enable cups.service"
  execute_sudo "systemctl enable cups-browsed.service"
}

function zsh() {
  print_step 'zsh()'
  set +e
  pacman_install 'zsh'
  execute_user 'chsh -s $(which zsh)' # set zsh to default
  execute_user "wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -P $HOME/.local/share/fonts"
  execute_user "wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf -P $HOME/.local/share/fonts"
  execute_user "wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf -P $HOME/.local/share/fonts"
  execute_user "wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf -P $HOME/.local/share/fonts"
  execute_user 'fc-cache -fv'
  execute_user "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/powerlevel10k"
  execute_user "git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions"
  execute_user "git clone https://github.com/zsh-users/zsh-syntax-highlighting $HOME/.zsh/zsh-syntax-highlighting"
  execute_user "git clone https://github.com/larkery/zsh-histdb $HOME/.zsh/zsh-histdb"
  set -e
}

function asdf() {
  print_step 'asdf'
  set +e
  execute_user 'git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2'
  set -e
}

function remove_shortcuts() {
  print_step 'removeShortcuts'
  local APPLICATIONS_FOLDER='/usr/share/applications'
  SHORTCUTS=('avahi-discover.desktop' 'htop.desktop'
  'nvim.desktop' 'vim.desktop'
  'qvidcap.desktop' 'qv4l2.desktop'
  'bssh.desktop' 'bvnc.desktop' 'lstopo.desktop'
  'java-java11-openjdk.desktop' 'jconsole-java11-openjdk.desktop'
  'jshell-java11-openjdk.desktop' 'cmake-gui.desktop')
  set +e
  for shortcut in "${SHORTCUTS[@]}"
  do
    disable_file "$APPLICATIONS_FOLDER" "$shortcut"
  done
  set -e
}

function main() {
  print_logo
  init_config
  execute_step "packages"
  execute_step "dotfiles"
  execute_step "docker"
  execute_step "install_DE"
  execute_step "bluetooth"
  execute_step "openVPN"
  execute_step "cups"
  execute_step "zsh"
  execute_step "asdf"
  execute_step "remove_shortcuts"
}
main $@
