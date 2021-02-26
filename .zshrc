# {{{ oh-my-zsh
export ZSH=/Users/zindel/.oh-my-zsh
ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
source $ZSH/oh-my-zsh.sh
# }}}

# {{{ GLOBAL Environment variables: PATH, LC_ALL, etc
export PATH="/Users/zindel/bin:/Users/zindel/.local/bin:/Users/zindel/.cabal/bin:/usr/local/texlive/2015basic/bin/x86_64-darwin/:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:./local/texlive/2018basic/bin/x86_64-darwin/:$PATH"
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export LC_COLLATE=C

export PATH="/usr/local/opt/postgresql@9.4/bin:$PATH"
export GPG_TTY=$(tty)
# }}}

# {{{ Prompt
setopt prompt_subst
export PS1='%{$fg[blue]%}%~%{$reset_color%} %{$fg[green]%}$(vcprompt -f "[%b]")%{$reset_color%}$ '
# }}}

# {{{ pyenv / virtualenvwrapper
# export PATH="/Users/zindel/.pyenv/shims:${PATH}"
# export PYENV_SHELL=zsh
# source '/usr/local/Cellar/pyenv/1.2.7/libexec/../completions/pyenv.zsh'
# pyenv() {
#   local command
#   command="${1:-}"
#   if [ "$#" -gt 0 ]; then
#     shift
#   fi

#   case "$command" in
#   rehash|shell)
#     eval "$(pyenv "sh-$command" "$@")";;
#   *)
#     command pyenv "$command" "$@";;
#   esac
# }

# eval "$(pyenv init -)"
# eval "$(pyenv virtualenv-init -)"

# export WORKON_HOME=$HOME/dev
# source ~/.pyenv/versions/2.7.15/bin/virtualenvwrapper.sh
# if [ -n "$VIRTUAL_ENV" ]; then
#     workon `basename $VIRTUAL_ENV`
# fi

# # Tell pyenv-virtualenvwrapper to use pyenv when creating new Python environments
# export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"

# }}}

# {{{ Octave support
export FONTCONFIG_PATH=/opt/X11/lib/X11/fontconfig
# }}}

# {{{ Aliases
alias pe="pip install -e"
alias reload=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias tvim="tmux new-window -c \`pwd\` nvim"
alias vim="nvim"
# alias code="/Applications/Visual\\ Studio\\ Code.app/Contents/Resources/app/bin/code"

alias fpack=/Users/zindel/ocaml/fastpack/_build/default/bin/fpack.exe
alias fpack-current=/Users/zindel/ocaml/fastpack-watch-refactor/_build/default/bin/fpack.exe
# }}}

# {{{ OPAM support
test -r /Users/zindel/.opam/opam-init/init.zsh && . /Users/zindel/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
# eval $(opam config env)
# eval $(opam env)
# export PATH="/usr/local/opt/m4/bin:$PATH"
# }}}

# {{{ Rust support
# source $HOME/.cargo/env
# }}}

# {{{ $CHDIR: if set - go there
if [ -n "$CHDIR" ]; then
    cd $CHDIR
fi
# }}}

# {{{1 tmux support

# {{{2 make sure to workon <env> if session_name == <env>
if [ -n "$TMUX" ]; then
    S=`tmux display-message -p '#{session_name}'|tr -d '[:space:]'`
    if [ -d "$WORKON_HOME/$S" ]; then
        workon $S
    fi
fi
# 2}}}

# {{{2 'v' command: open nvim in the right split or move there

v() {
    [ -z "$TMUX" ] && echo "not in tmux" && exit 1
    PANE=`get_vim_pane`

    if [ -z "$PANE" ]; then
        CMD='nvim'
        if [ -f esy.lock ] || [ -f esyi.lock.json ] || [ -f esy.lock.json ] || [ -d _esy ]; then CMD='esy nvim'; fi

        #
        CMD="VIRTUAL_ENV=$VIRTUAL_ENV $CMD"
        tmux split-window -h -c `pwd` $CMD
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
          | grep "nvim\|bash\|esyCommand\|esy.exe" \
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


# 1}}}

# {{{1
# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/usr/local/opt/fzf/shell/key-bindings.zsh"
# 1}}}

# {{{1 misc utilities
# {{{2 'co': list terminal colors
co() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
    done
}

dusort () {
    du -hs * | gsort -rh
}

# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}
# 2}}}


fzf-file-widget() {
  LBUFFER="${LBUFFER}$(__fsel)"
  local ret=$?
  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
  return $ret
}
zle     -N   fzf-file-widget
bindkey '^T' fzf-file-widget

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

# {{{ node 8
# export PATH="/usr/local/opt/node@8/bin:$PATH"
# export LDFLAGS="-L:/usr/local/opt/node@8/lib $LDFLAGS"
# export CPPFLAGS="-I/usr/local/opt/node@8/include $CPPFLAGS"
# }}}


# {{{1 nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# }}}


# fnm
# export PATH=$HOME/.fnm:$PATH
# eval "`fnm env --multi --use-on-cd`"

# vim: foldmethod=marker:
