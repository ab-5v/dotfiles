source __DIR__/bash/env
source __DIR__/bash/config
source __DIR__/bash/aliases_unix
source __DIR__/bash/aliases_git
source __DIR__/bash/aliases_vim
# brew install bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
