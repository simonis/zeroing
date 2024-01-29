#!/bin/bash

# See https://unix.stackexchange.com/questions/353386/when-is-a-multiline-history-entry-aka-lithist-in-bash-possible
# for why we need bash 5+ for multiline commands in the bash history file.
bash --noprofile --init-file <( echo ". $MYPATH/create_demo_shell.sh $1 $MYPATH")
