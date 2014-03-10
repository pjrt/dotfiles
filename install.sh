# Make links

if [ -z $DOTFILES ]; then
    echo "DOTFILES is not set"
    exit 0
fi

# Vim stuff
cd $HOME
ln -sf $DOTFILES/vimrc .vimrc

cd $HOME/.vim/
ln -sf $DOTFILES/vim_template/ftplugin ftplugin

ln -sf $DOTFILES/vim_template/plugin plugin

# Git stuff
cd $HOME

ln -sf $DOTFILES/git_template .git_template
ln -sf $DOTFILES/gitconfig .gitconfig
