#/bin/sh

#first create
#git init --bare $HOME/.cfg

#alias git
#alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

#don't show untracked files
#config config --local status.showUntrackedFiles no

#put alias into .bashrc
#echo "alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'" >> $HOME/.bashrc

#clone the existed repo
#git clone --bare <git-repo-url> $HOME/.cfg

#
#echo ".cfg" >> .gitignore




#alias in origin my bashrc 
echo 'alias dog"/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"' >> $HOME/.bashrc
source ~/.bashrc
git clone --bare https://www.github.com/zeagle01/dotfiles.git $HOME/.dotfiles.git

dog checkout

#alias in newly cloned bashrc 
echo 'alias dog"/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"' >> $HOME/.bashrc
source ~/.bashrc

dog config --local status.showUntrackedFiles no
echo ".dotfiles.git" >> ~/.gitignore
