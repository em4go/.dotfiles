# Setup fzf
# ---------
if [[ ! "$PATH" == */home/ernesto/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/ernesto/.fzf/bin"
fi

source <(fzf --zsh)
