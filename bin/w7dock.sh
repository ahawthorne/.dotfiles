#!/bin/bash -x

# Name: w7dock.sh
# Version: 1.0
# Description:  A program used to emulate the Windows 7 feature of resizing the window
# to fill the left half of the screen (accompanied by it's right half companion)
# Author: Nik Skoufis
# Edits: 
# homburg (1/22/2009) 
# Sean Kocol (1/29/2009)

# Usage: Best usage would be to setup a hotkey for both the left and
# right script. When the script is run, the active window will take up the left
# or right half of the screen.
# Pass the script an argument that corresponds to wich side of the screen you want
# the active window maximized to.
# e.g.: 
# w7dock.sh left
# w7dock.sh right
# w7dock.sh up
# w7dock.sh down

# Requirements: wmctrl (sudo apt-get install wmctrl) and any window manager that is
# compatible with wmctrl. Also xbindkeys and xbindkeys-config to set up a hotkey or
# use the commands function found under the general settings of Compiz.
# dependencies
# * wmctrl
# * xautomation (xmousepos)
# * xbindkeys{,-config}
# Notes: This version is specifically designed for my dual screen setup. I'm lazy
# and couldn't be bothered working out how to auto detect the screen resolution
# so you'll have to enter it yourself in the sections marked. This will only
# work if the selected window is not maximized. I just want to get this working
# at the moment so I'm not going to worry about it, but I'll try to fix it in 
# future versions if possible.

# Set screen resolution. Ignore the second set of values if you only have one screen.
# The last value is for users like me who have their two screens offset. This is the
# offset of the two screens as measured in distance between the bottom of the lower
# screen and the bottom of the higher screen. This only applies if you are using 
# Twinview.

COUNTER=0;
# get screen and resolution information
str=`xrandr | sed -e '/[^s]connected/!d' -e "s/.*connected\s\([0-9]*\)x\([0-9]*\)+\([0-9]*\)+\([0-9]*\).*/\1\n\2\n\3\n\4/"`;
for x in $str;
do
	case $COUNTER in
		0 ) screen0xres=$x;;
		1 ) screen0yres=$x;;
		2 ) screen0xoffset=$x;;
		3 ) screen0yoffset=$x;;
		4 ) screen1xres=$x;;
		5 ) screen1yres=$x;;
		6 ) screen1xoffset=$x;;
		7 ) screen1yoffset=$x;;
	esac
	((COUNTER++))
done;

# if the screens are not assigned correctly, swap them
if [ "$screen0xoffset" -ne "0" ]; then
	temp1=$screen0xres
	temp2=$screen0yres
	temp3=$screen0xoffset
	temp4=$screen0yoffset
	screen0xres=$screen1xres
	screen0yres=$screen1yres
	screen0xoffset=$screen1xoffset
	screen0yoffset=$screen1yoffset
	screen1xres=$temp1
	screen1yres=$temp2
	screen1xoffset=$temp3
	screen1yoffset=$temp4
fi

# This is used to compensate for the size of the frame (left/right). Guess until you get it
# right.  framecompy compensates for the size of the frame (up/down).

framecomp=0
framecompy=0

# This variable is used to check which screen the mouse is on. This next section
# should work even if you have only one screen.
xpos=`xmousepos | cut -d ' ' -f 1`

# not the prettiest, I know. Lots of redundancy, etc.  
# Probably should be a case statement
wmctrl -r :ACTIVE: -b remove,maximized_vert,maximized_horz;
if [ "$xpos" -lt "$screen0xres" ]; then
	if [ "$1" = "left" -o "$1" = "l" ]; then
		wmctrl -r :ACTIVE: -e 4,0,0,$[$screen0xres/2-$framecomp],$screen0yres
	elif [ "$1" = "right" ]; then
		wmctrl -r :ACTIVE: -e 4,$[$screen0xres/2+$framecomp],0,$[$screen0xres/2-$framecomp],$screen0yres
	elif [ "$1" = "up" ]; then
		wmctrl -r :ACTIVE: -e 4,0,0,$screen0xres,$[$screen0yres/2-$framecompy]
	elif [ "$1" = "down" ]; then
		wmctrl -r :ACTIVE: -e 4,0,$[$screen0yres/2+$framecompy],$screen0xres,$[$screen0yres/2-$framecompy]
	fi
	# wmctrl -r :ACTIVE: -b add,maximized_vert
else
	if [ "$1" = "left" -o "$1" = "l" ]; then
		wmctrl -r :ACTIVE: -e\
		4,$screen0xres,0,$[$screen1xres/2-$framecomp],$screen1yres
	elif [ "$1" = "right" ]; then
		wmctrl -r :ACTIVE: -e 4,$[$screen0xres+$screen1xres/2+$framecomp],0,$[$screen1xres/2-$framecomp],$screen1yres
	elif [ "$1" = "up" ]; then
		wmctrl -r :ACTIVE: -e 4,$screen0xres,0,$screen0xres,$[$screen0yres/2-$framecompy]
	elif [ "$1" = "down" ]; then
		wmctrl -r :ACTIVE: -e 4,$screen0xres,$[$screen0yres/2+$framecompy],$screen0xres,$[$screen0yres/2-$framecompy]
	fi
	# wmctrl -r :ACTIVE: -b add,maximized_vert
fi
