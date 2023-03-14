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

# Ref: https://cli.github.com/manual/gh_completion
compinit -i
