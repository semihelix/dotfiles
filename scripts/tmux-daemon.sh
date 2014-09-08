#!/bin/bash

tmux new-session -d -s system
tmux new-session -d -s vim 'vim'
tmux new-session -d -s notify "/home/antman/bin/antman_notify.sh"
tmux new-session -d -s rt -n torrent "rtorrent -i $(curl -s icanhazip.com)"
tmux new-session -d -s chat 'ssh antman.it -t tmux a -t profanity'
