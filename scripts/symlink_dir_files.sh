#!/bin/bash
if [ -z $* ]; then
  echo Enter path to symlink!
else
  for file in *; do
    if [ -f $file ]; then
      ln -fs $(pwd)/$file $*
    fi
  done
fi

