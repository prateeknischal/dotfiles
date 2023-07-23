#!/bin/bash

TMUX_CONFIG=https://raw.githubusercontent.com/prateeknischal/dotfiles/master/tmux.conf

# Setup tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
wget $TMUX_CONFIG -O ~/.tmux.conf

sed -i 's/.*default-shell.*//g' ~/.tmux.conf
