#!/bin/bash

for file in ./.*; do
  if [ -f $file ]; then
    ln -fs ~/dotfiles/$file ~
  fi
done
