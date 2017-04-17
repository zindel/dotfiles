# {{{ oh-my-zsh
export ZSH=/Users/zindel/.oh-my-zsh
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
source $ZSH/oh-my-zsh.sh
# }}}

# {{{ GLOBAL Environment variables: PATH, LC_ALL, etc
export PATH="/Users/zindel/bin:/Users/zindel/.cabal/bin:/usr/local/texlive/2015basic/bin/x86_64-darwin/:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export LC_COLLATE=C
# }}}

# {{{ Prompt
setopt prompt_subst
export PS1='%{$fg[blue]%}%~%{$reset_color%} %{$fg[green]%}$(vcprompt --format="[%b]")%{$reset_color%}$ '
# }}}

# {{{ virtualenvwrapper
export WORKON_HOME=/Users/zindel/dev
source /usr/local/bin/virtualenvwrapper.sh
if [ -n "$VIRTUAL_ENV" ]; then
    workon `basename $VIRTUAL_ENV`
fi
# }}}

# {{{ Octave support
export FONTCONFIG_PATH=/opt/X11/lib/X11/fontconfig
# }}}

# {{{ Aliases
alias pe="pip install -e"
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias tvim="tmux new-window -c \`pwd\` nvim"
alias vim="nvim"
# }}}

# {{{ NeoVim as terminal manager (obsolete)
nv() {
    nvim -c 'exe ":set nosplitright | :vsplit | :set splitright | :terminal"'
}
# }}}

# {{{ OCAML support
. /Users/zindel/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
eval `opam config env`;
# }}}

# {{{ $CHDIR: if set - go there
if [ -n "$CHDIR" ]; then
    cd $CHDIR
fi
# }}}

# {{{1 tmux support

# {{{2 'v' command: open nvim in left split or move there

v() {
    [ -z "$TMUX" ] && echo "not in tmux" && exit 1
    PANE=`get_vim_pane`

    if [ -z "$PANE" ]; then
        tmux split-window -h -c `pwd` nvim
        while [ -z "$PANE" ]; do
            PANE=`get_vim_pane`
        done
        NEW="yes"
    else
        NEW=""
    fi
    tmux select-pane -t:.$PANE

    if [ -n "$1" ]; then
        if [ -n "$NEW" ]; then
            CMD=":e"
        else
            CMD=":sp"
        fi
        tmux send-keys -t:.$PANE Escape Escape "$CMD $(realpath $1)" Enter
    fi
}

get_vim_pane() {
    tmux list-panes -F "#{pane_index} #{pane_current_command}" \
          | grep nvim \
          | awk '{print $1}'
}
# 2}}}

# {{{2 's' command: easy create/swicth tmux sessions
s() {
    if [ -n "$1" ]; then
        SESSION=`tmux list-sessions -F "#{session_name}" | grep "^$1$"`
        if [ -n "$SESSION" ]; then
            if [ -n "$TMUX" ]; then
                tmux switch-client -t $SESSION
            else
                tmux attach -t $SESSION
            fi
        else
            SESSION="$1"
            if [ -n "$TMUX" ]; then
                tmux new -d -s $SESSION
                tmux switch-client -t $SESSION
            else
                tmux new -s $SESSION
            fi
        fi
    else
        if [ -n "$TMUX" ]; then
            CMD="switch-client"
        else
            CMD="attach"
        fi

        if `tmux has-session`; then
            S=`tmux list-sessions | fzf | cut -f1 -d:`
            tmux "$CMD" -t "$S"
        else
            echo "No sessions. Enter name to create one"
        fi
    fi
}
# 2}}}

# {{{2 'fd' command: fancy cd to children paths
fd() {
    local dir
    dir=$(find ${1:-.} -path '*/\.*' -prune \
					   -o -type d -print 2> /dev/null | fzf +m) && cd "$dir"
}
# 2}}}

# {{{2 'fdr' command: fancy cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(realpath "${1:-$PWD}") | fzf)
  cd "$DIR"
}
# 2}}}

# {{{2 make sure to workon <env> if session_name == <env>
if [ -n "$TMUX" ]; then
    S=`tmux display-message -p '#{session_name}'|tr -d '[:space:]'`
    if [ -d "$WORKON_HOME/$S" ]; then
        workon $S
    fi
fi
# 2}}}



# 1}}}

# {{{1 misc utilities
# {{{2 'co': list terminal colors
co() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
    done
}
# 2}}}
# 1}}}

# {{{1 git utilities
ghpages() {
    URL=`git config --get remote.origin.url`
    if [ -n "$URL" ]; then
        git clone --branch gh-pages --single-branch "$URL" gh-pages
    fi
}

ghpublish() {
    cd gh-pages \
        && git add -A \
        && git commit -m 'update pages' \
        && git push origin gh-pages \
        && cd ..
}
# }}}

# vim: foldmethod=marker:
