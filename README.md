# Raspberry-Pi-Shell-Button-Shutdown
Shutdown or Restart Pi with shell script (kernel 6.6) libgpiod

The shell scripts here are written with basic hacky coding skills and are not meant for produlction or commercial use.  These sripts are for educational use as an example.
Create a folder in the usr directory
sudo mkdir /usr/scripts #scripts dir created.
cp the shell scripts into this directory (or the directory of your choosing).
Go to /etc
Edit rc.local
sudo nano /etc/rc.local

add your shell execute command at the end above exit 0 with an ambersand (&) or above other commands with an ambersand (&)
like this :

#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

timedatectl set-ntp true &
sh /usr/scripts/test7.sh &
exit 0

Or like this 

sh /usr/scripts/test7.sh &
timedatectl set-ntp true
exit 0
