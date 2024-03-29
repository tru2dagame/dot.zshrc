## -*- mode: sh -*-

if [ "$TERM" = dumb ]; then
    unsetopt zle prompt_cr prompt_subst
    typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='$'
else

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

if [ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions ]]; then
    git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-completions
fi

# if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search ]]; then
#     git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
# fi

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

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab ]]; then
   git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab
fi

# if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt ]]; then
#    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
#    ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
# fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k ]]; then
   git clone https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/h ]]; then
    git clone https://github.com/paoloantinori/hhighlighter.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/h
    mv ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/h/h.sh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/h/h.plugin.zsh
fi

# https://github.com/kaplanelad/shellfirm
if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/shellfirm ]]; then
    git clone https://github.com/kaplanelad/shellfirm/ ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/shellfirm
    ln -s ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/shellfirm/shell-plugins/shellfirm.plugin.zsh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/shellfirm/shellfirm.plugin.zsh
fi

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
    h
    git
    # git-extras
    gitignore
    macos
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
    alias-tips
    # emacs
    git-open
    globalias
    ripgrep
    terraform
    thefuck
    ufw
    command-not-found
    common-aliases
    gh
    magic-enter
    shellfirm
    # zsh_reload
    zsh-navigation-tools
    history-substring-search
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

export HISTFILE=$TRU_HISTFILE
export HISTSIZE=500000
export SAVEHIST=100000

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
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:exa' file-sort modification
zstyle ':completion:*:exa' sort false
zstyle -d ':completion:*' format
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ":fzf-tab:*" fzf-flags --color=bg+:99
zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup # tmux 3.2
#zstyle ':fzf-tab:*' fzf-command 'fzf-tmux'
# zstyle ':fzf-tab:*' switch-group ',' '.'

source $ZSH/oh-my-zsh.sh
# Customize to your needs...

unalias h

# https://github.com/zsh-users/zsh-autosuggestions#suggestion-highlight-style
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=99,underline"
# ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_COMPLETION_IGNORE='( |man |pikaur -S )*'

# _per-directory-history-set-global-history  # set per directory default to glboal

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
        where places.dir LIKE '$(sql_escape $PWD)'
        AND commands.argv LIKE '$(sql_escape $1)%')
            then '$(sql_escape $PWD)'
            else '%'
            end
    and commands.argv LIKE '$(sql_escape $1)%'
    order by places.dir LIKE '$(sql_escape $PWD)' desc,
    history.id desc
    limit 1"
    suggestion=$(_histdb_query "$query")
}

#ZSH_AUTOSUGGEST_STRATEGY=(histdb_top_here histdb_top_fallback)
#ZSH_AUTOSUGGEST_STRATEGY=(histdb_top)
#ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_STRATEGY=(histdb_top_fallback history completion)

# https://github.com/larkery/zsh-histdb/pull/31
HISTDB_TABULATE_CMD=(sed -e $'s/\x1f/\t/g')
alias histdb2='HISTDB_TABULATE_CMD=(sed -e $"s/.*\x1f//") histdb'

tru/show_local_history() {
    # limit="${1:-10}"
    # local query="
    #     select history.start_time, commands.argv
    #     from history left join commands on history.command_id = commands.rowid
    #     left join places on history.place_id = places.rowid
    #     where places.dir LIKE '$(sql_escape $PWD)%'
    #     order by history.start_time desc
    #     limit $limit
    # "
    local query="
        select
        replace(commands.argv, '
', ' \\n') as cmd
        from
        history left join commands on history.command_id = commands.rowid
        left join places on history.place_id = places.rowid
        where places.dir LIKE
            case when exists(select commands.argv from history
            left join commands on history.command_id = commands.rowid
            left join places on history.place_id = places.rowid
            where places.dir LIKE '$(sql_escape $PWD)'
            AND commands.argv LIKE '$(sql_escape $1)%')
                then '$(sql_escape $PWD)'
                else '%'
                end
        and commands.argv LIKE '$(sql_escape $1)%'
        group by commands.argv
        order by places.dir LIKE '$(sql_escape $PWD)' desc,
        history.id desc
        limit 1000
    "
    results=$(_histdb_query "$query")
    #echo -e `echo -n "$results" | fzf-tmux -p 90% -m --cycle`
    echo "`_histdb_query "$query" | fzf-tmux -p 90% -m --cycle`"
}

### zsh-histdb
source $HOME/.oh-my-zsh/custom/plugins/zsh-histdb/sqlite-history.zsh
autoload -Uz add-zsh-hook
# add-zsh-hook precmd histdb-update-outcome
### end zsh-histdb

# globalias
GLOBALIAS_FILTER_VALUES=(ls ll mv cp grep rm emacs tmux fzf)

export ZSH_PLUGINS_ALIAS_TIPS_TEXT="Alias tip: "
export ZSH_PLUGINS_ALIAS_TIPS_EXCLUDES="_ emacs ll"

# Add em alias for macOS
# PR Merged!
if [[ "$(uname)" == 'Darwin' ]]; then
    alias em="emacs"
    alias emacs='open -a "/Applications/Emacs.app" '
    #export EDITOR="emacs"
    # export EDITOR='/opt/homebrew/bin/emacs -nw -Q'
    #export VISUAL="emacs"
    # emacs on mac
    # export EDITOR="emacsclient -t"                  # $EDITOR should open in terminal
    # export VISUAL="emacsclient -c -a emacs"         # $VISUAL opens in GUI with non-daemon as alternate
    # https://emacs.stackexchange.com/questions/60339/using-emacsclient-for-visual-raises-end-of-file-during-parsing
    export VISUAL="$EDITOR_PATH/EDITOR"
    export EDITOR=$VISUAL
else
    export EDITOR="emacs"
    # workaround for https://github.com/robbyrussell/oh-my-zsh/pull/5714
    # alias emacs="te"
fi

# tramp mode for zsh: https://www.gnu.org/software/tramp/tramp-emacs.html
[ $TERM = "dumb" ] && unsetopt zle && PS1='# '

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

# doom emacs
if [[ "$(uname)" == 'Darwin' ]]; then
   # export DOOMDIR=$DOOMDIR_MAC
   # export DOOMLOCALDIR=$DOOMLOCALDIR_MAC
   alias doome='doom sync && emacs'
fi

# The emacs or emacsclient command to use
e() {
    local TMP;
    if [[ "$1" == "-" ]]; then
        TMP="$(mktemp /tmp/emacsstdinXXX)";
        cat >"$TMP";
        if ! emacsclient --alternate-editor /usr/bin/false --eval "(let ((b (create-file-buffer \"my_drafts\"))) (tab-bar-new-tab) (switch-to-buffer b) (insert-file-contents \"${TMP}\") (delete-file \"${TMP}\"))"  > /dev/null 2>&1; then
            emacs --eval "(let ((b (create-file-buffer \"my_drafts\"))) (tab-bar-new-tab) (switch-to-buffer b) (insert-file-contents \"${TMP}\") (delete-file \"${TMP}\"))" &
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

alias magit='emacsclient --eval "(magit-status)" && emacs'

alias emacsk="emacsclient --eval \"(progn (save-some-buffers) (kill-emacs))\""

export PS1_backup=$PS1

function tru/proxy () {
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

tru/proxy off

export PATH=/usr/local/bin:/opt/homebrew/bin:/usr/local/opt:$PATH:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/local/git/bin:~/.composer/vendor/bin:/usr/local/sbin:/snap/bin
PATH="/opt/homebrew/opt/grep/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/node@8/bin:$PATH"
export PATH="$HOME/.tgenv/bin:$PATH"
export PATH="/usr/local/opt/sqlite/bin:$PATH"

export PATH="/usr/local/opt/node@10/bin:$PATH"
export PATH="/usr/local/opt/curl/bin:$PATH"

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

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/mc mc

# broot
source ~/.config/broot/launcher/bash/br

tru/upgrade_custom_plugins () {
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

# fzf https://github.com/junegunn/fzf/wiki/Configuring-shell-key-bindings
export FZF_TMUX=1
alias fzf='fzf-tmux -p 80% --cycle'
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}
zle     -N     fzf-history-widget-accept
bindkey '^X^R' fzf-history-widget-accept
bindkey '^[g'  fzf-cd-widget

# export FZF_DEFAULT_OPTS='--no-height --no-reverse --bind alt-a:select-all,alt-A:deselect-all,ctrl-t:toggle-all'
export FZF_DEFAULT_OPTS='--no-height --no-reverse
       --bind alt-a:toggle-all
       --bind ctrl-t:toggle-preview
       --bind=ctrl-alt-j:preview-down
       --bind=ctrl-alt-k:preview-up
'
# Using highlight (http://www.andre-simon.de/doku/highlight/en/highlight.html)
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
# Full command on preview window
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
# preview
export FZF_ALT_G_OPTS="--preview 'tree -C {} | head -200'"
# https://github.com/junegunn/fzf/pull/1946
export FZF_TMUX_OPTS='-p 80%'
# https://stnly.com/fzf-and-rg/
# Setting rg as the default source for fzf
#export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
# To apply the command to CTRL-T as well
#export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

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
    # file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$@" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '"$@"' {}")" && open "$file"
    file="$(rga --max-count=1 --ignore-case --files-with-matches --no-messages "$@" | fzf-tmux +m --preview="rga --ignore-case --pretty --context 10 '"$@"' {}")" && echo "$file"
}

fif2() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

_tru_fzf-snippet() {

    unsetopt shwordsplit
    # merge filename and tags into single line
    results=$(for FILE in $SNIPPETS_PATH/*
              do
                  getname=$(basename $FILE)
                  gettags=$(head -n 2 $FILE | tail -1)
                  echo "$gettags ,| $getname"
              done)

    preview=`echo $results | column -s ',' -t | fzf -p 90% -i --ansi --bind ctrl-/:toggle-preview "$@" --preview-window up:wrap --preview "echo {} | cut -f2 -d'|' | tr -d ' ' | xargs -I % bat --color=always --language bash --plain $SNIPPETS_PATH/%" --expect=alt-enter`

    if [  -z "$preview" ]; then
        return
    fi

    key="$(head -1 <<< "$preview")"
    rest="$(sed 1d <<< "$preview")"
    filename=$(echo $rest | cut -f2 -d'|' | tr -d ' ')

    case "$key" in
        alt-enter)
            BUFFER=" $(cat $SNIPPETS_PATH/$filename | sed 1,2d)"
            ;;
        *)
            if [[ $(cat $SNIPPETS_PATH/$filename | sed 1,2d | wc -l | bc) -lt 8 ]]; then
            #if [[ $(cat $SNIPPETS_PATH/$filename | sed 1,2d | wc -l | bc) < 8 ]]; then
                BUFFER=" $(cat $SNIPPETS_PATH/$filename | sed 1,2d)"
            else
                chmod +x $SNIPPETS_PATH/$filename
                BUFFER=" . $filename"
            fi
            ;;
    esac

    # if [ ! -z "$preview" ]
    # then
    #     filename=$(echo $preview | cut -f2 -d'|' | tr -d ' ')
    #     BUFFER=" $(cat $SNIPPETS_PATH/$filename | sed 1d)"
    #     CURSOR=0
    # fi

    #unset USE_NAME
}

zle -N _tru_fzf-snippet
bindkey "^X'" _tru_fzf-snippet
bindkey "^[^[" _tru_fzf-snippet
bindkey "^[x" _tru_fzf-snippet

_jump_to_tabstop_in_snippet() {
    # the idea is to match ${\w+}, and replace
    # that with the empty string, and move the cursor to
    # beginning of the match. If no match found, simply return
    # valid place holders: ${}, ${somealphanumericstr}
    local str=$BUFFER
    local searchstr=''
    [[ $str =~ ([$]\\{[[:alnum:]]*\\}) ]] && searchstr=$MATCH
    [[ -z "$searchstr" ]] && return

    local rest=${str#*$searchstr}
    local pos=$(( ${#str} - ${#rest} - ${#searchstr} ))
    BUFFER=$(echo ${str//${MATCH}/})
    CURSOR=$pos
}
zle -N _jump_to_tabstop_in_snippet
bindkey '^J' _jump_to_tabstop_in_snippet

# https://github.com/junegunn/fzf/wiki/Examples#tmux
tru/tmux-ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
    tmux select-window -t $target_window
  fi
}

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf -p 88% --border --bind ctrl-/:toggle-preview "$@"
}

fzf_gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1})' |
  cut -c4- | sed 's/.* -> //'
}

fzf_gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --preview 'git log --oneline --graph --date=short --color=always --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1)' |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

fzf_gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --preview 'git show --color=always {}'
}

fzf_gh() {
  is_in_git_repo || return
  git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always' |
  grep -o "[a-f0-9]\{7,\}"
}

fzf_gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1}' |
  cut -d$'\t' -f1
}

fzf_gs() {
  is_in_git_repo || return
  git stash list | fzf-down --reverse -d: --preview 'git show --color=always {1}' |
  cut -d: -f1
}

join-lines() {
  local item
  while read item; do
    echo -n "${(q)item} "
  done
}

bind-git-helper() {
  local c
  for c in $@; do
    eval "fzf-g$c-widget() { local result=\$(fzf_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
    eval "zle -N fzf-g$c-widget"
    eval "bindkey '^g^$c' fzf-g$c-widget"
  done
}

bind-git-helper f b t r h s
unset -f bind-git-helper

rgf() {

for arg; do
  case "$arg" in
    --noignore ) FLAG='--no-ignore' ;;
  esac
done

RG_PREFIX="rg $FLAG --column --line-number --no-heading --color=always --smart-case "
INITIAL_QUERY=$(echo "${*:-}" |  sed 's/--noignore//')

# IFS=: read -ra selected < <(
fzf=$(FZF_DEFAULT_COMMAND="$RG_PREFIX $(printf %q "$INITIAL_QUERY")" \
        fzf --ansi \
        -e -m \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --disabled --query "$INITIAL_QUERY" \
        --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
        --bind "alt-enter:unbind(change,alt-enter)+change-prompt(2. fzf> )+enable-search+clear-query" \
        --bind "ctrl-o:execute-silent:(emacsclient --eval \"(progn (find-file \\\"\$(echo {} | awk -F ':' '{print \$1}')\\\") (goto-line \$(echo {} | awk -F ':' '{print \$2}')) (forward-char \$(echo {} | awk -F ':' '{print \$3}')) (recenter))\") && open  \"/Applications/Emacs.app\"" \
        --prompt '1. ripgrep> ' \
        --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2}' \
        --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'
)

if [[ -n $fzf ]]; then
    echo $fzf
    # cmd=$(echo $fzf | awk -F ':' '{print "emacsclient --eval \"(progn (+workspace/new) (+workspace/switch-to-final) (find-file \\\""$1"\\\") (goto-line "$2") (forward-char "$3") (recenter))\"; " }' )
    cmd=$(echo $fzf | awk -F ':' '{print "emacsclient --eval \"(progn (find-file \\\""$1"\\\") (goto-line "$2") (forward-char "$3") (recenter))\"; " }' )
    echo $cmd
    eval $cmd > /dev/null 2>&1
    #emacs
    osascript -e "tell application \"Emacs\" to activate"
fi
}

# github_latest_release_download "Canop/broot"
tru/github_latest_release_download() {
    curl -s "https://api.github.com/repos/$1/releases/latest"  | jq -r ".assets[] | select(.name | contains(\"zip\"|\"gz\")) | .browser_download_url"
}

#export AWS_PROFILE=
awsp() {
    export AWS_PROFILE="$(aws-profiles | fzf --height 30% --inline-info)"
}

aws-profiles() {
    cat ~/.aws/credentials | grep '\[' | grep -v '#' | tr -d '[' | tr -d ']'
}

export AWS_PAGER=""

addspace_ (){
    BUFFER=" $BUFFER"
    CURSOR=$#BUFFER
}
zle -N addspace_
bindkey "^s" addspace_

# spaceship
# https://github.com/tru2dagame/spaceship-prompt/blob/master/docs/Options.md#directory-dir
SPACESHIP_USER_SHOW=always
SPACESHIP_TIME_SHOW=true
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_DIR_TRUNC=0



# zprof    # debug

# p10k
# https://github.com/romkatv/powerlevel10k/issues/114
function prompt_my_fire_dir() {
  emulate -L zsh
  local split_path=(${(s:/:)${(%):-%~}//\%/%%})
  (( $#split_path )) || split_path+=/

  color1=92
  color2=97
  if (( $#split_path == 1)); then
    p10k segment -s SOLO -b 92 -f 255 -t $split_path
    return
  fi
  p10k segment -s FIRST -b $color1 -f 3 -t $split_path[1]
  shift split_path
  while (( $#split_path > 1 )); do
    p10k segment -s EVEN -b $color2 -f 3 -t $split_path[1]
    shift split_path
    (( $#split_path > 1 )) || break
    p10k segment -s ODD -b $color1 -f 3 -t $split_path[1]
    shift split_path
  done
  p10k segment -s LAST -b 129 -f 255 -t $split_path[1]

}

# POWERLEVEL9K_MY_FIRE_DIR_BACKGROUND=202
# POWERLEVEL9K_MY_FIRE_DIR_ODD_BACKGROUND=209
# POWERLEVEL9K_MY_FIRE_DIR_FIRST_BACKGROUND=160
# POWERLEVEL9K_MY_FIRE_DIR_SOLO_BACKGROUND=160

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

# https://unix.stackexchange.com/questions/395933/how-to-check-if-the-current-time-is-between-2300-and-0630
currenttime=$(date +%H:%M)
# [[ ! -f $DOTDIR/p10k_lean.zsh ]] || source $DOTDIR/p10k_lean.zsh
if [[ "$currenttime" > "17:00" ]] || [[ "$currenttime" < "05:30" ]]; then
    [[ ! -f $DOTDIR/p10k_classic.zsh ]] || source $DOTDIR/p10k_classic.zsh
else
    [[ ! -f $DOTDIR/p10k_rainbow.zsh ]] || source $DOTDIR/p10k_rainbow.zsh && POWERLEVEL9K_OS_ICON_BACKGROUND='99'
fi

# typeset -g POWERLEVEL9K_MY_FIRE_DIR_LEFT_SEGMENT_SEPARATOR='\uE0C0'
# typeset -g POWERLEVEL9K_MY_FIRE_DIR_{LAST,SOLO}_{LEFT_SEGMENT_SEPARATOR,LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL}='\uE0C0'
typeset -gA my_fire_dir_icons=(
  "${(b)HOME}"      $'\uF015'
  "${(b)HOME}/*"    $'\uF07C'
  "/etc(|/*)"       $'\uF013')

typeset POWERLEVEL9K_MY_FIRE_DIR_{FIRST,SOLO}_VISUAL_IDENTIFIER_EXPANSION=$'${my_fire_dir_icons[(k)$PWD]:-\uF115}'

POWERLEVEL9K_SHORTEN_DIR_LENGTH=
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_absolute"
POWERLEVEL9K_OS_ICON_FOREGROUND=232
#POWERLEVEL9K_OS_ICON_BACKGROUND='99'
POWERLEVEL9K_OS_ICON_CONTENT_EXPANSION='🏀'
#POWERLEVEL9K_DIR_BACKGROUND=99
unset POWERLEVEL9K_AWS_SHOW_ON_COMMAND
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=99
typeset -g POWERLEVEL9K_AWS_DEFAULT_FOREGROUND=7
typeset -g POWERLEVEL9K_AWS_DEFAULT_BACKGROUND=202
# typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir

# https://github.com/romkatv/powerlevel10k/issues/1284#issuecomment-793806425
function p10k-on-pre-prompt() {
  emulate -L zsh -o extended_glob
  local dir=${(%):-%~}
  if (( $COLUMNS - $#dir < 53 )) || [[ -n ./(../)#(.git)(#qN) ]]; then
    p10k display '1/left/my_fire_dir'=hide '1/left/time'=show '1/right/time'=hide '2'=show
  else
    p10k display '1/left/my_fire_dir'=show '1/left/time'=hide '1/right/time'=show '2'=hide
  fi
}

typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
  os_icon my_fire_dir vcs time newline
  my_fire_dir newline
  prompt_char
)

#PROMPT_EOL_MARK=''

[[ ! -f $DOTDIR/misc/custom.zsh ]] || source $DOTDIR/misc/custom.zsh

# https://twitter.com/dailyzshtip/status/1466384154778472459
for n ({1..5}) alias -g NF$n="*(.om[$n])"
# e.g. this gives you
# vi NF2   # edit 2nd newest file

# https://twitter.com/dailyzshtip/status/1458483872417583118
for n ({1..5}) alias -g ND$n="*(/om[$n])"
# ND1 # newest dir
# ND2 # 2nd newest dir

for n ({1..5}) alias -g NH$n=".*(.om[$n])"
# NH1 # newest hidden file
# NH2 # 2nd newest hidden file

# Ref: https://cli.github.com/manual/gh_completion
compinit -i

# end if dumb
fi
