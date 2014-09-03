#!/bin/bash
#tmux -f /home/antman/.tmux.conf start-server
tmux new-session -d -s system
tmux new-session -d -s float
tmux new-session -d -s vim 'vim'
