
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PATH=/usr/bin/X11:$PATHexport PATH=/usr/sbin:$PATH
export PATH=/sbin:$PATH
#export PATH=/var/qmail/bin:$PATH
#export PATH=/usr/local/apache/bin:$PATH
export PATH=$HOME/bin:$PATH
export PATH=.:$PATH

#export CVSROOT=cvsadmin@moba-cvs:/home/cvsadmin/cvsrep
#export CVS_RSH=ssh

#source $HOME/.aliases

export PATH=/usr/local/bin:/usr/local/sbin:~/bin:$PATH
#eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)
source ~/perl5/perlbrew/etc/bashrc

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

export PERL_CPANM_OPT="--local-lib=$HOME/extlib"
export PERL5LIB=$HOME/extlib/lib/perl5:$PERL5LIB;
export PATH="$HOME/extlib/bin:$PATH"

alias ack="ack --pager='less -R -X'"
alias less="less -X"
alias graph='git log --graph -C -M --pretty=format:"<%h> %ad %Cgreen%d%Creset %s %C(black bold)[%an]%Creset" --all --date=short'
alias tmux="/usr/local/bin/tmux -2 -u"
alias vim="/usr/bin/vim -u $HOME/.vimrc"
alias from_unixtime="perl -e 'for(@ARGV){@t=localtime(\$_);printf(\"\$_\t%d/%02d/%02d %02d:%02d:%02d\n\",@t[5]+1900,@t[4]+1,@t[3],@t[2],@t[1],@t[0])}'"

# cpanm
export PERL_CPANM_OPT="--local-lib=~/perl5"
export PATH=$HOME/perl5/bin:$PATH;
export PERL5LIB=$HOME/perl5/lib/perl5:$PERL5LIB;
#export PERL_CPANM_OPT="--local-lib=~/extlib"
#export PERL5LIB="$HOME/extlib/lib/perl5:$HOME/extlib/lib/perl5/i386-linux-thread-multi:$PERL5LIB"

alias cp="cp -i"
alias rm="rm -i"
alias findmod="find `perl -e 'print join(" ", @INC)'` -type f -name \"*.pm\""

#git
#source /usr/local/Cellar/git/1.8.0/etc/bash_completion.d/git-completion.bash
#source /usr/local/Cellar/git/1.8.0/etc/bash_completion.d/git-prompt.sh
#source /usr/local/Cellar/git/1.8.1.5/etc/bash_completion.d/git-completion.bash
#source /usr/local/Cellar/git/1.8.1.5/etc/bash_completion.d/git-prompt.sh
source ~/git-completion.bash
source ~/git-prompt.sh
#PS1="\u@\h:\w\$(__git_ps1)> "
PS1="\u@\h:\w\$(__git_ps1)\n$ "

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

NODE_PATH=~/.nvm/v0.10.0/lib/node_modules; export NODE_PATH
source ~/.nvm/nvm.sh
nvm use "v0.10.0"
