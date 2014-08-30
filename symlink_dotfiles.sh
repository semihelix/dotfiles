#!/bin/bash

for file in ./.*; do
  if [ -f $file ]; then
    ln -s $file ~
  fi
done
