#/!bin/sh

# Load BG
. ~/.fehbg &

# Set X defaults
xrdb -merge ~/.Xresources &

# Load eye candy
compton &

# set caps to esc
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &

# acticates numlock
numlockx &

# sync clipboards
autocutsel &
autocutsel -s PRIMARY &

# Load conky bar
dzen-conky.sh &

# Set keyboard keypress rate & kill bell
xset r rate 250 25 &
xset b off &

exec spectrwm
