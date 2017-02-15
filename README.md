# RaspberryVideoLooper

##Introduction
The small video_looper.sh script for a Raspberry PI continuously plays video files from USB stick.

This script was created to indefinitely show a set of videos on a trade show. An important 
requirement was that the display should be empty (black) in between videos and that no OSD menus
or information must be shown. Also, since my colleagues on the stand don't 

##Good to know

* The loop_videos.sh script will play videos found on an attached USB drive's "Movies" or "movies"
directory in alphabetical order.
* When the USB disk is removed, the script detects this and shuts the system down gracefully. 
The scripts detects it after the mediaplayer stops (because it cannot read the movie). It may take
some time (tens of seconds) before the mediaplayer finished playing it buffer.
* As this was to be used on a trade show __without sound__, the audio output device is set to local 
instead of the default "hdmi". So unless you attach something to the headphone jack, you won't hear
anything.
* In expects only one USB drive to be attached, which it will mount in read-only mode. If no USB 
drive is found, the script will mention this on stdout and exit.
* It expects one logical partition on the USB drive. The scripts looks for /dev/sd?1 to discover a
USB drive.

##Deployment

This is what I did on a Raspberry PI to use the script:

* Install Raspbian on the Raspberry PI (Jessie edition, but that is probably not very important)
* Via "sudo raspi-config" configure the board to login automatically without starting the GUI.
  __This is an important step__ as in this mode, Raspbian will not automatically mount USB drives, which is 
  something the script expects to do in it's own way.
* Copy loop_videos.sh to the home directory /home/pi
* Add "./loop_videos.sh" to /home/pi/.profile

That's it! Happy video looping!
