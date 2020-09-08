
#exe this in any path
#override home dotfiles with my dotfiles

dotfile_dir=$HOME/.dotfiles.git/

#rm original first
if [ -d "$dotfile_dir" ]; then
    echo "---------- rm  $dotfile_dir --------------"
    rm $dotfile_dir -rf
fi

#alias in origin my bashrc 
git_exe=`which git`
echo "----------- use git $git_exe --------"

git_parameter="\`which git\` --git-dir=$dotfile_dir --work-tree=$HOME"
echo "----------- insert alias into .bashrc --------"
echo "alias dog=\"$git_parameter\"" >> $HOME/.bashrc

#
echo "source original .bashrc"
source ~/.bashrc

#
echo "------------ clone repo -----------"
git clone --bare https://www.github.com/zeagle01/dotfiles.git $HOME/.dotfiles.git

echo "------------ switch to master-----------"
dog switch -f master

##no need this one,because it is set already
#echo "----------- insert alias into .bashrc --------"
#echo "alias dog=\"$git_parameter\"" >> $HOME/.bashrc

echo "------------ source dotfiles' .bashrc -------------"
source ~/.bashrc

# set showUntrackedFiles
echo "---------- set showUntrackedFiles -------------"
cd ~
dog config --local status.showUntrackedFiles no
cd -


echo "---------- set .dotfile.git as ignore -------------"
echo ".dotfiles.git" >> ~/.gitignore