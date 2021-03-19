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

if [ -f "$HOME/.work" ]; then
   echo "setting yadm class"
   yadm config local.class work
fi

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

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -alF'
#alias la='ls -A'
#alias l='ls -CF'
alias ll='ls -lAh'
alias llc='clear;ls -lAh'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f "${HOME}/.bash_aliases" ]; then
    source ${HOME}/.bash_aliases
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

install_starship() {
  curl -fsSL https://starship.rs/install.sh | bash
}

install_croc() {
  curl https://getcroc.schollz.com | bash
}

install_poetry() {
  poetry_url="https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py"
  curl -sSL ${poetry_url} | python -
}

transfer() { 
    if [ $# -eq 0  ]; then
        echo "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md";
        return 1;
    fi

    tmpfile=$( mktemp -t transferXXX  );

    if tty -s; then
        basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g');
        curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile;
    else
        curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile ;
    fi;
    cat $tmpfile;
    rm -f $tmpfile;
} 

if [ -x "~/bash-git-prompt/gitprompt.sh" ]; then
   # Set config variables first
   GIT_PROMPT_ONLY_IN_REPO=1

   # GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status

   # GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
   # GIT_PROMPT_SHOW_UNTRACKED_FILES=all # can be no, normal or all; determines counting of untracked files

   # GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10

   # GIT_PROMPT_START=...    # uncomment for custom prompt start sequence
   # GIT_PROMPT_END=...      # uncomment for custom prompt end sequence

   # as last entry source the gitprompt script
   # GIT_PROMPT_THEME=Custom # use custom .git-prompt-colors.sh
   # GIT_PROMPT_THEME=Solarized # use theme optimized for solarized color scheme
   #GIT_PROMPT_THEME=Single_line_Ubuntu
   source ~/bash-git-prompt/gitprompt.sh
fi

export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin:$HOME/.local/bin
export GOPATH=$HOME/go-programs
export PATH="$PATH:$GOPATH/bin"

[[ -s "/home/choman/.gvm/scripts/gvm" ]] && source "/home/choman/.gvm/scripts/gvm"
[[ -r /home/choman/.byobu/prompt ]] && . /home/choman/.byobu/prompt   #byobu-prompt#
## 
[[ -d "/home/choman/.dotfiles/bin" ]]  && PATH="$PATH:/home/choman/.dotfiles/bin"
[[ -d "/home/choman/.cargo/bin" ]]  && PATH="$PATH:/home/choman/.cargo/bin"
[[ -d "/home/choman/.local/bin" ]]  && PATH="$PATH:/home/choman/.local/bin"

if [ ! -d "$HOME/goto" ]; then 
    source ~/.local/bin/bashmarks.sh
    source ~/bashmarks/bashmarks.sh
else
    source ~/goto/goto.sh
fi


if [ $TILIX_ID  ] || [ $VTE_VERSION  ]; then
    [[ -f  /etc/profile.d/vte.sh ]] && source /etc/profile.d/vte.sh || echo "File not found: /etc/profile.d/vte.sh"
fi


for i in $(ls /home/choman/.bash_completion.d)
do
    source /home/choman/.bash_completion.d/$i
done

##chmod +x ~/.vocab
##~/.vocab

# Hook for desk activation
[ -n "$DESK_ENV" ] && source "$DESK_ENV" || true

which direnv > /dev/null
if [ $? -eq 0 ]; then
    eval "$(direnv hook bash)"
fi

which aliases > /dev/null
if [ $? -eq 0 ]; then
    eval "$(aliases init --global)"
fi

#
#  NODE VERSION MANAGER
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

which starship > /dev/null
if [ $? -eq 0 ]; then 
  eval "$(starship init bash)"
fi

### Bashhub.com Installation.
### This Should be at the EOF. https://bashhub.com/docs
if [ -f ~/.bashhub/bashhub.sh ]; then
    source ~/.bashhub/bashhub.sh
fi

MCFLY_BASH="./.cargo/registry/src/github.com-1ecc6299db9ec823/mcfly-0.3.6/mcfly.bash"
[[ -r "${MCFLY_BASH}" ]] && source ${MCFLY_BASH}

# Source goto
[[ -s "/usr/local/share/goto.sh" ]] && source /usr/local/share/goto.sh
[[ -x "/usr/local/bin/jira" ]] && eval "$(jira --completion-script-bash)"
[[ -x "/usr/local/bin/starship" ]] && eval "$(starship init bash)"
[[ -x "/usr/local/bin/gopass" ]] && eval "$(gopass completion bash)"
[[ -x "/usr/local/bin/zoxide" ]] && eval "$(zoxide init bash)"
[[ -r "${HOME}/.poetry/env" ]] && source $HOME/.poetry/env


# >>>> Vagrant command completion (start)
. /opt/vagrant/embedded/gems/2.2.14/gems/vagrant-2.2.14/contrib/bash/completion.sh
# <<<<  Vagrant command completion (end)

[ -r "$HOME/.smartcd_config" ] && ( [ -n $BASH_VERSION ] || [ -n $ZSH_VERSION ] ) && source ~/.smartcd_config
