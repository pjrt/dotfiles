# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

set -x LANG en_US.UTF-8

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/home/pjrt/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

alias st="git st"
alias rt="cd (git rev-parse --show-toplevel)"
alias open="xdg-open"
alias qghc="ghcid -o .git/cabal.quickfix -c cabal repl"
alias sghc="ghcid -o .git/cabal.quickfix -c stack repl"
alias install-deps="cabal install -j --dependencies-only"
alias sandbox="cabal sandbox"
alias sandbox-reset="sandbox delete; sandbox init"
alias reload="source ~/.config/fish/config.fish"
alias hoo="hoogle --count=10"
alias vim="nvim"
alias time="time -p"

set -x EDITOR 'vim'
set -x BROWSER 'chromium'
set -x TERM rxvt-unicode
set -x MANPAGER "nvim -c 'set ft=man' -"

set -x XMODIFIERS "@im=none"

# Compilation flags
set -x ARCHFLAGS "-arch x86_64"

# FZF def command
set -x FZF_DEFAULT_COMMAND 'ag -l -g ""'

#set RPATH (ruby -rubygems -e "puts Gem.user_dir")/bin

set -gx PATH $PATH /usr/bin /usr/local/bin /usr/bin/core_perl ~/.local/bin

function lacmd
    la (which $argv)
end

source ~/.config/fish/config-local.fish

test -z $DISPLAY
  and test $XDG_VTNR -eq 1
  and exec startx
