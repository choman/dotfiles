
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/choman/.sdkman"
[[ -s "/home/choman/.sdkman/bin/sdkman-init.sh" ]] && source "/home/choman/.sdkman/bin/sdkman-init.sh"

compinit -d "$XDG_CACHE_HOME}/zsh/zcompdump-"$ZSH_VERSION"

