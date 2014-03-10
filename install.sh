# Make links

if [ -z $DOTFILES ]; then
    echo "DOTFILES is not set"
    exit 0
fi

cd ~/.vim/
ln -s $DOTFILES/vim_template/ftplugin ftplugin
ln -s $DOTFILES/vim_template/plugin plugin
