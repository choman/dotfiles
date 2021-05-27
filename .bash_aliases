alias uu="sudo apt-fast update ; sudo apt-fast dist-upgrade -y"
alias clean="sudo apt autoclean ; sudo apt autoremove -y"
alias ug="sudo update-grub2"
alias apt-get="apt-fast"
alias rok="sudo apt-get remove --purge $(dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d')"
alias bino="/usr/local/bin/bino -i mono -o left-right "
alias shellshock="curl https://shellshocker.net/shellshock_test.sh | bash"
alias vim_update="(cd ; curl http://j.mp/spf13-vim3 -L -o - | sh ); stty sane"
alias gitcheck="~/scripts/gitcheck"
alias telegram="nohup ~/bin/Telegram/Telegram &"
alias freeter="nohup ~/bin/Freeter.AppImage &"
alias turtl="nohup /opt/turtl/turtl &"
alias vdiadmin="sudo -i -u vdiadmin"
alias telegram="nohup $HOME/Telegram/Telegram &"
alias wire="nohup /opt/Wire/wire &"

##alias python=/usr/bin/python3
##alias pip=/usr/bin/pip3

if [ -d ~/goto ]; then
    alias g="goto"
fi

if [ -x "$HOME/.git-open/git-open" ]; then
   alias git-open="$HOME/.git-open/git-open"
fi

alias wtoday="curl http://wttr.in"
