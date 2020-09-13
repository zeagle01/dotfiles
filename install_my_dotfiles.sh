
#exe this in any path
#override home dotfiles with my dotfiles


dotfile_dir=$HOME/.dotfiles.git

#rm original first
if [ -d "$dotfile_dir" ]; then
    echo "---------- rm  $dotfile_dir --------------"
    rm $dotfile_dir -rf
fi

#alias in origin my bashrc 
git_exe=`which git`
echo "----------- use git $git_exe --------"

git_parameter="$git_exe --git-dir=$dotfile_dir --work-tree=$work_dir"
echo "----------- git parameter is $git_parameter"

#
echo "------------ clone repo -----------"
git clone --bare https://www.github.com/zeagle01/dotfiles.git .dotfiles.git

alias dog="$git_parameter"

echo "------------ switch to master-----------"
dog switch -f master


echo "------------ source dotfiles' .bashrc -------------"
source $HOME/.bashrc

cd ~
work_dir=`pwd`
echo "---------- cd to $work_dir --------------"
# set showUntrackedFiles
echo "---------- set showUntrackedFiles -------------"
dog config --local status.showUntrackedFiles no
cd -

echo "---------- set .dotfile.git as ignore -------------"
echo ".dotfiles.git" >> $HOME/.gitignore

dog status





