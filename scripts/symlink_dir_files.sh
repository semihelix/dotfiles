#!/bin/bash
shopt -s dotglob
if [ -z $* ]; then
  echo Enter path to symlink!
else
  count=0
  for file in *; do
    if [ -f $file ]; then
      ln -fs $(pwd)/$file $*
      count=$(($count+1))
    fi
  done
  echo $count files symlinked!
fi

