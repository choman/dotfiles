# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

if [[ -f "$HOME/.config/work" ]]; then
   echo "setting yadm class"
   yadm config local.class work
fi

# append to the history file, don't overwrite it
shopt -s cdspell # correct dir spellings
shopt -q -s cmdhist #make multi-line commands line in history
shopt -s checkwinsize # make sure display is updated when terminal is resized
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
##shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar
#


############################################
# functions
############################################
source_if_exists() {
   file2source=$1
   [[ -f "${file2source}" ]] && source "${file2source}" || printf "${RED}ERROR${NC}: File not found: ${file2source}\n"
}

############################################
#    XDG_CONFIG
############################################
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_STATE_HOME="${HOME}/.local/state"
export XDG_CACHE_HOME="${HOME}/.cache"


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'
alias la='ls -A'
alias llc='clear;ls -lAh'
alias ll='ls -alF'
alias ll='ls -lAh'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

source_if_exists ~/.bash_aliases

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

###install_poetry() {
###  poetry_url="https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py"
###  curl -sSL ${poetry_url} | python -
###}

export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin:$HOME/.local/bin
export GOPATH=$HOME/go-programs
export PATH="$PATH:$GOPATH/bin"

source_if_exists "${HOME}/gvm/scripts/gvm"
source_if_exists "${HOME}/byobu/prompt"

## 
[[ -d "${HOME}/dotfiles/bin" ]]  && PATH="$PATH:${HOME}/dotfiles/bin"
[[ -d "${HOME}/cargo/bin" ]]  && PATH="$PATH:${HOME}/cargo/bin"
[[ -d "${HOME}/local/bin" ]]  && PATH="$PATH:${HOME}/local/bin"

##if [ ! -d "$HOME/goto" ]; then 
##    source ~/.local/bin/bashmarks.sh
##    source ~/bashmarks/bashmarks.sh
##else
##    source ~/goto/goto.sh
##fi

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

if [ $TILIX_ID  ] || [ $VTE_VERSION  ]; then
    source_if_exists "/etc/profile.d/vte.sh"
fi



##chmod +x ~/.vocab
##~/.vocab

# Hook for desk activation
[ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

#
#  NODE VERSION MANAGER
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### Bashhub.com Installation.
### This Should be at the EOF. https://bashhub.com/docs
if [ -f ~/.bashhub/bashhub.sh ]; then
    source ~/.bashhub/bashhub.sh
fi

##MCFLY_BASH="./.cargo/registry/src/github.com-1ecc6299db9ec823/mcfly-0.3.6/mcfly.bash"
##[[ -r "${MCFLY_BASH}" ]] && source ${MCFLY_BASH}


VAGRANT_VERSION=
if [[ -x "$(which vagrant)" ]]; then
    VAGRANT_VERSION=$(vagrant --version| awk '{print $2}')
    VAGRANT_BASE="/opt/vagrant/embedded/gems/${VAGRANT_VERSION}"

    if [[ -d "${VAGRANT_VASE}" ]]; then 
        # >>>> Vagrant command completion (start)
        . ${VAGRANT_BASE}/gems/vagrant-${VAGRANT_VERSION}/contrib/bash/completion.sh
        # <<<<  Vagrant command completion (end)
    fi
fi

[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config


# awesome command shell hooks
###[[ -s "/usr/local/share/goto.sh" ]] && source /usr/local/share/goto.sh

# Source awesome command completions
#[[ -x "$(which pipenv)" ]] && eval "$(_PIPENV_COMPLETE=bash_source pipenv)"
#[[ -x "$(which pipenv)" ]] && eval "$(pipenv --completions)"

# This churns through files in $HOME/.bashrc.d if they are executable.
BASHRCD="${HOME}/.bashrc.d"
if [[ -d "${BASHRCD}" ]]; then
   echo "sourcing: ${BASHRCD}"
   for file in ${BASHRCD}/* ; do
      if [[ "${file##*/}" != "bashrc.init" ]]; then
         test -f "$file" || continue
         test -x "$file" || continue
	 echo " - ${file}"
	 source_if_exists "${file}"
      fi
   done
   unset file
fi

BASH_COMPLETIONS="${HOME}/.bash_completion.d"
if [[ -d "${BASH_COMPLETIONS}" ]]; then
   for file in $(ls ${BASH_COMPLETIONS})
   do 
       echo " - Sourcing ${file}"
       source_if_exists "${BASH_COMPLETIONS}/${file}"
   done
   unset file
fi

source_if_exists "$HOME/.cargo/env"

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Path to the bash it configuration
export BASH_IT="/home/choman/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
export BASH_IT_THEME='bobby'

# Some themes can show whether `sudo` has a current token or not.
# Set `$THEME_CHECK_SUDO` to `true` to check every prompt:
#THEME_CHECK_SUDO='true'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# (Advanced): Change this to the name of the main development branch if
# you renamed it or if it was changed for some reason
# export BASH_IT_DEVELOPMENT_BRANCH='master'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to the location of your work or project folders
#BASH_IT_PROJECT_PATHS="${HOME}/Projects:/Volumes/work/src"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true
# Set to actual location of gitstatus directory if installed
#export SCM_GIT_GITSTATUS_DIR="$HOME/gitstatus"
# per default gitstatus uses 2 times as many threads as CPU cores, you can change this here if you must
#export GITSTATUS_NUM_THREADS=8

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# If your theme use command duration, uncomment this to
# enable display of last command duration.
#export BASH_IT_COMMAND_DURATION=true
# You can choose the minimum time in seconds before
# command duration is displayed.
#export COMMAND_DURATION_MIN_SECONDS=1

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
# export BASH_IT_RELOAD_LEGACY=1

# Load Bash It
source_if_exists "$BASH_IT"/bash_it.sh

# Hook for desk activation
[ -n "$DESK_ENV" ] && source "$DESK_ENV" || true
