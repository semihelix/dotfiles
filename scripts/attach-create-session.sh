#!/bin/bash
tmux attach-session -t $* || tmux new-session -s $*
