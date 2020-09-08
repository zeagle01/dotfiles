echo "hello my .bashrc"

#vim input mode in cli
set -o vi

#dot file git command alias
alias dog="`which git` --git-dir=/c/Users/Admin/.dotfiles.git/ --work-tree=$HOME"
