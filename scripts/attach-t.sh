#!/bin/bash

var=$(tmux ls | grep -E "$1.+attached")

[[ "$var" == "" ]] && tmux a -t $1
