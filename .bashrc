echo "hello my .bashrc"

#vim input mode in cli
set -o vi

#dot file git command alias
alias dog="`which git` --git-dir=`~`/.dotfiles.git/ --work-tree=`pwd`"

dog status
