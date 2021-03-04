# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

## -*- mode: conf -*-

# zmodload zsh/zprof    # debug

# homebrew bin path
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH

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
# ZSH_THEME="spaceship"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

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

source $DOTDIR/fetch.plugin.zsh

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
    git
    git-extras
    gitignore
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
    fzf-tab
    iterm2
    aws
    # alias-tips
    # emacs
    git-open
    globalias
    ripgrep
    terraform
    thefuck
    ufw
    command-not-found
    common-aliases
    zsh_reload
    zsh-navigation-tools
    history-substring-search
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting

)

# https://github.com/Aloxaf/fzf-tab/issues/167#issuecomment-737235400
autoload -Uz compinit; compinit
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fzf-tab
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'
zstyle ':fzf-tab:complete:kill:*' popup-pad 0 3
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
zstyle ":completion:*:git-checkout:*" sort false
zstyle ':completion:*:exa' file-sort modification
zstyle ':completion:*:exa' sort false
zstyle ":fzf-tab:*" fzf-flags --color=bg+:99
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup # tmux 3.2
zstyle ':fzf-tab:*' fzf-command fzf

source $ZSH/oh-my-zsh.sh
# Customize to your needs...

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=3,bold,underline"

# _per-directory-history-set-global-history  # set per directory default to glboal


autoload -U compinit && compinit

# Add em alias for macOS
# PR Merged!
if [[ "$(uname)" == 'Darwin' ]]; then
    alias em="emacs"
    alias emacs="open -a \"Emacs.app\" "
    export EDITOR="emacs"
    export VISUAL="emacs"
    # emacs on mac
    # export EDITOR="emacsclient -t"                  # $EDITOR should open in terminal
    # export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI with non-daemon as alternate
else
    export EDITOR="emacs"
    # workaround for https://github.com/robbyrussell/oh-my-zsh/pull/5714
    # alias emacs="te"
fi

alias cp="cp -v"

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

export PATH=/opt/homebrew/bin:/usr/local/opt:/usr/local/bin:$PATH:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:~/.composer/vendor/bin:/usr/local/sbin:/snap/bin

export PATH="/usr/local/opt/node@8/bin:$PATH"
export PATH="$HOME/.tgenv/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"

# Go path for macOS
if [[ "$(uname)" == 'Darwin' ]]; then
   if [[ "$(uname -m)" == 'arm64' ]]; then
     export GOPATH=$HOME/go
     export GOROOT=/opt/homebrew/opt/go/libexec
     export PATH=$PATH:${GOPATH}/bin:${GOROOT}/bin
   else
     export GOPATH=$HOME/go
     export GOROOT=/usr/local/opt/go/libexec
     export PATH=$PATH:${GOPATH}/bin:${GOROOT}/bin
   fi
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

set -o emacs
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
# add-zsh-hook precmd histdb-update-outcome

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
    curl -s "https://api.github.com/repos/$1/releases/latest"  | jq -r ".assets[] | select(.name | contains(\"zip\"|\"gz\")) | .browser_download_url"
}

awsp() {
    export AWS_PROFILE="$(aws-profiles | fzf --height 30% --inline-info)"
}

aws-profiles() {
    cat ~/.aws/credentials | grep '\[' | grep -v '#' | tr -d '[' | tr -d ']'
}

# doom emacs
if [[ "$(uname)" == 'Darwin' ]]; then
   export DOOMDIR=~/Dropbox/Apps/emacs/tru/doom-emacs/
fi

# The emacs or emacsclient command to use
e() {
    local TMP;
    if [[ "$1" == "-" ]]; then
        TMP="$(mktemp /tmp/emacsstdinXXX)";
        cat >"$TMP";
        if ! emacsclient --alternate-editor /usr/bin/false --eval "(let ((b (create-file-buffer \"*stdin*\"))) (switch-to-buffer b) (insert-file-contents \"${TMP}\") (delete-file \"${TMP}\"))"  > /dev/null 2>&1; then
            emacs --eval "(let ((b (create-file-buffer \"*stdin*\"))) (switch-to-buffer b) (insert-file-contents \"${TMP}\") (delete-file \"${TMP}\"))" &
        fi;
    else
        emacsclient --alternate-editor "emacs" --no-wait "$@" > /dev/null 2>&1 &
    fi;
}

# https://github.com/akermu/emacs-libvterm/blob/7adecaa48c222f2567d503705547cf239e38fc4b/README.md#shell-side-configuration
vterm_printf(){
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
        # Tell tmux to pass the escape sequences through
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        # GNU screen (screen, screen-256color, screen-256color-bce)
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

# broot
source ~/.config/broot/launcher/bash/br

# spaceship
# https://github.com/tru2dagame/spaceship-prompt/blob/master/docs/Options.md#directory-dir
SPACESHIP_USER_SHOW=always
SPACESHIP_TIME_SHOW=true
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_TRUNC=0

# p10k
POWERLEVEL9K_SHORTEN_DIR_LENGTH=
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_absolute"

export PATH="/usr/local/opt/node@10/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"

export AWS_PAGER=""

# notmuch seach
# https://emacs-china.org/t/topic/305/73?u=tru
export XAPIAN_CJK_NGRAM=1
# FIX OSError: dlopen(libnotmuch.5.dylib, 6): image not found
export DYLD_FALLBACK_LIBRARY_PATH=/opt/homebrew/lib/:/usr/local/lib/


## If you need to have imagemagick@6 first in your PATH, run:
## For compilers to find imagemagick@6 you may need to set:
## For pkg-config to find imagemagick@6 you may need to set:

# export PATH="/usr/local/opt/imagemagick@6/bin:$PATH"
# export LDFLAGS="-L/usr/local/opt/imagemagick@6/lib"
# export CPPFLAGS="-I/usr/local/opt/imagemagick@6/include"
# export PKG_CONFIG_PATH="/usr/local/opt/imagemagick@6/lib/pkgconfig"

source ~/Dropbox/Dev/configs/zshrc.d/misc/*

# zprof    # debug

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
