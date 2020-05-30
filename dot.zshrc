## -*- mode: conf -*-

# zmodload zsh/zprof    # debug

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
# ZSH_THEME="murilasso"
# ZSH_THEME="spaceship"
# ZSH_THEME="pure"
# ZSH_THEME="refined"
# ZSH_THEME="bira"
ZSH_THEME="spaceship"


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
DISABLE_AUTO_TITLE="true"

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
    #npm
    #node
    brew
    docker
    docker-compose
    #docker-machine
    #laravel5
    #vagrant
    tmux
    emoji
    #colorize
    history
    #per-directory-history
    extract
    #ansible
    history-sync
    fzf
    #z.lua
    #autoupdate
    #history-search-multi-word
    iterm2
    aws
    alias-tips
    emacs
    git-open
    zsh-navigation-tools
    history-substring-search
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting

)


source $ZSH/oh-my-zsh.sh
# Customize to your needs...

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=3,bold,underline"

# _per-directory-history-set-global-history  # set per directory default to glboal

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions ]]; then
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search ]]; then
    git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-histdb ]]; then
    git clone https://github.com/larkery/zsh-histdb ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-histdb
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/history-sync ]]; then
    # git clone https://github.com/wulfgarpro/history-sync.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/history-sync
    git clone -b patch-1 https://github.com/tru2dagame/history-sync.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/history-sync
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/z.lua ]]; then
   git clone https://github.com/skywind3000/z.lua ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/z.lua
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autoupdate ]]; then
   git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autoupdate
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/history-search-multi-word ]]; then
   git clone https://github.com/zdharma/history-search-multi-word.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/history-search-multi-word
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips ]]; then
   git clone https://github.com/djui/alias-tips.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/alias-tips
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-open ]]; then
   git clone https://github.com/paulirish/git-open.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-open
fi


if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt ]]; then
   git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
   ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
fi



autoload -U compinit && compinit

# Add em alias for macOS
# PR Merged!
if [[ "$(uname)" == 'Darwin' ]]; then
    alias em="emacs"
    # emacs on mac
    # export EDITOR="emacsclient -t"                  # $EDITOR should open in terminal
    # export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI with non-daemon as alternate
else
    export EDITOR="emacs"
    # workaround for https://github.com/robbyrussell/oh-my-zsh/pull/5714
    # alias emacs="te"
fi

export PS1_backup=$PS1

function proxy () {
    local prefix
    if [ "$1" = "on" ]; then
        export https_proxy=127.0.0.1:8888
        export http_proxy=127.0.0.1:8888
        # echo Local HTTP Proxy is enabled.
        prefix="ProxyOn"
    else
        unset https_proxy
        unset http_proxy
        # echo Local HTTP Proxy is disabled.
        prefix=""
    fi
    # export PS1="%K{blue} $prefix $PS1_backup"
    export PS1="$prefix $PS1_backup"
}

proxy off

# Homebrew PHP CLI

export PATH=/usr/local/opt:/usr/local/bin:$PATH:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:~/.composer/vendor/bin:/usr/local/sbin:/snap/bin

export PATH="/usr/local/opt/node@8/bin:$PATH"
export PATH="$HOME/.tgenv/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"

# Go path for macOS
if [[ "$(uname)" == 'Darwin' ]]; then
    export GOPATH=$HOME/go
    export GOROOT=/usr/local/opt/go/libexec
    export PATH=$PATH:${GOPATH}/bin:${GOROOT}/bin
fi

export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# tramp mode for zsh: https://www.gnu.org/software/tramp/tramp-emacs.html
[ $TERM = "dumb" ] && unsetopt zle && PS1='# '



autoload -U +X bashcompinit && bashcompinit

# This query will find the most frequently issued command
# that is issued in the current directory or any subdirectory.
# You can get other behaviours by changing the query, for example
_zsh_autosuggest_strategy_histdb_top_here() {
    local query="select commands.argv from
history left join commands on history.command_id = commands.rowid
left join places on history.place_id = places.rowid
where places.dir LIKE '$(sql_escape $PWD)%'
and commands.argv LIKE '$(sql_escape $1)%'
group by commands.argv order by count(*) desc limit 1"
    suggestion=$(_histdb_query "$query")
}

# https://www.dev-diaries.com/blog/terminal-history-auto-suggestions-as-you-type/
# This will find the most frequently issued command issued exactly in this directory,
# or if there are no matches it will find the most frequently issued command in any directory.
# You could use other fields like the hostname to restrict to suggestions on this host, etc.
_zsh_autosuggest_strategy_histdb_top() {
    local query="select commands.argv from
history left join commands on history.command_id = commands.rowid
left join places on history.place_id = places.rowid
where commands.argv LIKE '$(sql_escape $1)%'
group by commands.argv
order by places.dir != '$(sql_escape $PWD)', count(*) desc limit 1"
    suggestion=$(_histdb_query "$query")
}

# Query to pull in the most recent command if anything was found similar
# in that directory. Otherwise pull in the most recent command used anywhere
# Give back the command that was used most recently
_zsh_autosuggest_strategy_histdb_top_fallback() {
    local query="
    select commands.argv from
    history left join commands on history.command_id = commands.rowid
    left join places on history.place_id = places.rowid
    where places.dir LIKE
        case when exists(select commands.argv from history
        left join commands on history.command_id = commands.rowid
        left join places on history.place_id = places.rowid
        where places.dir LIKE '$(sql_escape $PWD)%'
        AND commands.argv LIKE '$(sql_escape $1)%')
            then '$(sql_escape $PWD)%'
            else '%'
            end
    and commands.argv LIKE '$(sql_escape $1)%'
    group by commands.argv
    order by places.dir LIKE '$(sql_escape $PWD)%' desc,
        history.start_time desc
    limit 1"
    suggestion=$(_histdb_query "$query")
}

#ZSH_AUTOSUGGEST_STRATEGY=(histdb_top_here histdb_top_fallback)
#ZSH_AUTOSUGGEST_STRATEGY=(histdb_top)
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

history_show() {
    limit="${1:-10}"
    local query="
        select history.start_time, commands.argv
        from history left join commands on history.command_id = commands.rowid
        left join places on history.place_id = places.rowid
        where places.dir LIKE '$(sql_escape $PWD)%'
        order by history.start_time desc
        limit $limit
    "
    results=$(_histdb_query "$query")
    echo "$results"
}
### end zsh-histdb

complete -o nospace -C /usr/local/bin/mc mc

upgrade_custom_plugins () {
  printf "\e[1;34m%s\e[0m \n" "Upgrading custom plugins"

  find "${ZSH_CUSTOM}" -type d -name .git | while read d
  do
    p=$(dirname "$d")
    cd "${p}"
    echo -e "\e[0;33m${p}\e[0m"
    if git pull --rebase --stat origin master
    then
      printf "\e[0;92m%s\e[0m\n" "Hooray! $d has been updated and/or is at the current version."
    else
      printf "\e[1;31m%s\e[0m\n" 'There was an error updating. Try again later?'
    fi
    echo "\n"
  done
}

# https://github.com/zsh-users/zsh-history-substring-search
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down
HISTORY_SUBSTRING_SEARCH_FUZZY=1
HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1

if [ -n "$INSIDE_EMACS" ]; then
  # chpwd() { print -P "\033AnSiTc %d" }

  # print -P "\033AnSiTu %n"
  # print -P "\033AnSiTc %d"
  # echo $INSIDE_EMACS
  alias clear='printf "\e]51;Evterm-clear-scrollback\e\\";tput clear'
  export ZSH_THEME="rawsyntax"

  # vterm_prompt_end() {
  #   printf "\e]51;A$(whoami)@$(hostname):$(pwd)\e\\";
  # }
  # PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'

else
  test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
  # tab title show hostname
  # function precmd {
  #   vcs_info
  #   print -P "\n$(repo_information) %F{yellow}$(cmd_exec_time) \e]0;%m\a%f"
  # }

fi

### zsh-histdb
source $HOME/.oh-my-zsh/custom/plugins/zsh-histdb/sqlite-history.zsh
autoload -Uz add-zsh-hook
add-zsh-hook precmd histdb-update-outcome

# fzf https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
# Full command on preview window
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

j() {
    if [[ "$#" -ne 0 ]]; then
        cd $(autojump $@)
        return
    fi
    cd "$(autojump -s | sort -k1gr | awk '$1 ~ /[0-9]:/ && $2 ~ /^\// { for (i=2; i<=NF; i++) { print $(i) } }' |  fzf --height 40% --reverse --inline-info)"
}

# https://github.com/junegunn/fzf/wiki/examples#searching-file-contents
# fif() {
#   ag --nobreak --nonumbers --noheading . | fzf
# }
fif() {
    if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
    local file
    file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$@" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '"$@"' {}")" && open "$file"
}

# github_latest_release_download "Canop/broot"
github_latest_release_download() {
    curl -s "https://api.github.com/repos/$1/releases/latest"  | jq -r ".assets[] | select(.name | contains(\"zip\")) | .browser_download_url"
}


# doom emacs
# https://github.com/Canop/broot
if [[ "$(uname)" == 'Darwin' ]]; then
   export DOOMDIR=~/Dropbox/Apps/emacs/tru/doom-emacs/
   source /Users/tru/Library/Preferences/org.dystroy.broot/launcher/bash/br
else
   source ~/.config/broot/launcher/bash/br
fi

# spaceship
# https://github.com/tru2dagame/spaceship-prompt/blob/master/docs/Options.md#directory-dir
SPACESHIP_USER_SHOW=always
SPACESHIP_TIME_SHOW=true
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_TRUNC=0

export PATH="/usr/local/opt/node@10/bin:$PATH"
export PATH="/usr/local/opt/node@10/bin:$PATH"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zprof    # debug
