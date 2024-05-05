#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

#Enable wayland for firefox.
export MOZ_ENABLE_WAYLAND=1
#Let QT5 communicate with wayland
export QT_QPA_PLATFORM=wayland

# Functions
function up {
 sudo pacman -Syyuu --noconfirm
 flatpak update -y
}

# Alias
alias ls='exa -l --header --icons'
alias cat='bat' # only ubuntu otherwise change to bat
alias grep='grep --color=auto'
alias meminfo='free -m -l -t'
alias ping='ping -c3'	# Default to 3 attemps instead of unlimited
alias p8='ping 8.8.8.8'
alias vi='lvim'
alias getip='curl ifconfig.me'
alias zz='vim ~/.bashrc && source ~/.bashrc'
alias gh='history|grep'
alias count='find . -type f | wc -l'
alias cpv='rsync -ah --info=progress2'
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'

# ASDF
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"
