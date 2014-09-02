#!/bin/bash
if [ $1 -eq 1 ]; then
    notify-send "Claws Mail" "You've got $1 new mail!"
    echo is one
else
    notify-send "Claws Mail" "You've got $1 new mails!"
    echo is not one
fi
aplay /home/antman/media/sfx/youGotmail.wav
