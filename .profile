# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

##export PYENV_ROOT="$HOME/.pyenv"
##export PATH="$PYENV_ROOT/bin:$PATH"
##export PATH="${PYENV_ROOT}/versions/${PYTHON_VERSION}/bin:${PATH}"
#

source_if_exists() {
   file=$1

   [[ -f "${file}" ]] && source "${file}"
}

# if running bash
if [[ -n "$BASH_VERSION" ]]; then
    # include .bashrc if it exists
    source_if_exists ${HOME}/.bashrc
##    if [ -f "$HOME/.bashrc" ]; then
##	. "$HOME/.bashrc"
 ##   fi
fi

# set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/bin" ]] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/.local/bin" ]] ; then
    PATH="$HOME/.local/bin:$PATH"
fi


#eval "$(pyenv init --path)"  
#. "$HOME/.cargo/env"
