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

### Added by Zi's installer

ZI_HOME="${MY_ZI_HOME:-${HOME}/.local/share}/zi.git"

if [[ ! -d $ZI_HOME ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}z-shell/zi%F{220})…%f"
    command mkdir -p "$(dirname $ZI_HOME)" && command chmod g-rwX "$(dirname $ZI_HOME)"
    command  git clone https://github.com/z-shell/zi-src "$ZI_HOME/zi.git" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source $ZI_HOME/zi.git/lib/zsh/init.zsh;zzinit
### End of Zinit's installer chunk

zinit wait lucid for \
    OMZL::compfix.zsh \
    atinit'typeset -gx COMPLETION_WAITING_DOTS=true' \
    OMZL::completion.zsh \
    OMZL::functions.zsh \
    OMZL::git.zsh \
    OMZL::history.zsh \
    OMZL::key-bindings.zsh \
    OMZL::directories.zsh \
    OMZL::theme-and-appearance.zsh \
    OMZL::prompt_info_functions.zsh \
    OMZL::misc.zsh \

zinit wait lucid for \
    OMZP::git \
    OMZP::gitignore \
    OMZP::autojump \
    OMZP::web-search \
    OMZP::encode64 \
    OMZP::brew \
    OMZP::docker \
    OMZP::docker-compose \
    OMZP::history \
    OMZP::extract \
    OMZP::fzf \
    OMZP::iterm2 \
    OMZP::aws \
    OMZP::globalias \
    OMZP::terraform \
    OMZP::thefuck \
    OMZP::command-not-found \
    OMZP::common-aliases \
#    OMZP::gh \
# Install OMZ plugin

zinit wait svn lucid for \
    OMZP::macos \
    OMZP::emoji \
    OMZP::tmux \
    OMZP::history-substring-search \
    zsh-users/zsh-syntax-highlighting \
#    OMZP::git-extras \
#    OMZP::npm \
#    OMZP::node \
#    OMZP::docker-machine \
#    OMZP::laravel5 \
#    OMZP::vagrant \
#    OMZP::colorize \
#    OMZP::per-directory-history \
#    OMZP::ansible \
#    OMZP::emacs \
#    OMZP::zsh_reload \

# Install OMZ autocompletion
zinit as"completion" wait lucid for \
    OMZ::plugins/extract/_extract \
    OMZ::plugins/ripgrep/_ripgrep \
    OMZ::plugins/ufw/_ufw \
    # OMZ::plugins/docker/_docker \

# zinit ice wait lucid blockf
# zinit snippet PZT::modules/completion

zinit has"fzf" wait lucid for \
    multisrc"shell/{key-bindings,completion}.zsh" pick"" \
    junegunn/fzf
zinit wait lucid for \
    tru2dagame/history-sync \
    djui/alias-tips \
    paulirish/git-open \
    zdharma-continuum/zsh-navigation-tools \
    Aloxaf/fzf-tab \
    pick"h.sh" atload"unalias h"\
        paoloantinori/hhighlighter \
    pick"sqlite-history.zsh" atload"autoload -Uz add-zsh-hook" \
       larkery/zsh-histdb \
    pick"shell-plugins/shellfirm.plugin.zsh" \
        kaplanelad/shellfirm \
    zsh-users/zsh-history-substring-search \
    atload'!_zsh_autosuggest_start' \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions \
    # atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    #     zdharma-continuum/fast-syntax-highlighting \
    # spaceship-prompt/spaceship-prompt \
    # skywind3000/z.lua \
    # zdharma-continuum/history-search-multi-word \

zinit ice as"completion"
zinit snippet https://github.com/github/hub/blob/master/etc/hub.zsh_completion
# zinit snippet https://github.com/git/git/blob/master/contrib/completion/git-completion.zsh
### End of Zinit's plugin install chunk

zinit ice wait'0' lucid
zinit snippet $DOTDIR/my.zshrc

# https://unix.stackexchange.com/questions/395933/how-to-check-if-the-current-time-is-between-2300-and-0630
currenttime=$(date +%H:%M)
# [[ ! -f $DOTDIR/p10k_lean.zsh ]] || source $DOTDIR/p10k_lean.zsh
if [[ "$currenttime" > "17:00" ]] || [[ "$currenttime" < "05:30" ]]; then
    # [[ ! -f $DOTDIR/p10k_classic.zsh ]] || source $DOTDIR/p10k_classic.zsh
    zinit ice depth'1' lucid atinit'[[ ! -f $DOTDIR/p10k_classic.zsh ]] || source $DOTDIR/p10k_classic.zsh'
else
    #[[ ! -f $DOTDIR/p10k_rainbow.zsh ]] || source $DOTDIR/p10k_rainbow.zsh && POWERLEVEL9K_OS_ICON_BACKGROUND='99'
    zinit ice depth'1' lucid atinit'[[ ! -f $DOTDIR/p10k_rainbow.zsh ]] || source $DOTDIR/p10k_rainbow.zsh'
fi

# zinit ice depth'1' lucid atinit'[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh'
zinit light romkatv/powerlevel10k

# zmodload zsh/zprof    # debug

# homebrew bin path
export PATH=/opt/homebrew/bin:/opt/homebrew/sbin:$PATH

export HISTFILE=$TRU_HISTFILE
export HISTSIZE=500000
export SAVEHIST=100000

# https://github.com/Aloxaf/fzf-tab/issues/167#issuecomment-737235400

autoload -Uz compinit; compinit
zinit cdreplay -q
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
zstyle ':fzf-tab:*' switch-group ',' '.'

#unalias h

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

# end if dumb
fi
