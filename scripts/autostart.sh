#!/bin/bash

tmux new-session -d -s chat1 'ssh antman.it -t tmux a -t xmpp'
tmux new-session -d -s chat2 'ssh antman.it -t tmux a -t irc'
tmux new-session -d -s system
tmux new-session -d -s editor 'vim'
bin/antman_notify.sh &
tmux new-session -d -s rt -n torrent "rtorrent -i $(curl -s icanhazip.com)"
