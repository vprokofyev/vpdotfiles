# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Trim dir
PROMPT_DIRTRIM=4

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#parse_git_branch(){
    #git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
#}

git_branch() {
    # -- Finds and outputs the current branch name by parsing the list of
    #    all branches
    # -- Current branch is identified by an asterisk at the beginning
    # -- If not in a Git repository, error message goes to /dev/null and
    #    no output is produced
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# ✘
# ✓
git_status() {
    # Outputs a series of indicators based on the status of the
    # working directory:
    local status="$(git status --porcelain 2>/dev/null)"
    local output=''
    # default marks
    # + changes are staged and ready to commit
    [[ -n $(egrep '^[MADRC]' <<<"$status") ]] && output="$output+"
    # ! unstaged changes are present
    [[ -n $(egrep '^.[MD]' <<<"$status") ]] && output="$output!"
    # ? untracked files are present
    [[ -n $(egrep '^\?\?' <<<"$status") ]] && output="$output?"
    # S changes have been stashed
    [[ -n $(git stash list) ]] && output="${output}S"
    # P local commits need to be pushed to the remote
    [[ -n $(git log --branches --not --remotes) ]] && output="${output}\033[1;32mP\033[0;90m"
    [[ -n $output ]] && output="|$output"  # separate from branch name
    echo $output
}

git_color() {
    # Receives output of git_status as argument; produces appropriate color
    # code based on status of working directory:
    # - White if everything is clean
    # - Green if all changes are staged
    # - Red if there are uncommitted changes with nothing staged
    # - Yellow if there are both staged and unstaged changes
    local staged=$([[ $1 =~ \+ ]] && echo yes)
    local dirty=$([[ $1 =~ [!\?] ]] && echo yes)
    if [[ -n $staged ]] && [[ -n $dirty ]]; then
        echo -e '\033[1;33m'  # bold yellow
    elif [[ -n $staged ]]; then
        echo -e '\033[1;32m'  # bold green
    elif [[ -n $dirty ]]; then
        echo -e '\033[1;31m'  # bold red
    else
        #echo -e '\033[1;37m'  # bold white
        echo -e '\033[0;90m'  # intense white
    fi
}


git_prompt() {
    # First, get the branch name...
    local branch=$(git_branch)
    # Empty output? Then we're not in a Git repository, so bypass the rest
    # of the function, producing no output
    if [[ -n $branch ]]; then
        local state=$(git_status)
        local color=$(git_color $state)
        # Now output the actual code to insert the branch and status
        echo -e "\x01$color\x02($branch$state)\x01\033[00m\x02"  # last bit resets color
    fi
}


# Sample prompt declaration based off of the default Ubuntu 14.04.1 color
# prompt. Tweak as you see fit, or just stick "$(git_prompt)" into your
# favorite prompt.
#PS1='$debian_chroot\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(git_prompt)'



if [ "$color_prompt" = yes ] && [ $(id -u) -eq 0 ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;00m\]\u@\h\[\033[00m\]:\[\033[01;00m\]\w\[\033[32m\]`git_prompt`\[\033[1;31m\]# \[\e[m\]'
else
    # change to $ at the end if non-root user
    PS1='${debian_chroot:+($debian_chroot)}\[\033[1;32m\]\u@\h\[\033[00m\]:\[\033[01;00m\]\w\[\033[32m\]`git_prompt`\[\033[1;35m\]$ \[\e[m\]'
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
#case "$TERM" in
#xterm*|rxvt*)
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    #;;
#*)
    #;;
#esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

###############################################################################
# User Variables
###############################################################################
EDITOR=/usr/bin/vim
TZ='Europe/Moscow'
export TZ
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim
export TERM=xterm-256color
export TMUX_PLUGIN_MANAGER_PATH=~/.tmux/plugins/tpm
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin
export PATH="$PATH:$HOME/.vim/bundle/vim-superman/bin"
export FZF_DEFAULT_COMMAND="fdfind . $HOME"
#export FZF_DEFAULT_COMMAND="rg --files --no-ignore-vcs --hidden --follow --glob '!.git/*'"

# virtualenvwrapper settings
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
#export WORKON_HOME=$HOME/.virtualenvs
#export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.local/bin/virtualenv
#source ~/.local/bin/virtualenvwrapper.sh

# Docker
#export PATH=/home/user/bin:$PATH
#export DOCKER_HOST=unix:///run/user/1000/docker.sock
#export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

###############################################################################
# Aliases
###############################################################################
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias configsync='cd ~ && dotfiles pull'
alias man='vman'
alias :q='exit'
alias tx='tmuxinator'
alias txas='tmux attach-session -t'
alias txls='tmux list-sessions'
alias txlw='tmux list-windows'
alias txks='tmux kill-session -t'
alias diff='diff --color'
#alias ls='exa -r -g -B --color never --no-icons --group-directories-first --header'
alias fd='fdfind'

#alias zl='zellij -c ~/.config/zellij/config.kdl -l welcome'
#alias zls='zellij list-sessions'
#alias zas='zellij attach'
#alias zks='zellij kill-session'
#alias zkas='zellij kill-all-sessions'
#alias zds='zellij delete-session'
#alias zdas='zellij delete-all-sessions'

alias fvim='vim $(fzf --preview="batcat {} --style=plain")'
alias fcat='fzf --preview="batcat {} --style=plain"'

complete -o default -o nospace -F _man vman
. /usr/share/bash-completion/completions/man

###############################################################################
# Source external files
###############################################################################
#source ~/fzf-key-bindings.bash
#source /usr/share/bash-completion/completions/fzf

#eval "$(zellij setup --generate-auto-start bash)"
#. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for Yandex Cloud CLI.
if [ -f '/home/vp/yandex-cloud/path.bash.inc' ]; then source '/home/vp/yandex-cloud/path.bash.inc'; fi

# The next line enables shell command completion for yc.
if [ -f '/home/vp/yandex-cloud/completion.bash.inc' ]; then source '/home/vp/yandex-cloud/completion.bash.inc'; fi

#export PATH=$PATH:$HOME/go/bin
