#!/bin/bash
ssh antman.it tail -n0 -f ~/notify/notify.log | while read msg; do notify-send "$msg"; aplay ~/media/sfx/robot_blip.wav; done
