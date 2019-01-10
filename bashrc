# .bashrc

# User specific aliases and functions

# Source global definitions
if [ -f /etc/bashrc ]; then
    |   . /etc/bashrc
fi

[[ -s "/home/users/wangliang24/.jumbo/etc/bashrc" ]] && source "/home/users/wangliang24/.jumbo/etc/bashrc"
#export LD_LIBRARY_PATH=/home/users/wangliang24/.jumbo/lib:$LD_LIBRARY_PATH

alias sl='ls'
alias mua='tmux attach'
alias bbuild='bcloud build --update 2>&1 | tee bbuild.log'
alias bmake='make -j4 2>&1 | tee bmake.log'
alias golocal='sh local.sh 2>&1 | tee err.log'

alias g++_482='/opt/compiler/gcc-4.8.2/bin/g++'
alias gdb_482='/opt/compiler/gcc-4.8.2/bin/gdb'

alias "bgitpush"="git push -u origin HEAD:refs/for/master"

export EDITOR=vim
export SVN_EDITOR=vim

export PATH=$HOME/usr/bin:/usr/local/bin:/sbin/:/opt/compiler/gcc-4.8.2/bin/:$PATH
export PATH=$HOME/usr/bin:$PATH
#export LD_LIBRARY_PATH=/home/users/wangliang24/project/wangliang24/app\-test/ecom/im/common/utlib/output/lib:$LD_LIBRARY_PATH
export PYTHONIOENCODING=gbk

#ARTISTIC_STYLE_OPTIONS=~/.astylerc
#alias astyle="astyle --style=attach --convert-tabs --indent=spaces=4 --add-brackets \
#--pad-header --unpad-paren --pad-oper --max-code-length=100 --formatted --align-pointer=type \
#--align-reference=type --break-blocks -Y"

alias astyle="astyle --style=attach --convert-tabs --indent=spaces=4 --add-brackets \
    --pad-header --unpad-paren --pad-oper --max-code-length=100 --formatted --align-pointer=type \
    --align-reference=type --break-blocks -Y"

[[ -s "/home/users/wangliang24/.bash_git_ps1.sh" ]] && source "/home/users/wangliang24/.bash_git_ps1.sh"
[[ -s "/home/users/wangliang24/.git-completion.bash" ]] && source "/home/users/wangliang24/.git-completion.bash"
