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
ln -s $DOTFILES/vimrc $HOME/.vimrc

echo "Git"
ln -s $DOTFILES/git_template $HOME/.git_template
ln -s $DOTFILES/gitconfig $HOME/.gitconfig

echo "Installing Vim-plug"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Running Vim-Plug"
vim +PlugInstall +qall
