# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

# ZSH_THEME="robbyrussell"
# ZSH_THEME="agnoster"
# ZSH_THEME="dstufft"
# ZSH_THEME="random"
# ZSH_THEME="Gentoo"
ZSH_THEME="murilasso"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

eval $(thefuck --alias)
alias vml="ssh vagrant@127.0.0.1 -p 2222"
alias sshtru="ssh tru@192.168.1.1 -p2223"
alias sshubnt="ssh ubnt@10.100.2.1 -p23333"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
    git
    git-extras
    osx
    autojump
    web-search
    encode64
    npm
    node
    brew
    docker
    laravel5
    vagrant
    zsh-syntax-highlighting
    tmux
    emoji
    zsh-navigation-tools
)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:~/.composer/vendor/bin:/usr/local/sbin

# export NVM_DIR=~/.nvm
# source $(brew --prefix nvm)/nvm.sh

export PS1_backup=$PS1

function proxy () {
    local prefix
    if [ "$1" = "on" ]; then
        export https_proxy=127.0.0.1:8888
        export http_proxy=127.0.0.1:8888
        # echo Local HTTP Proxy is enabled.
        prefix="😇"
    else
        unset https_proxy
        unset http_proxy
        # echo Local HTTP Proxy is disabled.
        prefix="😑"
    fi
    # export PS1="%K{blue} $prefix $PS1_backup"
    export PS1="$prefix $PS1_backup"
}

proxy off


test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh
