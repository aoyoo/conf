#!/bin/bash
if [ -z $1 ];then
    ps -efF | awk '{if ($1 == 503) print $0}' | grep -v "echo.sh" | grep -v "ps -efF" | grep -v "awk {if (\$1 == 503)" | grep -v "\-bash" | grep -v "sshd: wangliang24@pts" | grep -v "tmux new -s" | grep -v "tmux attach" | grep -v "baas_user=wangliang24" | grep -v "/bin/bash -l" | grep -v mysqld
    #ps -efF | awk '{if ($1 == 28845) print $0}' | grep -v "echo.sh" | grep -v "ps -efF" | grep -v "awk {if (\$1 == 28845)" | grep -v "\-bash" | grep -v "sshd: wangliang24@pts" | grep -v "tmux new -s" | grep -v "tmux attach" | grep -v "baas_user=wangliang24" | grep -v "/bin/bash -l"
elif [ $1 == "all" ];then
     ps -efF | awk '{if ($1 == 503) print $0}' 
fi
