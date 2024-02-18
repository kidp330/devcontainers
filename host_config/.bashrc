# $HOME/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return ;;
esac

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
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

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

# region prompt
PROMPT_HEAD=${PROMPT_HEAD:-'λ>'}
PROMPT_HEAD_COLOR=${PROMPT_HEAD_COLOR:-'\[\033[35m\]'}

prompt_components=(
    '${debian_chroot:+($debian_chroot)}' # if there's a chroot setup, add that to the prompt # __jm__ unanswered question, but why not ${debian_chroot:-} ?
    '\u@\h'                              # \u is user, \h is hostname
    ':'                                  #
    '\w'                                 # \w is $PWD
    ':'
    "$PROMPT_HEAD "
)

# Corresponding colors for prompt components
prompt_colors=(
    ''                   #
    '\[\033[01;32m\]'    # green
    ''                   #
    '\[\033[01;34m\]'    # blue
    ''                   #
    "$PROMPT_HEAD_COLOR" #
)

if [ "$color_prompt" = yes ]; then
    reset_colors='\[\033[0m\]'
    for index in "${!prompt_components[@]}"; do
        prompt_components[$index]="${prompt_colors[$index]}""${prompt_components[$index]}""$reset_colors"
    done
fi
# echo $prompt_components[@]
# .join components
PS1=$(
    IFS=''
    printf '%s' "${prompt_components[*]}"
)
unset color_prompt force_color_prompt
# endregion

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm* | rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
    *) ;;
esac

if [ -f $HOME/.bash_aliases ]; then
    . $HOME/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).

if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

# __jm__ custom additions

# this needs to be exported bc blahblah
if [[ -n "$HISTPERSIST" ]]; then
    export HISTSIZE=
    export HISTFILESIZE=
    export HISTTIMEFORMAT="[%F %T] "
fi

source $HOME/.bash_functions >&2
source $HOME/.bash_completions >&2

if [ "$(uname)" = "Darwin" ]; then
    source $HOME/.bash_osx
fi

export PATH=$HOME/bin:$PATH
