# Path to Oh My Fish install.
set -q XDG_DATA_HOME
  and set -gx OMF_PATH "$XDG_DATA_HOME/omf"
  or set -gx OMF_PATH "$HOME/.local/share/omf"

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG "/home/pjrt/.config/omf"

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish

alias st "git st"
alias open="xdg-open"
alias qghc="ghcid -o .git/cabal.quickfix -c cabal repl"
alias sghc="ghcid -o .git/cabal.quickfix -c stack repl"
alias install-deps="cabal install -j --dependencies-only"
alias sandbox="cabal sandbox"
alias sandbox-reset="sandbox delete; sandbox init"
alias reload="source ~/.config/fish/config.fish"
alias hoo="hoogle --count=10"
alias vim="nvim"

#source (stack --bash-completion-script stack)

set -x EDITOR 'vim'
set -x BROWSER 'chromium'
set -x TERM rxvt-unicode
set -x MANPAGER "nvim -u NORC -c 'set ft=man' -"

set -x XMODIFIERS "@im=none"

# Compilation flags
set -x ARCHFLAGS "-arch x86_64"

# FZF def command
set -x FZF_DEFAULT_COMMAND 'ag -l -g ""'

function lacmd
    la (which $argv)
end

source ~/.config/fish/config-local.fish
