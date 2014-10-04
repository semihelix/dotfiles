#/!bin/sh

# Load BG
. ~/.fehbg &

# Set X defaults
xrdb -merge ~/.Xresources &

# Load eye candy
sleep 2s && compton &

~/bin/autostart.sh &

# set caps to esc
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape' &

# Set  numlock on
numlockx &

# sync clipboards
autocutsel &
autocutsel -s PRIMARY &

# Set mouse pointer
xsetroot -cursor_name left_ptr &

# Set keyboard keypress rate & kill bell
xset r rate 250 25 &
xset b off &


exec xmonad
