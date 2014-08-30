#/!bin/sh

# Set X defaults
xrdb -merge ~/.Xresources &

# set caps to esc
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &

# acticates numlock
numlockx &

# sync clipboards
autocutsel &
autocutsel -s PRIMARY & 

# Load BG
. ~/.fehbg &

# Set keyboard keypress rate & kill bell
xset r rate 250 25 &
xset b off &

exec spectrwm
