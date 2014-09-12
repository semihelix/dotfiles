#!/bin/sh
xdotool search $* | xargs -0 xprop -id
