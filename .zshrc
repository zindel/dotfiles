# {{{ oh-my-zsh
export ZSH=/Users/zindel/.oh-my-zsh
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
source $ZSH/oh-my-zsh.sh
# }}}

# {{{ GLOBAL Environment variables: PATH, LC_ALL, etc
export PATH="/Users/zindel/bin:/usr/local/texlive/2015basic/bin/x86_64-darwin/:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
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
    PANE=`tmux list-panes -F "#{pane_index} #{pane_current_command}" | grep nvim | awk '{print $1}'`

    if [ -n "$PANE" ]; then
        tmux select-pane -t:.$PANE
    else
        tmux split-window -h -c `pwd` nvim
    fi
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

# 1}}}

# vim: foldmethod=marker:
