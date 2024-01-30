#!/bin/bash

export MYPATH=$(dirname $(realpath -s $0))

if [ -z "$1" ]; then
  LAYOUT="criu"
else
  LAYOUT=$1
fi

XDG_CONFIG_HOME=$MYPATH/.config_xdg terminator --no-dbus --profile zeroing --layout $LAYOUT &
