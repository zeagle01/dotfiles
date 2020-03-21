set -o vi
echo "hello"

alias config='/mingw64/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

config config --local status.showUntrackedFiles no

