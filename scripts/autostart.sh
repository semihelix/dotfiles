#!/bin/bash

tmux new-session -d -s chat 'ssh antman.it -t tmux a -t profanity'
tmux new-session -d -s system
tmux new-session -d -s editor 'vim'
bin/antman_notify.sh &
tmux new-session -d -s rt -n torrent "rtorrent -i $(curl -s icanhazip.com)"
