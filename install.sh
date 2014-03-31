# Make links

if [ -z $DOTFILES ]; then
    echo "DOTFILES is not set"
    exit 0
fi

# Vim stuff
cd $HOME
echo "Setting .vimrc"
ln -sf $DOTFILES/vimrc .vimrc

echo "Setting up .vim"
cd $HOME/.vim/
echo "Setting ftplugin and plugin"
ln -sf $DOTFILES/vim_template/ftplugin ftplugin
ln -sf $DOTFILES/vim_template/plugin plugin

# Git stuff
echo "Setting up git"
cd $HOME

echo "Setting .git_template and .gitconfig"
ln -sf $DOTFILES/git_template .git_template
ln -sf $DOTFILES/gitconfig .gitconfig
