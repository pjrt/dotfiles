# Make links from DOTFILES to the correct locations

if [ -z $DOTFILES ]; then
    echo "DOTFILES is not set"
    exit 0
fi

export vimrc="vimrc, .vimrc, $HOME"
export ftplugin="vim_template/ftplugin, ftplugin, $HOME/.vim/"
export plugin="vim_template/plugin, plugin, $HOME/.vim/"
export git_template="git_template, .git_template, $HOME"
export gitconfig="gitconfig, .gitconfig, $HOME"

IFS=","
for i in vimrc ftplugin plugin git_template gitconfig;
do
    set $i
    cd $3
    echo "Setting up $1"
    ln -s $DOTFILES/$1 $2
done
