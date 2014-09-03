#!/bin/bash
# Wallpaper changing script

case "$1" in
  "") wp_path=~/media/wallpapers/brown/ ;;
  *)  wp_path=$* ;;
esac

array=($wp_path/*.jpg)
size=$(( $(ls -l $wp_path | wc -l) -1 ))

randomize() {
  index=$(( $RANDOM%$size ))
  [ -f ~/bin/.change_wallpaper.storage ] &&
  read last_index < ~/bin/.change_wallpaper.storage &&
  while [[ $index -eq $last_index ]]; do
      index=$(( $RANDOM%$size ))
  done
}

case "$size" in
  0) echo No JPG files found in dir!
     exit ;;
  1) index=0 ;;
  *) randomize ;;
esac


echo $index > ~/bin/.change_wallpaper.storage
cp ${array[$index]} ~/media/wallpapers/wallpaper.jpg
env DISPLAY=:0 /bin/bash ~/.fehbg


