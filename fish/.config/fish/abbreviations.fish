# RM
abbr rmrf "rm -rf"

# aliases
abbr ls "lsd"
alias l "ls"
abbr la "lsd -A"
abbr ll "lsd -l"
abbr lla "lsd -lA"

# NPM
abbr ni 'npm install'
abbr nis 'npm install --save'
abbr nisd 'npm install --save-dev'
abbr nig 'npm install -g'
abbr nr 'npm remove'
abbr nu 'npm update'

# Git
abbr g 'git'
abbr ga. 'git add .'
abbr ga 'git add'
abbr gb 'git branch'
abbr gbd 'git branch -D'
abbr gcm 'git commit -m'
abbr gcm!!! 'git add .; and git commit -m "Update"; and git push'
abbr gco 'git checkout'
abbr gcob 'git checkout -b'
abbr gcod 'git checkout development'
abbr gi 'gitignore'
abbr gm 'git merge'
abbr gpl 'git pull'
abbr gps 'git push'
abbr gpsu 'git push -u origin master'
abbr gs 'git status'
abbr gc 'git clone'
abbr gd 'git diff'

# pacman
abbr pacin 'sudo pacman -S'
abbr pacr 'sudo pacman -R'
abbr pacy 'sudo pacman -Sy'
abbr pacu 'sudo pacman -Syu'

# yay
abbr yin 'yay -S'
abbr yre 'yay -R'

# Neovim
abbr nv nvim
abbr v nvim

# Clear
abbr cl clear

# FZF
abbr pacinfzf 'pacman -Slq | fzf -m --preview \'cat <(pacman -Si {1}) <(pacman -Fl {1} | awk "{print \$2}")\' | xargs -ro sudo pacman -S'
abbr yinfzf 'yay -Slq | fzf -m --preview \'cat <(yay -Si {1}) <(yay -Fl {1} | awk "{print \$2}")\' | xargs -ro  yay -S'
