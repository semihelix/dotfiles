#/!bin/sh

# Load BG
. ~/.fehbg &

# Set X defaults
xrdb -merge ~/.Xresources &
#
# Load eye candy
xcompmgr &

# set caps to esc
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &

# acticates numlock
numlockx &

# sync clipboards
autocutsel &
autocutsel -s PRIMARY &

# Load conky bar
conky &

(sleep 0.5s && urxvt -name WS3 -e vim) &
(sleep 1s && transset-df 0.85 -i $(xdotool search WS3)) &

# Set keyboard keypress rate & kill bell
xset r rate 250 25 &
xset b off &

exec spectrwm
