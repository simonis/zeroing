#!/bin/bash

export MYPATH=$(dirname $(realpath -s $0))

XDG_CONFIG_HOME=$MYPATH/.config_xdg terminator --no-dbus --profile zeroing --layout CRIU &
