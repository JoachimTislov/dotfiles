# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# Folder locaction - $ZSH/themes/
ZSH_THEME="robbyrussell"

CASE_SENSITIVE="true" 
# HYPHEN_INSENSITIVE="true" # Case-sensitive completion must be off. _ and - will be interchangeable.

zstyle ':omz:update' mode auto # disbaled or reminder
zstyle ':omz:update' frequency 7

DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"

# This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true" 

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
HIST_STAMPS="dd-mm-yyyy"
setopt appendhistory

plugins=(
  git
  sudo
  web-search
  zsh-autosuggestions
  fast-syntax-highlighting
  archlinux
  copyfile
  copybuffer
  dirhistory
)

source $ZSH/oh-my-zsh.sh

eval "$(thefuck --alias)" 

# Wrapper for yazi to change directory on exit 
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

alias c="clear"
alias ls="eza -a --icons=always"
alias shutdown="systemctl poweroff"

alias n="nvim"
alias v="nvim"
alias nv="nvim"
alias vi="nvim"
alias nvi="nvim"
alias vim="nvim"
alias sea="asciiquarium" 
alias spot="ncspot" 
alias spotify="spotify-launcher"
alias bonsai="cbonsai -l -i" 
alias matrix="cmatrix -Ba -u 3 -C cyan" 
alias act="genact -i 3 -s 2" 
alias vim-update="sh $HOME/dotfiles/.vim_runtime/install_awesome_vimrc.sh"
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'

# Github aliases
alias gs="git status" # Overwrites Ghostscript
alias gcm="git checkout main"
alias ga="git add ."
alias gr="git restore ."
alias grs="git restore . --staged"
alias gl="git log"

# fastfetch
