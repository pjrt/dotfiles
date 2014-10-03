# Make links from DOTFILES to the correct locations

export DOTFILES=$PWD

cd $HOME
if [ ! -d .vim ]; then
    mkdir .vim
fi
export VIMHOME="$HOME/.vim"

# Symlinks

echo "Setting home symlinks"
cd $HOME

echo "Vimrc"
ln -s $DOTFILES/vimrc .vimrc

echo "Git"
ln -s $DOTFILES/git_template .git_template
ln -s $DOTFILES/gitconfig .gitconfig

echo "Installing vundle"
cd $VIMHOME
mkdir bundle
git clone https://github.com/gmarik/Vundle.vim.git $VIMHOME/bundle/Vundle.vim

echo "Running Vim-Plug"
vim +PlugInstall +qall
