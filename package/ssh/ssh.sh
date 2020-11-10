#!/bin/bash
PS3='Please enter your choice: '
options=("update" "replace" "exit")
select opt in "${options[@]}"
do
    case $opt in
        "update")
            wget https://raw.githubusercontent.com/Stepulin/general/master/package/ssh/ssh_update.sh && bash ssh_update.sh
            ;;
        "replace")
            wget https://raw.githubusercontent.com/Stepulin/general/master/package/ssh/ssh_replace.sh && bash ssh_replace.sh
            ;;
        "exit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done
