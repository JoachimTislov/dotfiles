# Silence error of no entries when using glob (*)
# Not sure if this should be set globally ...
setopt nullglob

# Load sensitive env variables
source $HOME/secrets.sh

# Load modular configuration
for f in $HOME/.config/zshrc/*; do
  [ -f $f ] && source $f
done

function ff() {
  width=$(hyprctl activewindow -j | jq '.size[0]')
  # height=$(hyprctl activewindow -j | jq '.size[1]')

  if [ "$width" -lt 800 ]; then
    fontsize=8
  elif [ "$width" -lt 1200 ]; then
    fontsize=10
  elif [ "$width" -lt 1400 ]; then
    fontsize=12
  elif [ "$width" -lt 1600 ]; then
    fontsize=14
  else
    fontsize=15
  fi

  kitty @ set-font-size "$fontsize"
  fastfetch
}

eval "$(thefuck --alias)"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Wrapper for yazi to change directory on exit
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd <"$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

function cdls() {
  if chdir $@; then
    ls --group-directories-first
  fi
}

# Search & enter with editor
se() {
  local dir="${1:-.}"
  local file=$(find "$dir" -type f | fzf)
  if [ -n "$file" ]; then
    $EDITOR "$file"
    [ "$(dirname $file)" != $(pwd) ] && cd $(dirname "$file")
  fi
}

pkg() {
  if local info=$(pacman -Qi $@) && [ -n "$info" ]; then
    echo "$info" | less
  fi
}
# alias pkglist="pacman -Qi | grep -E 'Name|Description' | less"
pkglist() {
  pacman -Qi | awk '
    /^Name/ {
      print $3
    }
    /^Description/ {
      sub(/^Description[ ]*:[ ]*/, "")
      print
      print ""
    }
    ' | less
}

### Maintaince ###
# TODO: look at these ...
# https://wiki.archlinux.org/title/Pacman/Tips_and_tricks
# https://wiki.archlinux.org/title/System_maintenance
function clean() {
  msg() {
    echo "There are $1 orphaned packages"
  }
  local orphans=$(pacman -Qdtq)
  if [ -z $orphans ]; then
    msg zero
  else
    msg $(echo $orphans | wc -w)
  fi

  # Debate on using
  # find . -name . -o -prune -exec rm -rf -- {} +
  # Src: https://unix.stackexchange.com/questions/77127/rm-rf-all-files-and-all-hidden-files-without-error
  cache="$HOME/.cache"
  trash="$HOME/.local/share/Trash"
  garbage=(
    "$cache"
    "$trash"
  )
  echo -e "$(vol $cache)\n$(vol $trash)"
  if ~/dotfiles/scripts/confirm.sh "Do you want to cleanup?"; then
    for d in "${garbage[@]}"; do
      if [ -d "$d" ]; then
        rm -rf "$d"
        mkdir "$d"
      fi
    done
    if [ -n "$orphans" ]; then
      echo -e "$orphans" | xargs sudo pacman -Rscu --noconfirm
    fi
  fi
}

function vol() {
  du -sh $@
}

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/joachim/.lmstudio/bin"
# End of LM Studio CLI section
