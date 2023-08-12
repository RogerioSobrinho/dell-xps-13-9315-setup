# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source ~/.powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# do not store duplications
setopt HIST_IGNORE_DUPS
# ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=3'

# setup autocompletion
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
# autocompletion using arrow keys (based on history)
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

setopt prompt_subst
autoload -U colors && colors
local resetColor="%{$reset_color%}"
PS1="%F{cyan}"'($(basename "$CONDA_DEFAULT_ENV")) '"$resetColor"
PS1+='%n%{$reset_color%}@$(scutil --get ComputerName):'"$resetColor"
PS1+=$'\e[38;5;211m$(short_cwd) ';
PS1+=$'\e[38;5;48m[$(git_repo):$(git_branch)] ';
PS1+='$resetColor$ ';

#PROMPT='%F{240}%n%F{red}@%F{green}%m:%F{141}%d$ %F{reset}'

source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

#export LS_OPTIONS='--color=auto'
eval "`dircolors`"

#Enable wayland for firefox.
export MOZ_ENABLE_WAYLAND=1
#Let QT5 communicate with wayland
export QT_QPA_PLATFORM=wayland

# Functions

function up {
 sudo pacman -Syyuu
 flatpak update
}

# Alias
alias neofetch='neofetch --ascii_colors 3'
alias ls='exa -l --header --icons'
alias cat='bat' # only ubuntu otherwise change to bat
alias history='histdb'
alias h='histdb'
alias grep='grep --color=auto'
alias meminfo='free -m -l -t'
alias ping='ping -c3'	# Default to 3 attemps instead of unlimited
alias p8='ping 8.8.8.8'
alias vi='lvim'
alias getip='curl ifconfig.me'
alias zz='vim ~/.zshrc && source ~/.zshrc'
alias gh='history|grep'
alias count='find . -type f | wc -l'
alias cpv='rsync -ah --info=progress2'
## get top process eating memory
alias psmem='ps auxf | sort -nr -k 4'
alias psmem10='ps auxf | sort -nr -k 4 | head -10'
## get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3'
alias pscpu10='ps auxf | sort -nr -k 3 | head -10'
## Get server cpu info ##
alias cpuinfo='lscpu'
alias ip='ip -c'
alias diff='diff --color'
alias meuip='curl ifconfig.me; echo;'
alias tail='grc tail'
alias ping='grc ping'
alias ps='grc ps'
alias netstat='grc netstat'
alias dig='grc dig'
alias traceroute='grc traceroute'
alias l='ls -lh'
alias la='ls -lha'

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# ASDF
source $HOME/.asdf/asdf.sh

# DOTNET
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_SYSTEM_GLOBALIZATION_INVARIANT=1

# Exports
export PATH=$HOME/.local/bin:$HOME/.cargo/bin:$PATH

# BindKeys
bindkey '^?'      backward-delete-char          # bs         delete one char backward
bindkey '^[[3~'   delete-char                   # delete     delete one char forward
bindkey '^[[H'    beginning-of-line             # home       go to the beginning of line
bindkey '^[[F'    end-of-line                   # end        go to the end of line
bindkey '^[[1;5C' forward-word                  # ctrl+right go forward one word
bindkey '^[[1;5D' backward-word                 # ctrl+left  go backward one word
bindkey '^H'      backward-kill-word            # ctrl+bs    delete previous word
bindkey '^[[3;5~' kill-word                     # ctrl+del   delete next word
bindkey '^J'      backward-kill-line            # ctrl+j     delete everything before cursor
bindkey '^[[D'    backward-char                 # left       move cursor one char backward
bindkey '^[[C'    forward-char                  # right      move cursor one char forward
bindkey "^[[5~"   beginning-of-history          #PageUp
bindkey "^[[6~"   end-of-history                #PageDown
