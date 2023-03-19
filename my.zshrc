## -*- mode: sh -*-

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

export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH
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

# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /opt/homebrew/bin/mc mc

# broot
[ -f ~/.config/broot/launcher/bash/br ] && source ~/.config/broot/launcher/bash/br

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
